//==============================================================================
// license.txt
//==============================================================================
/*
Copyright (C) 2011 Milo Yip

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

//==============================================================================
// rapidjson.h
//==============================================================================

// Copyright (C) 2011 Milo Yip
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#ifndef RAPIDJSON_RAPIDJSON_H_
#define RAPIDJSON_RAPIDJSON_H_

// Copyright (c) 2011 Milo Yip (miloyip@gmail.com)
// Version 0.1

/*!\file rapidjson.h
    \brief common definitions and configuration

    \see RAPIDJSON_CONFIG
 */

/*! \defgroup RAPIDJSON_CONFIG RapidJSON configuration
    \brief Configuration macros for library features

    Some RapidJSON features are configurable to adapt the library to a wide
    variety of platforms, environments and usage scenarios.  Most of the
    features can be configured in terms of overriden or predefined
    preprocessor macros at compile-time.

    Some additional customization is available in the \ref RAPIDJSON_ERRORS APIs.

    \note These macros should be given on the compiler command-line
          (where applicable)  to avoid inconsistent values when compiling
          different translation units of a single application.
 */

#include <cstdlib>  // malloc(), realloc(), free()
#include <cstring>  // memcpy()

///////////////////////////////////////////////////////////////////////////////
// RAPIDJSON_NO_INT64DEFINE

/*! \def RAPIDJSON_NO_INT64DEFINE
    \ingroup RAPIDJSON_CONFIG
    \brief Use external 64-bit integer types.

    RapidJSON requires the 64-bit integer types \c int64_t and  \c uint64_t types
    to be available at global scope.

    If users have their own definition, define RAPIDJSON_NO_INT64DEFINE to
    prevent RapidJSON from defining its own types.
*/
#ifndef RAPIDJSON_NO_INT64DEFINE
//!@cond RAPIDJSON_HIDDEN_FROM_DOXYGEN
#ifdef _MSC_VER

//==============================================================================
// msinttypes/stdint.h
//==============================================================================

// ISO C9x  compliant stdint.h for Microsoft Visual Studio
// Based on ISO/IEC 9899:TC2 Committee draft (May 6, 2005) WG14/N1124 
// 
//  Copyright (c) 2006-2013 Alexander Chemeris
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// 
//   1. Redistributions of source code must retain the above copyright notice,
//      this list of conditions and the following disclaimer.
// 
//   2. Redistributions in binary form must reproduce the above copyright
//      notice, this list of conditions and the following disclaimer in the
//      documentation and/or other materials provided with the distribution.
// 
//   3. Neither the name of the product nor the names of its contributors may
//      be used to endorse or promote products derived from this software
//      without specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
// WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
// EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
// OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
// OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// 
///////////////////////////////////////////////////////////////////////////////

#ifndef _MSC_VER // [
#error "Use this header only with Microsoft Visual C++ compilers!"
#endif // _MSC_VER ]

#ifndef _MSC_STDINT_H_ // [
#define _MSC_STDINT_H_

#if _MSC_VER > 1000
#pragma once
#endif

// miloyip: Originally Visual Studio 2010 uses its own stdint.h. However it generates warning with INT64_C(), so change to use this file for vs2010.
#if _MSC_VER >= 1600 // [
#include <stdint.h>

#if !defined(__cplusplus) || defined(__STDC_CONSTANT_MACROS) // [   See footnote 224 at page 260

#undef INT8_C
#undef INT16_C
#undef INT32_C
#undef INT64_C
#undef UINT8_C
#undef UINT16_C
#undef UINT32_C
#undef UINT64_C

// 7.18.4.1 Macros for minimum-width integer constants

#define INT8_C(val)  val##i8
#define INT16_C(val) val##i16
#define INT32_C(val) val##i32
#define INT64_C(val) val##i64

#define UINT8_C(val)  val##ui8
#define UINT16_C(val) val##ui16
#define UINT32_C(val) val##ui32
#define UINT64_C(val) val##ui64

// 7.18.4.2 Macros for greatest-width integer constants
// These #ifndef's are needed to prevent collisions with <boost/cstdint.hpp>.
// Check out Issue 9 for the details.
#ifndef INTMAX_C //   [
#  define INTMAX_C   INT64_C
#endif // INTMAX_C    ]
#ifndef UINTMAX_C //  [
#  define UINTMAX_C  UINT64_C
#endif // UINTMAX_C   ]

#endif // __STDC_CONSTANT_MACROS ]

#else // ] _MSC_VER >= 1700 [

#include <limits.h>

// For Visual Studio 6 in C++ mode and for many Visual Studio versions when
// compiling for ARM we should wrap <wchar.h> include with 'extern "C++" {}'
// or compiler give many errors like this:
//   error C2733: second C linkage of overloaded function 'wmemchr' not allowed
#ifdef __cplusplus
extern "C" {
#endif
#  include <wchar.h>
#ifdef __cplusplus
}
#endif

// Define _W64 macros to mark types changing their size, like intptr_t.
#ifndef _W64
#  if !defined(__midl) && (defined(_X86_) || defined(_M_IX86)) && _MSC_VER >= 1300
#     define _W64 __w64
#  else
#     define _W64
#  endif
#endif


// 7.18.1 Integer types

// 7.18.1.1 Exact-width integer types

// Visual Studio 6 and Embedded Visual C++ 4 doesn't
// realize that, e.g. char has the same size as __int8
// so we give up on __intX for them.
#if (_MSC_VER < 1300)
   typedef signed char       int8_t;
   typedef signed short      int16_t;
   typedef signed int        int32_t;
   typedef unsigned char     uint8_t;
   typedef unsigned short    uint16_t;
   typedef unsigned int      uint32_t;
#else
   typedef signed __int8     int8_t;
   typedef signed __int16    int16_t;
   typedef signed __int32    int32_t;
   typedef unsigned __int8   uint8_t;
   typedef unsigned __int16  uint16_t;
   typedef unsigned __int32  uint32_t;
#endif
typedef signed __int64       int64_t;
typedef unsigned __int64     uint64_t;


// 7.18.1.2 Minimum-width integer types
typedef int8_t    int_least8_t;
typedef int16_t   int_least16_t;
typedef int32_t   int_least32_t;
typedef int64_t   int_least64_t;
typedef uint8_t   uint_least8_t;
typedef uint16_t  uint_least16_t;
typedef uint32_t  uint_least32_t;
typedef uint64_t  uint_least64_t;

// 7.18.1.3 Fastest minimum-width integer types
typedef int8_t    int_fast8_t;
typedef int16_t   int_fast16_t;
typedef int32_t   int_fast32_t;
typedef int64_t   int_fast64_t;
typedef uint8_t   uint_fast8_t;
typedef uint16_t  uint_fast16_t;
typedef uint32_t  uint_fast32_t;
typedef uint64_t  uint_fast64_t;

// 7.18.1.4 Integer types capable of holding object pointers
#ifdef _WIN64 // [
   typedef signed __int64    intptr_t;
   typedef unsigned __int64  uintptr_t;
#else // _WIN64 ][
   typedef _W64 signed int   intptr_t;
   typedef _W64 unsigned int uintptr_t;
#endif // _WIN64 ]

// 7.18.1.5 Greatest-width integer types
typedef int64_t   intmax_t;
typedef uint64_t  uintmax_t;


// 7.18.2 Limits of specified-width integer types

#if !defined(__cplusplus) || defined(__STDC_LIMIT_MACROS) // [   See footnote 220 at page 257 and footnote 221 at page 259

// 7.18.2.1 Limits of exact-width integer types
#define INT8_MIN     ((int8_t)_I8_MIN)
#define INT8_MAX     _I8_MAX
#define INT16_MIN    ((int16_t)_I16_MIN)
#define INT16_MAX    _I16_MAX
#define INT32_MIN    ((int32_t)_I32_MIN)
#define INT32_MAX    _I32_MAX
#define INT64_MIN    ((int64_t)_I64_MIN)
#define INT64_MAX    _I64_MAX
#define UINT8_MAX    _UI8_MAX
#define UINT16_MAX   _UI16_MAX
#define UINT32_MAX   _UI32_MAX
#define UINT64_MAX   _UI64_MAX

// 7.18.2.2 Limits of minimum-width integer types
#define INT_LEAST8_MIN    INT8_MIN
#define INT_LEAST8_MAX    INT8_MAX
#define INT_LEAST16_MIN   INT16_MIN
#define INT_LEAST16_MAX   INT16_MAX
#define INT_LEAST32_MIN   INT32_MIN
#define INT_LEAST32_MAX   INT32_MAX
#define INT_LEAST64_MIN   INT64_MIN
#define INT_LEAST64_MAX   INT64_MAX
#define UINT_LEAST8_MAX   UINT8_MAX
#define UINT_LEAST16_MAX  UINT16_MAX
#define UINT_LEAST32_MAX  UINT32_MAX
#define UINT_LEAST64_MAX  UINT64_MAX

// 7.18.2.3 Limits of fastest minimum-width integer types
#define INT_FAST8_MIN    INT8_MIN
#define INT_FAST8_MAX    INT8_MAX
#define INT_FAST16_MIN   INT16_MIN
#define INT_FAST16_MAX   INT16_MAX
#define INT_FAST32_MIN   INT32_MIN
#define INT_FAST32_MAX   INT32_MAX
#define INT_FAST64_MIN   INT64_MIN
#define INT_FAST64_MAX   INT64_MAX
#define UINT_FAST8_MAX   UINT8_MAX
#define UINT_FAST16_MAX  UINT16_MAX
#define UINT_FAST32_MAX  UINT32_MAX
#define UINT_FAST64_MAX  UINT64_MAX

// 7.18.2.4 Limits of integer types capable of holding object pointers
#ifdef _WIN64 // [
#  define INTPTR_MIN   INT64_MIN
#  define INTPTR_MAX   INT64_MAX
#  define UINTPTR_MAX  UINT64_MAX
#else // _WIN64 ][
#  define INTPTR_MIN   INT32_MIN
#  define INTPTR_MAX   INT32_MAX
#  define UINTPTR_MAX  UINT32_MAX
#endif // _WIN64 ]

// 7.18.2.5 Limits of greatest-width integer types
#define INTMAX_MIN   INT64_MIN
#define INTMAX_MAX   INT64_MAX
#define UINTMAX_MAX  UINT64_MAX

// 7.18.3 Limits of other integer types

#ifdef _WIN64 // [
#  define PTRDIFF_MIN  _I64_MIN
#  define PTRDIFF_MAX  _I64_MAX
#else  // _WIN64 ][
#  define PTRDIFF_MIN  _I32_MIN
#  define PTRDIFF_MAX  _I32_MAX
#endif  // _WIN64 ]

#define SIG_ATOMIC_MIN  INT_MIN
#define SIG_ATOMIC_MAX  INT_MAX

#ifndef SIZE_MAX // [
#  ifdef _WIN64 // [
#     define SIZE_MAX  _UI64_MAX
#  else // _WIN64 ][
#     define SIZE_MAX  _UI32_MAX
#  endif // _WIN64 ]
#endif // SIZE_MAX ]

// WCHAR_MIN and WCHAR_MAX are also defined in <wchar.h>
#ifndef WCHAR_MIN // [
#  define WCHAR_MIN  0
#endif  // WCHAR_MIN ]
#ifndef WCHAR_MAX // [
#  define WCHAR_MAX  _UI16_MAX
#endif  // WCHAR_MAX ]

#define WINT_MIN  0
#define WINT_MAX  _UI16_MAX

#endif // __STDC_LIMIT_MACROS ]


// 7.18.4 Limits of other integer types

#if !defined(__cplusplus) || defined(__STDC_CONSTANT_MACROS) // [   See footnote 224 at page 260

// 7.18.4.1 Macros for minimum-width integer constants

#define INT8_C(val)  val##i8
#define INT16_C(val) val##i16
#define INT32_C(val) val##i32
#define INT64_C(val) val##i64

#define UINT8_C(val)  val##ui8
#define UINT16_C(val) val##ui16
#define UINT32_C(val) val##ui32
#define UINT64_C(val) val##ui64

// 7.18.4.2 Macros for greatest-width integer constants
// These #ifndef's are needed to prevent collisions with <boost/cstdint.hpp>.
// Check out Issue 9 for the details.
#ifndef INTMAX_C //   [
#  define INTMAX_C   INT64_C
#endif // INTMAX_C    ]
#ifndef UINTMAX_C //  [
#  define UINTMAX_C  UINT64_C
#endif // UINTMAX_C   ]

#endif // __STDC_CONSTANT_MACROS ]

#endif // _MSC_VER >= 1600 ]

#endif // _MSC_STDINT_H_ ]

//==============================================================================
// msinttypes/inttypes.h
//==============================================================================

// ISO C9x  compliant inttypes.h for Microsoft Visual Studio
// Based on ISO/IEC 9899:TC2 Committee draft (May 6, 2005) WG14/N1124 
// 
//  Copyright (c) 2006-2013 Alexander Chemeris
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// 
//   1. Redistributions of source code must retain the above copyright notice,
//      this list of conditions and the following disclaimer.
// 
//   2. Redistributions in binary form must reproduce the above copyright
//      notice, this list of conditions and the following disclaimer in the
//      documentation and/or other materials provided with the distribution.
// 
//   3. Neither the name of the product nor the names of its contributors may
//      be used to endorse or promote products derived from this software
//      without specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
// WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
// EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
// OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
// OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// 
///////////////////////////////////////////////////////////////////////////////

#ifndef _MSC_VER // [
#error "Use this header only with Microsoft Visual C++ compilers!"
#endif // _MSC_VER ]

#ifndef _MSC_INTTYPES_H_ // [
#define _MSC_INTTYPES_H_

#if _MSC_VER > 1000
#pragma once
#endif

// 7.8 Format conversion of integer types

typedef struct {
   intmax_t quot;
   intmax_t rem;
} imaxdiv_t;

// 7.8.1 Macros for format specifiers

#if !defined(__cplusplus) || defined(__STDC_FORMAT_MACROS) // [   See footnote 185 at page 198

// The fprintf macros for signed integers are:
#define PRId8       "d"
#define PRIi8       "i"
#define PRIdLEAST8  "d"
#define PRIiLEAST8  "i"
#define PRIdFAST8   "d"
#define PRIiFAST8   "i"

#define PRId16       "hd"
#define PRIi16       "hi"
#define PRIdLEAST16  "hd"
#define PRIiLEAST16  "hi"
#define PRIdFAST16   "hd"
#define PRIiFAST16   "hi"

#define PRId32       "I32d"
#define PRIi32       "I32i"
#define PRIdLEAST32  "I32d"
#define PRIiLEAST32  "I32i"
#define PRIdFAST32   "I32d"
#define PRIiFAST32   "I32i"

#define PRId64       "I64d"
#define PRIi64       "I64i"
#define PRIdLEAST64  "I64d"
#define PRIiLEAST64  "I64i"
#define PRIdFAST64   "I64d"
#define PRIiFAST64   "I64i"

#define PRIdMAX     "I64d"
#define PRIiMAX     "I64i"

#define PRIdPTR     "Id"
#define PRIiPTR     "Ii"

// The fprintf macros for unsigned integers are:
#define PRIo8       "o"
#define PRIu8       "u"
#define PRIx8       "x"
#define PRIX8       "X"
#define PRIoLEAST8  "o"
#define PRIuLEAST8  "u"
#define PRIxLEAST8  "x"
#define PRIXLEAST8  "X"
#define PRIoFAST8   "o"
#define PRIuFAST8   "u"
#define PRIxFAST8   "x"
#define PRIXFAST8   "X"

#define PRIo16       "ho"
#define PRIu16       "hu"
#define PRIx16       "hx"
#define PRIX16       "hX"
#define PRIoLEAST16  "ho"
#define PRIuLEAST16  "hu"
#define PRIxLEAST16  "hx"
#define PRIXLEAST16  "hX"
#define PRIoFAST16   "ho"
#define PRIuFAST16   "hu"
#define PRIxFAST16   "hx"
#define PRIXFAST16   "hX"

#define PRIo32       "I32o"
#define PRIu32       "I32u"
#define PRIx32       "I32x"
#define PRIX32       "I32X"
#define PRIoLEAST32  "I32o"
#define PRIuLEAST32  "I32u"
#define PRIxLEAST32  "I32x"
#define PRIXLEAST32  "I32X"
#define PRIoFAST32   "I32o"
#define PRIuFAST32   "I32u"
#define PRIxFAST32   "I32x"
#define PRIXFAST32   "I32X"

#define PRIo64       "I64o"
#define PRIu64       "I64u"
#define PRIx64       "I64x"
#define PRIX64       "I64X"
#define PRIoLEAST64  "I64o"
#define PRIuLEAST64  "I64u"
#define PRIxLEAST64  "I64x"
#define PRIXLEAST64  "I64X"
#define PRIoFAST64   "I64o"
#define PRIuFAST64   "I64u"
#define PRIxFAST64   "I64x"
#define PRIXFAST64   "I64X"

#define PRIoMAX     "I64o"
#define PRIuMAX     "I64u"
#define PRIxMAX     "I64x"
#define PRIXMAX     "I64X"

#define PRIoPTR     "Io"
#define PRIuPTR     "Iu"
#define PRIxPTR     "Ix"
#define PRIXPTR     "IX"

// The fscanf macros for signed integers are:
#define SCNd8       "d"
#define SCNi8       "i"
#define SCNdLEAST8  "d"
#define SCNiLEAST8  "i"
#define SCNdFAST8   "d"
#define SCNiFAST8   "i"

#define SCNd16       "hd"
#define SCNi16       "hi"
#define SCNdLEAST16  "hd"
#define SCNiLEAST16  "hi"
#define SCNdFAST16   "hd"
#define SCNiFAST16   "hi"

#define SCNd32       "ld"
#define SCNi32       "li"
#define SCNdLEAST32  "ld"
#define SCNiLEAST32  "li"
#define SCNdFAST32   "ld"
#define SCNiFAST32   "li"

#define SCNd64       "I64d"
#define SCNi64       "I64i"
#define SCNdLEAST64  "I64d"
#define SCNiLEAST64  "I64i"
#define SCNdFAST64   "I64d"
#define SCNiFAST64   "I64i"

#define SCNdMAX     "I64d"
#define SCNiMAX     "I64i"

#ifdef _WIN64 // [
#  define SCNdPTR     "I64d"
#  define SCNiPTR     "I64i"
#else  // _WIN64 ][
#  define SCNdPTR     "ld"
#  define SCNiPTR     "li"
#endif  // _WIN64 ]

// The fscanf macros for unsigned integers are:
#define SCNo8       "o"
#define SCNu8       "u"
#define SCNx8       "x"
#define SCNX8       "X"
#define SCNoLEAST8  "o"
#define SCNuLEAST8  "u"
#define SCNxLEAST8  "x"
#define SCNXLEAST8  "X"
#define SCNoFAST8   "o"
#define SCNuFAST8   "u"
#define SCNxFAST8   "x"
#define SCNXFAST8   "X"

#define SCNo16       "ho"
#define SCNu16       "hu"
#define SCNx16       "hx"
#define SCNX16       "hX"
#define SCNoLEAST16  "ho"
#define SCNuLEAST16  "hu"
#define SCNxLEAST16  "hx"
#define SCNXLEAST16  "hX"
#define SCNoFAST16   "ho"
#define SCNuFAST16   "hu"
#define SCNxFAST16   "hx"
#define SCNXFAST16   "hX"

#define SCNo32       "lo"
#define SCNu32       "lu"
#define SCNx32       "lx"
#define SCNX32       "lX"
#define SCNoLEAST32  "lo"
#define SCNuLEAST32  "lu"
#define SCNxLEAST32  "lx"
#define SCNXLEAST32  "lX"
#define SCNoFAST32   "lo"
#define SCNuFAST32   "lu"
#define SCNxFAST32   "lx"
#define SCNXFAST32   "lX"

#define SCNo64       "I64o"
#define SCNu64       "I64u"
#define SCNx64       "I64x"
#define SCNX64       "I64X"
#define SCNoLEAST64  "I64o"
#define SCNuLEAST64  "I64u"
#define SCNxLEAST64  "I64x"
#define SCNXLEAST64  "I64X"
#define SCNoFAST64   "I64o"
#define SCNuFAST64   "I64u"
#define SCNxFAST64   "I64x"
#define SCNXFAST64   "I64X"

#define SCNoMAX     "I64o"
#define SCNuMAX     "I64u"
#define SCNxMAX     "I64x"
#define SCNXMAX     "I64X"

#ifdef _WIN64 // [
#  define SCNoPTR     "I64o"
#  define SCNuPTR     "I64u"
#  define SCNxPTR     "I64x"
#  define SCNXPTR     "I64X"
#else  // _WIN64 ][
#  define SCNoPTR     "lo"
#  define SCNuPTR     "lu"
#  define SCNxPTR     "lx"
#  define SCNXPTR     "lX"
#endif  // _WIN64 ]

#endif // __STDC_FORMAT_MACROS ]

// 7.8.2 Functions for greatest-width integer types

// 7.8.2.1 The imaxabs function
#define imaxabs _abs64

// 7.8.2.2 The imaxdiv function

// This is modified version of div() function from Microsoft's div.c found
// in %MSVC.NET%\crt\src\div.c
#ifdef STATIC_IMAXDIV // [
static
#else // STATIC_IMAXDIV ][
_inline
#endif // STATIC_IMAXDIV ]
imaxdiv_t __cdecl imaxdiv(intmax_t numer, intmax_t denom)
{
   imaxdiv_t result;

   result.quot = numer / denom;
   result.rem = numer % denom;

   if (numer < 0 && result.rem > 0) {
      // did division wrong; must fix up
      ++result.quot;
      result.rem -= denom;
   }

   return result;
}

// 7.8.2.3 The strtoimax and strtoumax functions
#define strtoimax _strtoi64
#define strtoumax _strtoui64

// 7.8.2.4 The wcstoimax and wcstoumax functions
#define wcstoimax _wcstoi64
#define wcstoumax _wcstoui64


#endif // _MSC_INTTYPES_H_ ]


#else
// Other compilers should have this.
#include <stdint.h>
#include <inttypes.h>
#endif
//!@endcond
#ifdef RAPIDJSON_DOXYGEN_RUNNING
#define RAPIDJSON_NO_INT64DEFINE
#endif
#endif // RAPIDJSON_NO_INT64TYPEDEF

///////////////////////////////////////////////////////////////////////////////
// RAPIDJSON_FORCEINLINE

#ifndef RAPIDJSON_FORCEINLINE
//!@cond RAPIDJSON_HIDDEN_FROM_DOXYGEN
#ifdef _MSC_VER
#define RAPIDJSON_FORCEINLINE __forceinline
#elif defined(__GNUC__) && __GNUC__ >= 4
#define RAPIDJSON_FORCEINLINE __attribute__((always_inline))
#else
#define RAPIDJSON_FORCEINLINE
#endif
//!@endcond
#endif // RAPIDJSON_FORCEINLINE

///////////////////////////////////////////////////////////////////////////////
// RAPIDJSON_ENDIAN
#define RAPIDJSON_LITTLEENDIAN  0   //!< Little endian machine
#define RAPIDJSON_BIGENDIAN     1   //!< Big endian machine

//! Endianness of the machine.
/*!
    \def RAPIDJSON_ENDIAN
    \ingroup RAPIDJSON_CONFIG

    GCC 4.6 provided macro for detecting endianness of the target machine. But other
    compilers may not have this. User can define RAPIDJSON_ENDIAN to either
    \ref RAPIDJSON_LITTLEENDIAN or \ref RAPIDJSON_BIGENDIAN.

    Default detection implemented with reference to
    \li https://gcc.gnu.org/onlinedocs/gcc-4.6.0/cpp/Common-Predefined-Macros.html
    \li http://www.boost.org/doc/libs/1_42_0/boost/detail/endian.hpp
*/
#ifndef RAPIDJSON_ENDIAN
// Detect with GCC 4.6's macro
#  ifdef __BYTE_ORDER__
#    if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
#      define RAPIDJSON_ENDIAN RAPIDJSON_LITTLEENDIAN
#    elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
#      define RAPIDJSON_ENDIAN RAPIDJSON_BIGENDIAN
#    else
#      error Unknown machine endianess detected. User needs to define RAPIDJSON_ENDIAN.
#    endif // __BYTE_ORDER__
// Detect with GLIBC's endian.h
#  elif defined(__GLIBC__)
#    include <endian.h>
#    if (__BYTE_ORDER == __LITTLE_ENDIAN)
#      define RAPIDJSON_ENDIAN RAPIDJSON_LITTLEENDIAN
#    elif (__BYTE_ORDER == __BIG_ENDIAN)
#      define RAPIDJSON_ENDIAN RAPIDJSON_BIGENDIAN
#    else
#      error Unknown machine endianess detected. User needs to define RAPIDJSON_ENDIAN.
#   endif // __GLIBC__
// Detect with _LITTLE_ENDIAN and _BIG_ENDIAN macro
#  elif defined(_LITTLE_ENDIAN) && !defined(_BIG_ENDIAN)
#    define RAPIDJSON_ENDIAN RAPIDJSON_LITTLEENDIAN
#  elif defined(_BIG_ENDIAN) && !defined(_LITTLE_ENDIAN)
#    define RAPIDJSON_ENDIAN RAPIDJSON_BIGENDIAN
// Detect with architecture macros
#  elif defined(__sparc) || defined(__sparc__) || defined(_POWER) || defined(__powerpc__) || defined(__ppc__) || defined(__hpux) || defined(__hppa) || defined(_MIPSEB) || defined(_POWER) || defined(__s390__)
#    define RAPIDJSON_ENDIAN RAPIDJSON_BIGENDIAN
#  elif defined(__i386__) || defined(__alpha__) || defined(__ia64) || defined(__ia64__) || defined(_M_IX86) || defined(_M_IA64) || defined(_M_ALPHA) || defined(__amd64) || defined(__amd64__) || defined(_M_AMD64) || defined(__x86_64) || defined(__x86_64__) || defined(_M_X64) || defined(__bfin__)
#    define RAPIDJSON_ENDIAN RAPIDJSON_LITTLEENDIAN
#  elif defined(RAPIDJSON_DOXYGEN_RUNNING)
#    define RAPIDJSON_ENDIAN
#  else
#    error Unknown machine endianess detected. User needs to define RAPIDJSON_ENDIAN.   
#  endif
#endif // RAPIDJSON_ENDIAN

///////////////////////////////////////////////////////////////////////////////
// RAPIDJSON_64BIT

//! Whether using 64-bit architecture
#ifndef RAPIDJSON_64BIT
#if defined(__LP64__) || defined(_WIN64)
#define RAPIDJSON_64BIT 1
#else
#define RAPIDJSON_64BIT 0
#endif
#endif // RAPIDJSON_64BIT

///////////////////////////////////////////////////////////////////////////////
// RAPIDJSON_ALIGN

//! Data alignment of the machine.
/*! \ingroup RAPIDJSON_CONFIG
    \param x pointer to align

    Some machines require strict data alignment. Currently the default uses 4 bytes
    alignment. User can customize by defining the RAPIDJSON_ALIGN function macro.,
*/
#ifndef RAPIDJSON_ALIGN
#define RAPIDJSON_ALIGN(x) ((x + 3u) & ~3u)
#endif

///////////////////////////////////////////////////////////////////////////////
// RAPIDJSON_UINT64_C2

//! Construct a 64-bit literal by a pair of 32-bit integer.
/*!
    64-bit literal with or without ULL suffix is prone to compiler warnings.
    UINT64_C() is C macro which cause compilation problems.
    Use this macro to define 64-bit constants by a pair of 32-bit integer.
*/
#ifndef RAPIDJSON_UINT64_C2
#define RAPIDJSON_UINT64_C2(high32, low32) ((static_cast<uint64_t>(high32) << 32) | static_cast<uint64_t>(low32))
#endif

///////////////////////////////////////////////////////////////////////////////
// RAPIDJSON_SSE2/RAPIDJSON_SSE42/RAPIDJSON_SIMD

/*! \def RAPIDJSON_SIMD
    \ingroup RAPIDJSON_CONFIG
    \brief Enable SSE2/SSE4.2 optimization.

    RapidJSON supports optimized implementations for some parsing operations
    based on the SSE2 or SSE4.2 SIMD extensions on modern Intel-compatible
    processors.

    To enable these optimizations, two different symbols can be defined;
    \code
    // Enable SSE2 optimization.
    #define RAPIDJSON_SSE2

    // Enable SSE4.2 optimization.
    #define RAPIDJSON_SSE42
    \endcode

    \c RAPIDJSON_SSE42 takes precedence, if both are defined.

    If any of these symbols is defined, RapidJSON defines the macro
    \c RAPIDJSON_SIMD to indicate the availability of the optimized code.
*/
#if defined(RAPIDJSON_SSE2) || defined(RAPIDJSON_SSE42) \
    || defined(RAPIDJSON_DOXYGEN_RUNNING)
#define RAPIDJSON_SIMD
#endif

///////////////////////////////////////////////////////////////////////////////
// RAPIDJSON_NO_SIZETYPEDEFINE

#ifndef RAPIDJSON_NO_SIZETYPEDEFINE
/*! \def RAPIDJSON_NO_SIZETYPEDEFINE
    \ingroup RAPIDJSON_CONFIG
    \brief User-provided \c SizeType definition.

    In order to avoid using 32-bit size types for indexing strings and arrays,
    define this preprocessor symbol and provide the type rapidjson::SizeType
    before including RapidJSON:
    \code
    #define RAPIDJSON_NO_SIZETYPEDEFINE
    namespace rapidjson { typedef ::std::size_t SizeType; }
    #include "rapidjson/..."
    \endcode

    \see rapidjson::SizeType
*/
#ifdef RAPIDJSON_DOXYGEN_RUNNING
#define RAPIDJSON_NO_SIZETYPEDEFINE
#endif
namespace rapidjson {
//! Size type (for string lengths, array sizes, etc.)
/*! RapidJSON uses 32-bit array/string indices even on 64-bit platforms,
    instead of using \c size_t. Users may override the SizeType by defining
    \ref RAPIDJSON_NO_SIZETYPEDEFINE.
*/
typedef unsigned SizeType;
} // namespace rapidjson
#endif

///////////////////////////////////////////////////////////////////////////////
// RAPIDJSON_ASSERT

//! Assertion.
/*! \ingroup RAPIDJSON_CONFIG
    By default, rapidjson uses C \c assert() for internal assertions.
    User can override it by defining RAPIDJSON_ASSERT(x) macro.

    \note Parsing errors are handled and can be customized by the
          \ref RAPIDJSON_ERRORS APIs.
*/
#ifndef RAPIDJSON_ASSERT
#include <cassert>
#define RAPIDJSON_ASSERT(x) assert(x)
#endif // RAPIDJSON_ASSERT

///////////////////////////////////////////////////////////////////////////////
// RAPIDJSON_STATIC_ASSERT

// Adopt from boost
#ifndef RAPIDJSON_STATIC_ASSERT
//!@cond RAPIDJSON_HIDDEN_FROM_DOXYGEN
namespace rapidjson {

template <bool x> struct STATIC_ASSERTION_FAILURE;
template <> struct STATIC_ASSERTION_FAILURE<true> { enum { value = 1 }; };
template<int x> struct StaticAssertTest {};
} // namespace rapidjson

#define RAPIDJSON_JOIN(X, Y) RAPIDJSON_DO_JOIN(X, Y)
#define RAPIDJSON_DO_JOIN(X, Y) RAPIDJSON_DO_JOIN2(X, Y)
#define RAPIDJSON_DO_JOIN2(X, Y) X##Y

#if defined(__GNUC__)
#define RAPIDJSON_STATIC_ASSERT_UNUSED_ATTRIBUTE __attribute__((unused))
#else
#define RAPIDJSON_STATIC_ASSERT_UNUSED_ATTRIBUTE 
#endif
//!@endcond

/*! \def RAPIDJSON_STATIC_ASSERT
    \brief (Internal) macro to check for conditions at compile-time
    \param x compile-time condition
    \hideinitializer
 */
#define RAPIDJSON_STATIC_ASSERT(x) typedef ::rapidjson::StaticAssertTest<\
    sizeof(::rapidjson::STATIC_ASSERTION_FAILURE<bool(x) >)>\
    RAPIDJSON_JOIN(StaticAssertTypedef, __LINE__) RAPIDJSON_STATIC_ASSERT_UNUSED_ATTRIBUTE
#endif

///////////////////////////////////////////////////////////////////////////////
// Helpers

//!@cond RAPIDJSON_HIDDEN_FROM_DOXYGEN

#define RAPIDJSON_MULTILINEMACRO_BEGIN do {  
#define RAPIDJSON_MULTILINEMACRO_END \
} while((void)0, 0)

// adopted from Boost
#define RAPIDJSON_VERSION_CODE(x,y,z) \
  (((x)*100000) + ((y)*100) + (z))

// token stringification
#define RAPIDJSON_STRINGIFY(x) RAPIDJSON_DO_STRINGIFY(x)
#define RAPIDJSON_DO_STRINGIFY(x) #x

///////////////////////////////////////////////////////////////////////////////
// RAPIDJSON_DIAG_PUSH/POP, RAPIDJSON_DIAG_OFF

#if defined(__clang__) || (defined(__GNUC__) && RAPIDJSON_VERSION_CODE(__GNUC__,__GNUC_MINOR__,__GNUC_PATCHLEVEL__) >= RAPIDJSON_VERSION_CODE(4,2,0))

#define RAPIDJSON_PRAGMA(x) _Pragma(RAPIDJSON_STRINGIFY(x))
#define RAPIDJSON_DIAG_PRAGMA(x) RAPIDJSON_PRAGMA(GCC diagnostic x)
#define RAPIDJSON_DIAG_OFF(x) \
    RAPIDJSON_DIAG_PRAGMA(ignored RAPIDJSON_STRINGIFY(RAPIDJSON_JOIN(-W,x)))

// push/pop support in Clang and GCC>=4.6
#if defined(__clang__) || (defined(__GNUC__) && RAPIDJSON_VERSION_CODE(__GNUC__,__GNUC_MINOR__,__GNUC_PATCHLEVEL__) >= RAPIDJSON_VERSION_CODE(4,6,0))
#define RAPIDJSON_DIAG_PUSH RAPIDJSON_DIAG_PRAGMA(push)
#define RAPIDJSON_DIAG_POP  RAPIDJSON_DIAG_PRAGMA(pop)
#else // GCC >= 4.2, < 4.6
#define RAPIDJSON_DIAG_PUSH /* ignored */
#define RAPIDJSON_DIAG_POP /* ignored */
#endif

#elif defined(_MSC_VER)

// pragma (MSVC specific)
#define RAPIDJSON_PRAGMA(x) __pragma(x)
#define RAPIDJSON_DIAG_PRAGMA(x) RAPIDJSON_PRAGMA(warning(x))

#define RAPIDJSON_DIAG_OFF(x) RAPIDJSON_DIAG_PRAGMA(disable: x)
#define RAPIDJSON_DIAG_PUSH RAPIDJSON_DIAG_PRAGMA(push)
#define RAPIDJSON_DIAG_POP  RAPIDJSON_DIAG_PRAGMA(pop)

#else

#define RAPIDJSON_DIAG_OFF(x) /* ignored */
#define RAPIDJSON_DIAG_PUSH   /* ignored */
#define RAPIDJSON_DIAG_POP    /* ignored */

#endif // RAPIDJSON_DIAG_*

//!@endcond


//==============================================================================
// error/error.h
//==============================================================================

// Copyright (C) 2011 Milo Yip
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#ifndef RAPIDJSON_ERROR_ERROR_H__
#define RAPIDJSON_ERROR_ERROR_H__

/*! \file error.h */

/*! \defgroup RAPIDJSON_ERRORS RapidJSON error handling */

///////////////////////////////////////////////////////////////////////////////
// RAPIDJSON_ERROR_CHARTYPE

//! Character type of error messages.
/*! \ingroup RAPIDJSON_ERRORS
    The default character type is \c char.
    On Windows, user can define this macro as \c TCHAR for supporting both
    unicode/non-unicode settings.
*/
#ifndef RAPIDJSON_ERROR_CHARTYPE
#define RAPIDJSON_ERROR_CHARTYPE char
#endif

///////////////////////////////////////////////////////////////////////////////
// RAPIDJSON_ERROR_STRING

//! Macro for converting string literial to \ref RAPIDJSON_ERROR_CHARTYPE[].
/*! \ingroup RAPIDJSON_ERRORS
    By default this conversion macro does nothing.
    On Windows, user can define this macro as \c _T(x) for supporting both
    unicode/non-unicode settings.
*/
#ifndef RAPIDJSON_ERROR_STRING
#define RAPIDJSON_ERROR_STRING(x) x
#endif

namespace rapidjson {

///////////////////////////////////////////////////////////////////////////////
// ParseErrorCode

//! Error code of parsing.
/*! \ingroup RAPIDJSON_ERRORS
    \see GenericReader::Parse, GenericReader::GetParseErrorCode
*/
enum ParseErrorCode {
    kParseErrorNone = 0,                        //!< No error.

    kParseErrorDocumentEmpty,                   //!< The document is empty.
    kParseErrorDocumentRootNotSingular,         //!< The document root must not follow by other values.

    kParseErrorValueInvalid,                    //!< Invalid value.

    kParseErrorObjectMissName,                  //!< Missing a name for object member.
    kParseErrorObjectMissColon,                 //!< Missing a colon after a name of object member.
    kParseErrorObjectMissCommaOrCurlyBracket,   //!< Missing a comma or '}' after an object member.

    kParseErrorArrayMissCommaOrSquareBracket,   //!< Missing a comma or ']' after an array element.

    kParseErrorStringUnicodeEscapeInvalidHex,   //!< Incorrect hex digit after \\u escape in string.
    kParseErrorStringUnicodeSurrogateInvalid,   //!< The surrogate pair in string is invalid.
    kParseErrorStringEscapeInvalid,             //!< Invalid escape character in string.
    kParseErrorStringMissQuotationMark,         //!< Missing a closing quotation mark in string.
    kParseErrorStringInvalidEncoding,           //!< Invalid encoding in string.

    kParseErrorNumberTooBig,                    //!< Number too big to be stored in double.
    kParseErrorNumberMissFraction,              //!< Miss fraction part in number.
    kParseErrorNumberMissExponent,              //!< Miss exponent in number.

    kParseErrorTermination,                     //!< Parsing was terminated.
    kParseErrorUnspecificSyntaxError,           //!< Unspecific syntax error.
};

//! Result of parsing (wraps ParseErrorCode)
/*!
    \ingroup RAPIDJSON_ERRORS
    \code
        Document doc;
        ParseResult ok = doc.Parse("[42]");
        if (!ok) {
            fprintf(stderr, "JSON parse error: %s (%u)",
                    GetParseError_En(ok.Code()), ok.Offset());
            exit(EXIT_FAILURE);
        }
    \endcode
    \see GenericReader::Parse, GenericDocument::Parse
*/
struct ParseResult {

    //! Default constructor, no error.
    ParseResult() : code_(kParseErrorNone), offset_(0) {}
    //! Constructor to set an error.
    ParseResult(ParseErrorCode code, size_t offset) : code_(code), offset_(offset) {}

    //! Get the error code.
    ParseErrorCode Code() const { return code_; }
    //! Get the error offset, if \ref IsError(), 0 otherwise.
    size_t Offset() const { return offset_; }

    //! Conversion to \c bool, returns \c true, iff !\ref IsError().
    operator bool() const { return !IsError(); }
    //! Whether the result is an error.
    bool IsError() const { return code_ != kParseErrorNone; }

    bool operator==(const ParseResult& that) const { return code_ == that.code_; }
    bool operator==(ParseErrorCode code) const { return code_ == code; }
    friend bool operator==(ParseErrorCode code, const ParseResult & err) { return code == err.code_; }

    //! Reset error code.
    void Clear() { Set(kParseErrorNone); }
    //! Update error code and offset.
    void Set(ParseErrorCode code, size_t offset = 0) { code_ = code; offset_ = offset; }

private:
    ParseErrorCode code_;
    size_t offset_;
};

//! Function pointer type of GetParseError().
/*! \ingroup RAPIDJSON_ERRORS

    This is the prototype for \c GetParseError_X(), where \c X is a locale.
    User can dynamically change locale in runtime, e.g.:
\code
    GetParseErrorFunc GetParseError = GetParseError_En; // or whatever
    const RAPIDJSON_ERROR_CHARTYPE* s = GetParseError(document.GetParseErrorCode());
\endcode
*/
typedef const RAPIDJSON_ERROR_CHARTYPE* (*GetParseErrorFunc)(ParseErrorCode);

} // namespace rapidjson

#endif // RAPIDJSON_ERROR_ERROR_H__

//==============================================================================
// error/en.h
//==============================================================================

// Copyright (C) 2011 Milo Yip
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#ifndef RAPIDJSON_ERROR_EN_H__
#define RAPIDJSON_ERROR_EN_H__

namespace rapidjson {

//! Maps error code of parsing into error message.
/*!
    \ingroup RAPIDJSON_ERRORS
    \param parseErrorCode Error code obtained in parsing.
    \return the error message.
    \note User can make a copy of this function for localization.
        Using switch-case is safer for future modification of error codes.
*/
inline const RAPIDJSON_ERROR_CHARTYPE* GetParseError_En(ParseErrorCode parseErrorCode) {
    switch (parseErrorCode) {
        case kParseErrorNone:                           return RAPIDJSON_ERROR_STRING("No error.");

        case kParseErrorDocumentEmpty:                  return RAPIDJSON_ERROR_STRING("The document is empty.");
        case kParseErrorDocumentRootNotSingular:        return RAPIDJSON_ERROR_STRING("The document root must not follow by other values.");
    
        case kParseErrorValueInvalid:                   return RAPIDJSON_ERROR_STRING("Invalid value.");
    
        case kParseErrorObjectMissName:                 return RAPIDJSON_ERROR_STRING("Missing a name for object member.");
        case kParseErrorObjectMissColon:                return RAPIDJSON_ERROR_STRING("Missing a colon after a name of object member.");
        case kParseErrorObjectMissCommaOrCurlyBracket:  return RAPIDJSON_ERROR_STRING("Missing a comma or '}' after an object member.");
    
        case kParseErrorArrayMissCommaOrSquareBracket:  return RAPIDJSON_ERROR_STRING("Missing a comma or ']' after an array element.");

        case kParseErrorStringUnicodeEscapeInvalidHex:  return RAPIDJSON_ERROR_STRING("Incorrect hex digit after \\u escape in string.");
        case kParseErrorStringUnicodeSurrogateInvalid:  return RAPIDJSON_ERROR_STRING("The surrogate pair in string is invalid.");
        case kParseErrorStringEscapeInvalid:            return RAPIDJSON_ERROR_STRING("Invalid escape character in string.");
        case kParseErrorStringMissQuotationMark:        return RAPIDJSON_ERROR_STRING("Missing a closing quotation mark in string.");
        case kParseErrorStringInvalidEncoding:          return RAPIDJSON_ERROR_STRING("Invalid encoding in string.");

        case kParseErrorNumberTooBig:                   return RAPIDJSON_ERROR_STRING("Number too big to be stored in double.");
        case kParseErrorNumberMissFraction:             return RAPIDJSON_ERROR_STRING("Miss fraction part in number.");
        case kParseErrorNumberMissExponent:             return RAPIDJSON_ERROR_STRING("Miss exponent in number.");

        case kParseErrorTermination:                    return RAPIDJSON_ERROR_STRING("Terminate parsing due to Handler error.");
        case kParseErrorUnspecificSyntaxError:          return RAPIDJSON_ERROR_STRING("Unspecific syntax error.");

        default:
            return RAPIDJSON_ERROR_STRING("Unknown error.");
    }
}

} // namespace rapidjson

#endif // RAPIDJSON_ERROR_EN_H__

//==============================================================================
// internal/itoa.h
//==============================================================================

// Copyright (C) 2011 Milo Yip
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#ifndef RAPIDJSON_ITOA_
#define RAPIDJSON_ITOA_

namespace rapidjson {
namespace internal {

inline const char* GetDigitsLut() {
    static const char cDigitsLut[200] = {
        '0','0','0','1','0','2','0','3','0','4','0','5','0','6','0','7','0','8','0','9',
        '1','0','1','1','1','2','1','3','1','4','1','5','1','6','1','7','1','8','1','9',
        '2','0','2','1','2','2','2','3','2','4','2','5','2','6','2','7','2','8','2','9',
        '3','0','3','1','3','2','3','3','3','4','3','5','3','6','3','7','3','8','3','9',
        '4','0','4','1','4','2','4','3','4','4','4','5','4','6','4','7','4','8','4','9',
        '5','0','5','1','5','2','5','3','5','4','5','5','5','6','5','7','5','8','5','9',
        '6','0','6','1','6','2','6','3','6','4','6','5','6','6','6','7','6','8','6','9',
        '7','0','7','1','7','2','7','3','7','4','7','5','7','6','7','7','7','8','7','9',
        '8','0','8','1','8','2','8','3','8','4','8','5','8','6','8','7','8','8','8','9',
        '9','0','9','1','9','2','9','3','9','4','9','5','9','6','9','7','9','8','9','9'
    };
    return cDigitsLut;
}

inline char* u32toa(uint32_t value, char* buffer) {
    const char* cDigitsLut = GetDigitsLut();

    if (value < 10000) {
        const uint32_t d1 = (value / 100) << 1;
        const uint32_t d2 = (value % 100) << 1;
        
        if (value >= 1000)
            *buffer++ = cDigitsLut[d1];
        if (value >= 100)
            *buffer++ = cDigitsLut[d1 + 1];
        if (value >= 10)
            *buffer++ = cDigitsLut[d2];
        *buffer++ = cDigitsLut[d2 + 1];
    }
    else if (value < 100000000) {
        // value = bbbbcccc
        const uint32_t b = value / 10000;
        const uint32_t c = value % 10000;
        
        const uint32_t d1 = (b / 100) << 1;
        const uint32_t d2 = (b % 100) << 1;
        
        const uint32_t d3 = (c / 100) << 1;
        const uint32_t d4 = (c % 100) << 1;
        
        if (value >= 10000000)
            *buffer++ = cDigitsLut[d1];
        if (value >= 1000000)
            *buffer++ = cDigitsLut[d1 + 1];
        if (value >= 100000)
            *buffer++ = cDigitsLut[d2];
        *buffer++ = cDigitsLut[d2 + 1];
        
        *buffer++ = cDigitsLut[d3];
        *buffer++ = cDigitsLut[d3 + 1];
        *buffer++ = cDigitsLut[d4];
        *buffer++ = cDigitsLut[d4 + 1];
    }
    else {
        // value = aabbbbcccc in decimal
        
        const uint32_t a = value / 100000000; // 1 to 42
        value %= 100000000;
        
        if (a >= 10) {
            const unsigned i = a << 1;
            *buffer++ = cDigitsLut[i];
            *buffer++ = cDigitsLut[i + 1];
        }
        else
            *buffer++ = '0' + static_cast<char>(a);

        const uint32_t b = value / 10000; // 0 to 9999
        const uint32_t c = value % 10000; // 0 to 9999
        
        const uint32_t d1 = (b / 100) << 1;
        const uint32_t d2 = (b % 100) << 1;
        
        const uint32_t d3 = (c / 100) << 1;
        const uint32_t d4 = (c % 100) << 1;
        
        *buffer++ = cDigitsLut[d1];
        *buffer++ = cDigitsLut[d1 + 1];
        *buffer++ = cDigitsLut[d2];
        *buffer++ = cDigitsLut[d2 + 1];
        *buffer++ = cDigitsLut[d3];
        *buffer++ = cDigitsLut[d3 + 1];
        *buffer++ = cDigitsLut[d4];
        *buffer++ = cDigitsLut[d4 + 1];
    }
    return buffer;
}

inline char* i32toa(int32_t value, char* buffer) {
    if (value < 0) {
        *buffer++ = '-';
        value = -value;
    }

    return u32toa(static_cast<uint32_t>(value), buffer);
}

inline char* u64toa(uint64_t value, char* buffer) {
    const char* cDigitsLut = GetDigitsLut();
    const uint64_t  kTen8 = 100000000;
    const uint64_t  kTen9 = kTen8 * 10;
    const uint64_t kTen10 = kTen8 * 100;
    const uint64_t kTen11 = kTen8 * 1000;
    const uint64_t kTen12 = kTen8 * 10000;
    const uint64_t kTen13 = kTen8 * 100000;
    const uint64_t kTen14 = kTen8 * 1000000;
    const uint64_t kTen15 = kTen8 * 10000000;
    const uint64_t kTen16 = kTen8 * kTen8;
    
    if (value < kTen8) {
        uint32_t v = static_cast<uint32_t>(value);
        if (v < 10000) {
            const uint32_t d1 = (v / 100) << 1;
            const uint32_t d2 = (v % 100) << 1;
            
            if (v >= 1000)
                *buffer++ = cDigitsLut[d1];
            if (v >= 100)
                *buffer++ = cDigitsLut[d1 + 1];
            if (v >= 10)
                *buffer++ = cDigitsLut[d2];
            *buffer++ = cDigitsLut[d2 + 1];
        }
        else {
            // value = bbbbcccc
            const uint32_t b = v / 10000;
            const uint32_t c = v % 10000;
            
            const uint32_t d1 = (b / 100) << 1;
            const uint32_t d2 = (b % 100) << 1;
            
            const uint32_t d3 = (c / 100) << 1;
            const uint32_t d4 = (c % 100) << 1;
            
            if (value >= 10000000)
                *buffer++ = cDigitsLut[d1];
            if (value >= 1000000)
                *buffer++ = cDigitsLut[d1 + 1];
            if (value >= 100000)
                *buffer++ = cDigitsLut[d2];
            *buffer++ = cDigitsLut[d2 + 1];
            
            *buffer++ = cDigitsLut[d3];
            *buffer++ = cDigitsLut[d3 + 1];
            *buffer++ = cDigitsLut[d4];
            *buffer++ = cDigitsLut[d4 + 1];
        }
    }
    else if (value < kTen16) {
        const uint32_t v0 = static_cast<uint32_t>(value / kTen8);
        const uint32_t v1 = static_cast<uint32_t>(value % kTen8);
        
        const uint32_t b0 = v0 / 10000;
        const uint32_t c0 = v0 % 10000;
        
        const uint32_t d1 = (b0 / 100) << 1;
        const uint32_t d2 = (b0 % 100) << 1;
        
        const uint32_t d3 = (c0 / 100) << 1;
        const uint32_t d4 = (c0 % 100) << 1;

        const uint32_t b1 = v1 / 10000;
        const uint32_t c1 = v1 % 10000;
        
        const uint32_t d5 = (b1 / 100) << 1;
        const uint32_t d6 = (b1 % 100) << 1;
        
        const uint32_t d7 = (c1 / 100) << 1;
        const uint32_t d8 = (c1 % 100) << 1;

        if (value >= kTen15)
            *buffer++ = cDigitsLut[d1];
        if (value >= kTen14)
            *buffer++ = cDigitsLut[d1 + 1];
        if (value >= kTen13)
            *buffer++ = cDigitsLut[d2];
        if (value >= kTen12)
            *buffer++ = cDigitsLut[d2 + 1];
        if (value >= kTen11)
            *buffer++ = cDigitsLut[d3];
        if (value >= kTen10)
            *buffer++ = cDigitsLut[d3 + 1];
        if (value >= kTen9)
            *buffer++ = cDigitsLut[d4];
        if (value >= kTen8)
            *buffer++ = cDigitsLut[d4 + 1];
        
        *buffer++ = cDigitsLut[d5];
        *buffer++ = cDigitsLut[d5 + 1];
        *buffer++ = cDigitsLut[d6];
        *buffer++ = cDigitsLut[d6 + 1];
        *buffer++ = cDigitsLut[d7];
        *buffer++ = cDigitsLut[d7 + 1];
        *buffer++ = cDigitsLut[d8];
        *buffer++ = cDigitsLut[d8 + 1];
    }
    else {
        const uint32_t a = static_cast<uint32_t>(value / kTen16); // 1 to 1844
        value %= kTen16;
        
        if (a < 10)
            *buffer++ = '0' + static_cast<char>(a);
        else if (a < 100) {
            const uint32_t i = a << 1;
            *buffer++ = cDigitsLut[i];
            *buffer++ = cDigitsLut[i + 1];
        }
        else if (a < 1000) {
            *buffer++ = '0' + static_cast<char>(a / 100);
            
            const uint32_t i = (a % 100) << 1;
            *buffer++ = cDigitsLut[i];
            *buffer++ = cDigitsLut[i + 1];
        }
        else {
            const uint32_t i = (a / 100) << 1;
            const uint32_t j = (a % 100) << 1;
            *buffer++ = cDigitsLut[i];
            *buffer++ = cDigitsLut[i + 1];
            *buffer++ = cDigitsLut[j];
            *buffer++ = cDigitsLut[j + 1];
        }
        
        const uint32_t v0 = static_cast<uint32_t>(value / kTen8);
        const uint32_t v1 = static_cast<uint32_t>(value % kTen8);
        
        const uint32_t b0 = v0 / 10000;
        const uint32_t c0 = v0 % 10000;
        
        const uint32_t d1 = (b0 / 100) << 1;
        const uint32_t d2 = (b0 % 100) << 1;
        
        const uint32_t d3 = (c0 / 100) << 1;
        const uint32_t d4 = (c0 % 100) << 1;
        
        const uint32_t b1 = v1 / 10000;
        const uint32_t c1 = v1 % 10000;
        
        const uint32_t d5 = (b1 / 100) << 1;
        const uint32_t d6 = (b1 % 100) << 1;
        
        const uint32_t d7 = (c1 / 100) << 1;
        const uint32_t d8 = (c1 % 100) << 1;
        
        *buffer++ = cDigitsLut[d1];
        *buffer++ = cDigitsLut[d1 + 1];
        *buffer++ = cDigitsLut[d2];
        *buffer++ = cDigitsLut[d2 + 1];
        *buffer++ = cDigitsLut[d3];
        *buffer++ = cDigitsLut[d3 + 1];
        *buffer++ = cDigitsLut[d4];
        *buffer++ = cDigitsLut[d4 + 1];
        *buffer++ = cDigitsLut[d5];
        *buffer++ = cDigitsLut[d5 + 1];
        *buffer++ = cDigitsLut[d6];
        *buffer++ = cDigitsLut[d6 + 1];
        *buffer++ = cDigitsLut[d7];
        *buffer++ = cDigitsLut[d7 + 1];
        *buffer++ = cDigitsLut[d8];
        *buffer++ = cDigitsLut[d8 + 1];
    }
    
    return buffer;
}

inline char* i64toa(int64_t value, char* buffer) {
    if (value < 0) {
        *buffer++ = '-';
        value = -value;
    }

    return u64toa(static_cast<uint64_t>(value), buffer);
}

} // namespace internal
} // namespace rapidjson

#endif // RAPIDJSON_ITOA_

//==============================================================================
// internal/dtoa.h
//==============================================================================

// Copyright (C) 2011 Milo Yip
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

// This is a C++ header-only implementation of Grisu2 algorithm from the publication:
// Loitsch, Florian. "Printing floating-point numbers quickly and accurately with
// integers." ACM Sigplan Notices 45.6 (2010): 233-243.

#ifndef RAPIDJSON_DTOA_
#define RAPIDJSON_DTOA_

#if defined(_MSC_VER)
#include <intrin.h>
#if defined(_M_AMD64)
#pragma intrinsic(_BitScanReverse64)
#endif
#endif

namespace rapidjson {
namespace internal {

#ifdef __GNUC__
RAPIDJSON_DIAG_PUSH
RAPIDJSON_DIAG_OFF(effc++)
#endif

struct DiyFp {
    DiyFp() {}

    DiyFp(uint64_t f, int e) : f(f), e(e) {}

    DiyFp(double d) {
        union {
            double d;
            uint64_t u64;
        } u = { d };

        int biased_e = (u.u64 & kDpExponentMask) >> kDpSignificandSize;
        uint64_t significand = (u.u64 & kDpSignificandMask);
        if (biased_e != 0) {
            f = significand + kDpHiddenBit;
            e = biased_e - kDpExponentBias;
        } 
        else {
            f = significand;
            e = kDpMinExponent + 1;
        }
    }

    DiyFp operator-(const DiyFp& rhs) const {
        return DiyFp(f - rhs.f, e);
    }

    DiyFp operator*(const DiyFp& rhs) const {
#if defined(_MSC_VER) && defined(_M_AMD64)
        uint64_t h;
        uint64_t l = _umul128(f, rhs.f, &h);
        if (l & (uint64_t(1) << 63)) // rounding
            h++;
        return DiyFp(h, e + rhs.e + 64);
#elif (__GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)) && defined(__x86_64__)
        unsigned __int128 p = static_cast<unsigned __int128>(f) * static_cast<unsigned __int128>(rhs.f);
        uint64_t h = p >> 64;
        uint64_t l = static_cast<uint64_t>(p);
        if (l & (uint64_t(1) << 63)) // rounding
            h++;
        return DiyFp(h, e + rhs.e + 64);
#else
        const uint64_t M32 = 0xFFFFFFFF;
        const uint64_t a = f >> 32;
        const uint64_t b = f & M32;
        const uint64_t c = rhs.f >> 32;
        const uint64_t d = rhs.f & M32;
        const uint64_t ac = a * c;
        const uint64_t bc = b * c;
        const uint64_t ad = a * d;
        const uint64_t bd = b * d;
        uint64_t tmp = (bd >> 32) + (ad & M32) + (bc & M32);
        tmp += 1U << 31;  /// mult_round
        return DiyFp(ac + (ad >> 32) + (bc >> 32) + (tmp >> 32), e + rhs.e + 64);
#endif
    }

    DiyFp Normalize() const {
#if defined(_MSC_VER) && defined(_M_AMD64)
        unsigned long index;
        _BitScanReverse64(&index, f);
        return DiyFp(f << (63 - index), e - (63 - index));
#elif defined(__GNUC__)
        int s = __builtin_clzll(f) + 1;
        return DiyFp(f << s, e - s);
#else
        DiyFp res = *this;
        while (!(res.f & kDpHiddenBit)) {
            res.f <<= 1;
            res.e--;
        }
        res.f <<= (kDiySignificandSize - kDpSignificandSize - 1);
        res.e = res.e - (kDiySignificandSize - kDpSignificandSize - 1);
        return res;
#endif
    }

    DiyFp NormalizeBoundary() const {
#if defined(_MSC_VER) && defined(_M_AMD64)
        unsigned long index;
        _BitScanReverse64(&index, f);
        return DiyFp (f << (63 - index), e - (63 - index));
#else
        DiyFp res = *this;
        while (!(res.f & (kDpHiddenBit << 1))) {
            res.f <<= 1;
            res.e--;
        }
        res.f <<= (kDiySignificandSize - kDpSignificandSize - 2);
        res.e = res.e - (kDiySignificandSize - kDpSignificandSize - 2);
        return res;
#endif
    }

    void NormalizedBoundaries(DiyFp* minus, DiyFp* plus) const {
        DiyFp pl = DiyFp((f << 1) + 1, e - 1).NormalizeBoundary();
        DiyFp mi = (f == kDpHiddenBit) ? DiyFp((f << 2) - 1, e - 2) : DiyFp((f << 1) - 1, e - 1);
        mi.f <<= mi.e - pl.e;
        mi.e = pl.e;
        *plus = pl;
        *minus = mi;
    }

    static const int kDiySignificandSize = 64;
    static const int kDpSignificandSize = 52;
    static const int kDpExponentBias = 0x3FF + kDpSignificandSize;
    static const int kDpMinExponent = -kDpExponentBias;
    static const uint64_t kDpExponentMask = RAPIDJSON_UINT64_C2(0x7FF00000, 0x00000000);
    static const uint64_t kDpSignificandMask = RAPIDJSON_UINT64_C2(0x000FFFFF, 0xFFFFFFFF);
    static const uint64_t kDpHiddenBit = RAPIDJSON_UINT64_C2(0x00100000, 0x00000000);

    uint64_t f;
    int e;
};

inline DiyFp GetCachedPower(int e, int* K) {
    // 10^-348, 10^-340, ..., 10^340
    static const uint64_t kCachedPowers_F[] = {
        RAPIDJSON_UINT64_C2(0xfa8fd5a0, 0x081c0288), RAPIDJSON_UINT64_C2(0xbaaee17f, 0xa23ebf76),
        RAPIDJSON_UINT64_C2(0x8b16fb20, 0x3055ac76), RAPIDJSON_UINT64_C2(0xcf42894a, 0x5dce35ea),
        RAPIDJSON_UINT64_C2(0x9a6bb0aa, 0x55653b2d), RAPIDJSON_UINT64_C2(0xe61acf03, 0x3d1a45df),
        RAPIDJSON_UINT64_C2(0xab70fe17, 0xc79ac6ca), RAPIDJSON_UINT64_C2(0xff77b1fc, 0xbebcdc4f),
        RAPIDJSON_UINT64_C2(0xbe5691ef, 0x416bd60c), RAPIDJSON_UINT64_C2(0x8dd01fad, 0x907ffc3c),
        RAPIDJSON_UINT64_C2(0xd3515c28, 0x31559a83), RAPIDJSON_UINT64_C2(0x9d71ac8f, 0xada6c9b5),
        RAPIDJSON_UINT64_C2(0xea9c2277, 0x23ee8bcb), RAPIDJSON_UINT64_C2(0xaecc4991, 0x4078536d),
        RAPIDJSON_UINT64_C2(0x823c1279, 0x5db6ce57), RAPIDJSON_UINT64_C2(0xc2109436, 0x4dfb5637),
        RAPIDJSON_UINT64_C2(0x9096ea6f, 0x3848984f), RAPIDJSON_UINT64_C2(0xd77485cb, 0x25823ac7),
        RAPIDJSON_UINT64_C2(0xa086cfcd, 0x97bf97f4), RAPIDJSON_UINT64_C2(0xef340a98, 0x172aace5),
        RAPIDJSON_UINT64_C2(0xb23867fb, 0x2a35b28e), RAPIDJSON_UINT64_C2(0x84c8d4df, 0xd2c63f3b),
        RAPIDJSON_UINT64_C2(0xc5dd4427, 0x1ad3cdba), RAPIDJSON_UINT64_C2(0x936b9fce, 0xbb25c996),
        RAPIDJSON_UINT64_C2(0xdbac6c24, 0x7d62a584), RAPIDJSON_UINT64_C2(0xa3ab6658, 0x0d5fdaf6),
        RAPIDJSON_UINT64_C2(0xf3e2f893, 0xdec3f126), RAPIDJSON_UINT64_C2(0xb5b5ada8, 0xaaff80b8),
        RAPIDJSON_UINT64_C2(0x87625f05, 0x6c7c4a8b), RAPIDJSON_UINT64_C2(0xc9bcff60, 0x34c13053),
        RAPIDJSON_UINT64_C2(0x964e858c, 0x91ba2655), RAPIDJSON_UINT64_C2(0xdff97724, 0x70297ebd),
        RAPIDJSON_UINT64_C2(0xa6dfbd9f, 0xb8e5b88f), RAPIDJSON_UINT64_C2(0xf8a95fcf, 0x88747d94),
        RAPIDJSON_UINT64_C2(0xb9447093, 0x8fa89bcf), RAPIDJSON_UINT64_C2(0x8a08f0f8, 0xbf0f156b),
        RAPIDJSON_UINT64_C2(0xcdb02555, 0x653131b6), RAPIDJSON_UINT64_C2(0x993fe2c6, 0xd07b7fac),
        RAPIDJSON_UINT64_C2(0xe45c10c4, 0x2a2b3b06), RAPIDJSON_UINT64_C2(0xaa242499, 0x697392d3),
        RAPIDJSON_UINT64_C2(0xfd87b5f2, 0x8300ca0e), RAPIDJSON_UINT64_C2(0xbce50864, 0x92111aeb),
        RAPIDJSON_UINT64_C2(0x8cbccc09, 0x6f5088cc), RAPIDJSON_UINT64_C2(0xd1b71758, 0xe219652c),
        RAPIDJSON_UINT64_C2(0x9c400000, 0x00000000), RAPIDJSON_UINT64_C2(0xe8d4a510, 0x00000000),
        RAPIDJSON_UINT64_C2(0xad78ebc5, 0xac620000), RAPIDJSON_UINT64_C2(0x813f3978, 0xf8940984),
        RAPIDJSON_UINT64_C2(0xc097ce7b, 0xc90715b3), RAPIDJSON_UINT64_C2(0x8f7e32ce, 0x7bea5c70),
        RAPIDJSON_UINT64_C2(0xd5d238a4, 0xabe98068), RAPIDJSON_UINT64_C2(0x9f4f2726, 0x179a2245),
        RAPIDJSON_UINT64_C2(0xed63a231, 0xd4c4fb27), RAPIDJSON_UINT64_C2(0xb0de6538, 0x8cc8ada8),
        RAPIDJSON_UINT64_C2(0x83c7088e, 0x1aab65db), RAPIDJSON_UINT64_C2(0xc45d1df9, 0x42711d9a),
        RAPIDJSON_UINT64_C2(0x924d692c, 0xa61be758), RAPIDJSON_UINT64_C2(0xda01ee64, 0x1a708dea),
        RAPIDJSON_UINT64_C2(0xa26da399, 0x9aef774a), RAPIDJSON_UINT64_C2(0xf209787b, 0xb47d6b85),
        RAPIDJSON_UINT64_C2(0xb454e4a1, 0x79dd1877), RAPIDJSON_UINT64_C2(0x865b8692, 0x5b9bc5c2),
        RAPIDJSON_UINT64_C2(0xc83553c5, 0xc8965d3d), RAPIDJSON_UINT64_C2(0x952ab45c, 0xfa97a0b3),
        RAPIDJSON_UINT64_C2(0xde469fbd, 0x99a05fe3), RAPIDJSON_UINT64_C2(0xa59bc234, 0xdb398c25),
        RAPIDJSON_UINT64_C2(0xf6c69a72, 0xa3989f5c), RAPIDJSON_UINT64_C2(0xb7dcbf53, 0x54e9bece),
        RAPIDJSON_UINT64_C2(0x88fcf317, 0xf22241e2), RAPIDJSON_UINT64_C2(0xcc20ce9b, 0xd35c78a5),
        RAPIDJSON_UINT64_C2(0x98165af3, 0x7b2153df), RAPIDJSON_UINT64_C2(0xe2a0b5dc, 0x971f303a),
        RAPIDJSON_UINT64_C2(0xa8d9d153, 0x5ce3b396), RAPIDJSON_UINT64_C2(0xfb9b7cd9, 0xa4a7443c),
        RAPIDJSON_UINT64_C2(0xbb764c4c, 0xa7a44410), RAPIDJSON_UINT64_C2(0x8bab8eef, 0xb6409c1a),
        RAPIDJSON_UINT64_C2(0xd01fef10, 0xa657842c), RAPIDJSON_UINT64_C2(0x9b10a4e5, 0xe9913129),
        RAPIDJSON_UINT64_C2(0xe7109bfb, 0xa19c0c9d), RAPIDJSON_UINT64_C2(0xac2820d9, 0x623bf429),
        RAPIDJSON_UINT64_C2(0x80444b5e, 0x7aa7cf85), RAPIDJSON_UINT64_C2(0xbf21e440, 0x03acdd2d),
        RAPIDJSON_UINT64_C2(0x8e679c2f, 0x5e44ff8f), RAPIDJSON_UINT64_C2(0xd433179d, 0x9c8cb841),
        RAPIDJSON_UINT64_C2(0x9e19db92, 0xb4e31ba9), RAPIDJSON_UINT64_C2(0xeb96bf6e, 0xbadf77d9),
        RAPIDJSON_UINT64_C2(0xaf87023b, 0x9bf0ee6b)
    };
    static const int16_t kCachedPowers_E[] = {
        -1220, -1193, -1166, -1140, -1113, -1087, -1060, -1034, -1007,  -980,
         -954,  -927,  -901,  -874,  -847,  -821,  -794,  -768,  -741,  -715,
         -688,  -661,  -635,  -608,  -582,  -555,  -529,  -502,  -475,  -449,
         -422,  -396,  -369,  -343,  -316,  -289,  -263,  -236,  -210,  -183,
         -157,  -130,  -103,   -77,   -50,   -24,     3,    30,    56,    83,
          109,   136,   162,   189,   216,   242,   269,   295,   322,   348,
          375,   402,   428,   455,   481,   508,   534,   561,   588,   614,
          641,   667,   694,   720,   747,   774,   800,   827,   853,   880,
          907,   933,   960,   986,  1013,  1039,  1066
    };

    //int k = static_cast<int>(ceil((-61 - e) * 0.30102999566398114)) + 374;
    double dk = (-61 - e) * 0.30102999566398114 + 347;  // dk must be positive, so can do ceiling in positive
    int k = static_cast<int>(dk);
    if (k != dk)
        k++;

    unsigned index = static_cast<unsigned>((k >> 3) + 1);
    *K = -(-348 + static_cast<int>(index << 3));    // decimal exponent no need lookup table

    return DiyFp(kCachedPowers_F[index], kCachedPowers_E[index]);
}

inline void GrisuRound(char* buffer, int len, uint64_t delta, uint64_t rest, uint64_t ten_kappa, uint64_t wp_w) {
    while (rest < wp_w && delta - rest >= ten_kappa &&
           (rest + ten_kappa < wp_w ||  /// closer
            wp_w - rest > rest + ten_kappa - wp_w)) {
        buffer[len - 1]--;
        rest += ten_kappa;
    }
}

inline unsigned CountDecimalDigit32(uint32_t n) {
    // Simple pure C++ implementation was faster than __builtin_clz version in this situation.
    if (n < 10) return 1;
    if (n < 100) return 2;
    if (n < 1000) return 3;
    if (n < 10000) return 4;
    if (n < 100000) return 5;
    if (n < 1000000) return 6;
    if (n < 10000000) return 7;
    if (n < 100000000) return 8;
    if (n < 1000000000) return 9;
    return 10;
}

inline void DigitGen(const DiyFp& W, const DiyFp& Mp, uint64_t delta, char* buffer, int* len, int* K) {
    static const uint32_t kPow10[] = { 1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, 1000000000 };
    const DiyFp one(uint64_t(1) << -Mp.e, Mp.e);
    const DiyFp wp_w = Mp - W;
    uint32_t p1 = static_cast<uint32_t>(Mp.f >> -one.e);
    uint64_t p2 = Mp.f & (one.f - 1);
    int kappa = CountDecimalDigit32(p1);
    *len = 0;

    while (kappa > 0) {
        uint32_t d;
        switch (kappa) {
            case 10: d = p1 / 1000000000; p1 %= 1000000000; break;
            case  9: d = p1 /  100000000; p1 %=  100000000; break;
            case  8: d = p1 /   10000000; p1 %=   10000000; break;
            case  7: d = p1 /    1000000; p1 %=    1000000; break;
            case  6: d = p1 /     100000; p1 %=     100000; break;
            case  5: d = p1 /      10000; p1 %=      10000; break;
            case  4: d = p1 /       1000; p1 %=       1000; break;
            case  3: d = p1 /        100; p1 %=        100; break;
            case  2: d = p1 /         10; p1 %=         10; break;
            case  1: d = p1;              p1 =           0; break;
            default: 
#if defined(_MSC_VER)
                __assume(0);
#elif __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 5)
                __builtin_unreachable();
#else
                d = 0;
#endif
        }
        if (d || *len)
            buffer[(*len)++] = '0' + static_cast<char>(d);
        kappa--;
        uint64_t tmp = (static_cast<uint64_t>(p1) << -one.e) + p2;
        if (tmp <= delta) {
            *K += kappa;
            GrisuRound(buffer, *len, delta, tmp, static_cast<uint64_t>(kPow10[kappa]) << -one.e, wp_w.f);
            return;
        }
    }

    // kappa = 0
    for (;;) {
        p2 *= 10;
        delta *= 10;
        char d = static_cast<char>(p2 >> -one.e);
        if (d || *len)
            buffer[(*len)++] = '0' + d;
        p2 &= one.f - 1;
        kappa--;
        if (p2 < delta) {
            *K += kappa;
            GrisuRound(buffer, *len, delta, p2, one.f, wp_w.f * kPow10[-kappa]);
            return;
        }
    }
}

inline void Grisu2(double value, char* buffer, int* length, int* K) {
    const DiyFp v(value);
    DiyFp w_m, w_p;
    v.NormalizedBoundaries(&w_m, &w_p);

    const DiyFp c_mk = GetCachedPower(w_p.e, K);
    const DiyFp W = v.Normalize() * c_mk;
    DiyFp Wp = w_p * c_mk;
    DiyFp Wm = w_m * c_mk;
    Wm.f++;
    Wp.f--;
    DigitGen(W, Wp, Wp.f - Wm.f, buffer, length, K);
}

inline char* WriteExponent(int K, char* buffer) {
    if (K < 0) {
        *buffer++ = '-';
        K = -K;
    }

    if (K >= 100) {
        *buffer++ = '0' + static_cast<char>(K / 100);
        K %= 100;
        const char* d = GetDigitsLut() + K * 2;
        *buffer++ = d[0];
        *buffer++ = d[1];
    }
    else if (K >= 10) {
        const char* d = GetDigitsLut() + K * 2;
        *buffer++ = d[0];
        *buffer++ = d[1];
    }
    else
        *buffer++ = '0' + static_cast<char>(K);

    return buffer;
}

inline char* Prettify(char* buffer, int length, int k) {
    const int kk = length + k;  // 10^(kk-1) <= v < 10^kk

    if (length <= kk && kk <= 21) {
        // 1234e7 -> 12340000000
        for (int i = length; i < kk; i++)
            buffer[i] = '0';
        buffer[kk] = '.';
        buffer[kk + 1] = '0';
        return &buffer[kk + 2];
    }
    else if (0 < kk && kk <= 21) {
        // 1234e-2 -> 12.34
        memmove(&buffer[kk + 1], &buffer[kk], length - kk);
        buffer[kk] = '.';
        return &buffer[length + 1];
    }
    else if (-6 < kk && kk <= 0) {
        // 1234e-6 -> 0.001234
        const int offset = 2 - kk;
        memmove(&buffer[offset], &buffer[0], length);
        buffer[0] = '0';
        buffer[1] = '.';
        for (int i = 2; i < offset; i++)
            buffer[i] = '0';
        return &buffer[length + offset];
    }
    else if (length == 1) {
        // 1e30
        buffer[1] = 'e';
        return WriteExponent(kk - 1, &buffer[2]);
    }
    else {
        // 1234e30 -> 1.234e33
        memmove(&buffer[2], &buffer[1], length - 1);
        buffer[1] = '.';
        buffer[length + 1] = 'e';
        return WriteExponent(kk - 1, &buffer[0 + length + 2]);
    }
}

inline char* dtoa(double value, char* buffer) {
    if (value == 0) {
        buffer[0] = '0';
        buffer[1] = '.';
        buffer[2] = '0';
        return &buffer[3];
    }
    else {
        if (value < 0) {
            *buffer++ = '-';
            value = -value;
        }
        int length, K;
        Grisu2(value, buffer, &length, &K);
        return Prettify(buffer, length, K);
    }
}

#ifdef __GNUC__
RAPIDJSON_DIAG_POP
#endif

} // namespace internal
} // namespace rapidjson

#endif // RAPIDJSON_DTOA_

//==============================================================================
// internal/meta.h
//==============================================================================

// Copyright (C) 2011 Milo Yip
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#ifndef RAPIDJSON_INTERNAL_META_H_
#define RAPIDJSON_INTERNAL_META_H_

#ifdef __GNUC__
RAPIDJSON_DIAG_PUSH
RAPIDJSON_DIAG_OFF(effc++)
#endif
#if defined(_MSC_VER)
RAPIDJSON_DIAG_PUSH
RAPIDJSON_DIAG_OFF(6334)
#endif

#ifdef RAPIDJSON_HAS_CXX11_TYPETRAITS
#include <type_traits>
#endif

//@cond RAPIDJSON_INTERNAL
namespace rapidjson {
namespace internal {


///////////////////////////////////////////////////////////////////////////////
// BoolType, TrueType, FalseType
//
template <bool Cond> struct BoolType {
    static const bool Value = Cond;
    typedef BoolType Type;
};
typedef BoolType<true> TrueType;
typedef BoolType<false> FalseType;


///////////////////////////////////////////////////////////////////////////////
// SelectIf, BoolExpr, NotExpr, AndExpr, OrExpr
//

template <bool C> struct SelectIfImpl { template <typename T1, typename T2> struct Apply { typedef T1 Type; }; };
template <> struct SelectIfImpl<false> { template <typename T1, typename T2> struct Apply { typedef T2 Type; }; };
template <bool C, typename T1, typename T2> struct SelectIfCond : SelectIfImpl<C>::template Apply<T1,T2> {};
template <typename C, typename T1, typename T2> struct SelectIf : SelectIfCond<C::Value, T1, T2> {};

template <bool Cond1, bool Cond2> struct AndExprCond : FalseType {};
template <> struct AndExprCond<true, true> : TrueType {};
template <bool Cond1, bool Cond2> struct OrExprCond : TrueType {};
template <> struct OrExprCond<false, false> : FalseType {};

template <typename C> struct BoolExpr : SelectIf<C,TrueType,FalseType>::Type {};
template <typename C> struct NotExpr  : SelectIf<C,FalseType,TrueType>::Type {};
template <typename C1, typename C2> struct AndExpr : AndExprCond<C1::Value, C2::Value>::Type {};
template <typename C1, typename C2> struct OrExpr  : OrExprCond<C1::Value, C2::Value>::Type {};


///////////////////////////////////////////////////////////////////////////////
// AddConst, MaybeAddConst, RemoveConst
template <typename T> struct AddConst { typedef const T Type; };
template <bool Constify, typename T> struct MaybeAddConst : SelectIfCond<Constify, const T, T> {};
template <typename T> struct RemoveConst { typedef T Type; };
template <typename T> struct RemoveConst<const T> { typedef T Type; };


///////////////////////////////////////////////////////////////////////////////
// IsSame, IsConst, IsMoreConst, IsPointer
//
template <typename T, typename U> struct IsSame : FalseType {};
template <typename T> struct IsSame<T, T> : TrueType {};

template <typename T> struct IsConst : FalseType {};
template <typename T> struct IsConst<const T> : TrueType {};

template <typename CT, typename T>
struct IsMoreConst
    : AndExpr<IsSame<typename RemoveConst<CT>::Type, typename RemoveConst<T>::Type>,
              BoolType<IsConst<CT>::Value >= IsConst<T>::Value> >::Type {};

template <typename T> struct IsPointer : FalseType {};
template <typename T> struct IsPointer<T*> : TrueType {};

///////////////////////////////////////////////////////////////////////////////
// IsBaseOf
//
#ifdef RAPIDJSON_HAS_CXX11_TYPETRAITS

template <typename B, typename D> struct IsBaseOf
    : BoolType< ::std::is_base_of<B,D>::value> {};

#else // simplified version adopted from Boost

template<typename B, typename D> struct IsBaseOfImpl {
    RAPIDJSON_STATIC_ASSERT(sizeof(B) != 0);
    RAPIDJSON_STATIC_ASSERT(sizeof(D) != 0);

    typedef char (&Yes)[1];
    typedef char (&No) [2];

    template <typename T>
    static Yes Check(const D*, T);
    static No  Check(const B*, int);

    struct Host {
        operator const B*() const;
        operator const D*();
    };

    enum { Value = (sizeof(Check(Host(), 0)) == sizeof(Yes)) };
};

template <typename B, typename D> struct IsBaseOf
    : OrExpr<IsSame<B, D>, BoolExpr<IsBaseOfImpl<B, D> > >::Type {};

#endif // RAPIDJSON_HAS_CXX11_TYPETRAITS


//////////////////////////////////////////////////////////////////////////
// EnableIf / DisableIf
//
template <bool Condition, typename T = void> struct EnableIfCond  { typedef T Type; };
template <typename T> struct EnableIfCond<false, T> { /* empty */ };

template <bool Condition, typename T = void> struct DisableIfCond { typedef T Type; };
template <typename T> struct DisableIfCond<true, T> { /* empty */ };

template <typename Condition, typename T = void>
struct EnableIf : EnableIfCond<Condition::Value, T> {};

template <typename Condition, typename T = void>
struct DisableIf : DisableIfCond<Condition::Value, T> {};

// SFINAE helpers
struct SfinaeTag {};
template <typename T> struct RemoveSfinaeTag;
template <typename T> struct RemoveSfinaeTag<SfinaeTag&(*)(T)> { typedef T Type; };

#define RAPIDJSON_REMOVEFPTR_(type) \
    typename ::rapidjson::internal::RemoveSfinaeTag \
        < ::rapidjson::internal::SfinaeTag&(*) type>::Type

#define RAPIDJSON_ENABLEIF(cond) \
    typename ::rapidjson::internal::EnableIf \
        <RAPIDJSON_REMOVEFPTR_(cond)>::Type * = NULL

#define RAPIDJSON_DISABLEIF(cond) \
    typename ::rapidjson::internal::DisableIf \
        <RAPIDJSON_REMOVEFPTR_(cond)>::Type * = NULL

#define RAPIDJSON_ENABLEIF_RETURN(cond,returntype) \
    typename ::rapidjson::internal::EnableIf \
        <RAPIDJSON_REMOVEFPTR_(cond), \
         RAPIDJSON_REMOVEFPTR_(returntype)>::Type

#define RAPIDJSON_DISABLEIF_RETURN(cond,returntype) \
    typename ::rapidjson::internal::DisableIf \
        <RAPIDJSON_REMOVEFPTR_(cond), \
         RAPIDJSON_REMOVEFPTR_(returntype)>::Type

} // namespace internal
} // namespace rapidjson
//@endcond

#if defined(__GNUC__) || defined(_MSC_VER)
RAPIDJSON_DIAG_POP
#endif

#endif // RAPIDJSON_INTERNAL_META_H_n

//==============================================================================
// internal/pow10.h
//==============================================================================

// Copyright (C) 2011 Milo Yip
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#ifndef RAPIDJSON_POW10_
#define RAPIDJSON_POW10_

namespace rapidjson {
namespace internal {

//! Computes integer powers of 10 in double (10.0^n).
/*! This function uses lookup table for fast and accurate results.
    \param n non-negative exponent. Must <= 308.
    \return 10.0^n
*/
inline double Pow10(int n) {
    static const double e[] = { // 1e-0...1e308: 309 * 8 bytes = 2472 bytes
        1e+0,  
        1e+1,  1e+2,  1e+3,  1e+4,  1e+5,  1e+6,  1e+7,  1e+8,  1e+9,  1e+10, 1e+11, 1e+12, 1e+13, 1e+14, 1e+15, 1e+16, 1e+17, 1e+18, 1e+19, 1e+20, 
        1e+21, 1e+22, 1e+23, 1e+24, 1e+25, 1e+26, 1e+27, 1e+28, 1e+29, 1e+30, 1e+31, 1e+32, 1e+33, 1e+34, 1e+35, 1e+36, 1e+37, 1e+38, 1e+39, 1e+40,
        1e+41, 1e+42, 1e+43, 1e+44, 1e+45, 1e+46, 1e+47, 1e+48, 1e+49, 1e+50, 1e+51, 1e+52, 1e+53, 1e+54, 1e+55, 1e+56, 1e+57, 1e+58, 1e+59, 1e+60,
        1e+61, 1e+62, 1e+63, 1e+64, 1e+65, 1e+66, 1e+67, 1e+68, 1e+69, 1e+70, 1e+71, 1e+72, 1e+73, 1e+74, 1e+75, 1e+76, 1e+77, 1e+78, 1e+79, 1e+80,
        1e+81, 1e+82, 1e+83, 1e+84, 1e+85, 1e+86, 1e+87, 1e+88, 1e+89, 1e+90, 1e+91, 1e+92, 1e+93, 1e+94, 1e+95, 1e+96, 1e+97, 1e+98, 1e+99, 1e+100,
        1e+101,1e+102,1e+103,1e+104,1e+105,1e+106,1e+107,1e+108,1e+109,1e+110,1e+111,1e+112,1e+113,1e+114,1e+115,1e+116,1e+117,1e+118,1e+119,1e+120,
        1e+121,1e+122,1e+123,1e+124,1e+125,1e+126,1e+127,1e+128,1e+129,1e+130,1e+131,1e+132,1e+133,1e+134,1e+135,1e+136,1e+137,1e+138,1e+139,1e+140,
        1e+141,1e+142,1e+143,1e+144,1e+145,1e+146,1e+147,1e+148,1e+149,1e+150,1e+151,1e+152,1e+153,1e+154,1e+155,1e+156,1e+157,1e+158,1e+159,1e+160,
        1e+161,1e+162,1e+163,1e+164,1e+165,1e+166,1e+167,1e+168,1e+169,1e+170,1e+171,1e+172,1e+173,1e+174,1e+175,1e+176,1e+177,1e+178,1e+179,1e+180,
        1e+181,1e+182,1e+183,1e+184,1e+185,1e+186,1e+187,1e+188,1e+189,1e+190,1e+191,1e+192,1e+193,1e+194,1e+195,1e+196,1e+197,1e+198,1e+199,1e+200,
        1e+201,1e+202,1e+203,1e+204,1e+205,1e+206,1e+207,1e+208,1e+209,1e+210,1e+211,1e+212,1e+213,1e+214,1e+215,1e+216,1e+217,1e+218,1e+219,1e+220,
        1e+221,1e+222,1e+223,1e+224,1e+225,1e+226,1e+227,1e+228,1e+229,1e+230,1e+231,1e+232,1e+233,1e+234,1e+235,1e+236,1e+237,1e+238,1e+239,1e+240,
        1e+241,1e+242,1e+243,1e+244,1e+245,1e+246,1e+247,1e+248,1e+249,1e+250,1e+251,1e+252,1e+253,1e+254,1e+255,1e+256,1e+257,1e+258,1e+259,1e+260,
        1e+261,1e+262,1e+263,1e+264,1e+265,1e+266,1e+267,1e+268,1e+269,1e+270,1e+271,1e+272,1e+273,1e+274,1e+275,1e+276,1e+277,1e+278,1e+279,1e+280,
        1e+281,1e+282,1e+283,1e+284,1e+285,1e+286,1e+287,1e+288,1e+289,1e+290,1e+291,1e+292,1e+293,1e+294,1e+295,1e+296,1e+297,1e+298,1e+299,1e+300,
        1e+301,1e+302,1e+303,1e+304,1e+305,1e+306,1e+307,1e+308
    };
    RAPIDJSON_ASSERT(n >= 0 && n <= 308);
    return e[n];
}

} // namespace internal
} // namespace rapidjson

#endif // RAPIDJSON_POW10_

//==============================================================================
// internal/stack.h
//==============================================================================

// Copyright (C) 2011 Milo Yip
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#ifndef RAPIDJSON_INTERNAL_STACK_H_
#define RAPIDJSON_INTERNAL_STACK_H_

namespace rapidjson {
namespace internal {

///////////////////////////////////////////////////////////////////////////////
// Stack

//! A type-unsafe stack for storing different types of data.
/*! \tparam Allocator Allocator for allocating stack memory.
*/
template <typename Allocator>
class Stack {
public:
    // Optimization note: Do not allocate memory for stack_ in constructor.
    // Do it lazily when first Push() -> Expand() -> Resize().
    Stack(Allocator* allocator, size_t stackCapacity) : allocator_(allocator), ownAllocator(0), stack_(0), stackTop_(0), stackEnd_(0), initialCapacity_(stackCapacity) {
        RAPIDJSON_ASSERT(stackCapacity > 0);
        if (!allocator_)
            ownAllocator = allocator_ = new Allocator();
    }

    ~Stack() {
        Allocator::Free(stack_);
        delete ownAllocator; // Only delete if it is owned by the stack
    }

    void Clear() { stackTop_ = stack_; }

    void ShrinkToFit() { 
        if (Empty()) {
            // If the stack is empty, completely deallocate the memory.
            Allocator::Free(stack_);
            stack_ = 0;
            stackTop_ = 0;
            stackEnd_ = 0;
        }
        else
            Resize(GetSize());
    }

    // Optimization note: try to minimize the size of this function for force inline.
    // Expansion is run very infrequently, so it is moved to another (probably non-inline) function.
    template<typename T>
    RAPIDJSON_FORCEINLINE T* Push(size_t count = 1) {
         // Expand the stack if needed
        if (stackTop_ + sizeof(T) * count >= stackEnd_)
            Expand<T>(count);

        T* ret = reinterpret_cast<T*>(stackTop_);
        stackTop_ += sizeof(T) * count;
        return ret;
    }

    template<typename T>
    T* Pop(size_t count) {
        RAPIDJSON_ASSERT(GetSize() >= count * sizeof(T));
        stackTop_ -= count * sizeof(T);
        return reinterpret_cast<T*>(stackTop_);
    }

    template<typename T>
    T* Top() { 
        RAPIDJSON_ASSERT(GetSize() >= sizeof(T));
        return reinterpret_cast<T*>(stackTop_ - sizeof(T));
    }

    template<typename T>
    T* Bottom() { return (T*)stack_; }

    Allocator& GetAllocator() { return *allocator_; }
    bool Empty() const { return stackTop_ == stack_; }
    size_t GetSize() const { return static_cast<size_t>(stackTop_ - stack_); }
    size_t GetCapacity() const { return static_cast<size_t>(stackEnd_ - stack_); }

private:
    template<typename T>
    void Expand(size_t count) {
        // Only expand the capacity if the current stack exists. Otherwise just create a stack with initial capacity.
        size_t newCapacity = (stack_ == 0) ? initialCapacity_ : GetCapacity() * 2;
        size_t newSize = GetSize() + sizeof(T) * count;
        if (newCapacity < newSize)
            newCapacity = newSize;

        Resize(newCapacity);
    }

    void Resize(size_t newCapacity) {
        const size_t size = GetSize();  // Backup the current size
        stack_ = (char*)allocator_->Realloc(stack_, GetCapacity(), newCapacity);
        stackTop_ = stack_ + size;
        stackEnd_ = stack_ + newCapacity;
    }

    // Prohibit copy constructor & assignment operator.
    Stack(const Stack&);
    Stack& operator=(const Stack&);

    Allocator* allocator_;
    Allocator* ownAllocator;
    char *stack_;
    char *stackTop_;
    char *stackEnd_;
    size_t initialCapacity_;
};

} // namespace internal
} // namespace rapidjson

#endif // RAPIDJSON_STACK_H_

//==============================================================================
// internal/strfunc.h
//==============================================================================

// Copyright (C) 2011 Milo Yip
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#ifndef RAPIDJSON_INTERNAL_STRFUNC_H_
#define RAPIDJSON_INTERNAL_STRFUNC_H_

namespace rapidjson {
namespace internal {

//! Custom strlen() which works on different character types.
/*! \tparam Ch Character type (e.g. char, wchar_t, short)
    \param s Null-terminated input string.
    \return Number of characters in the string. 
    \note This has the same semantics as strlen(), the return value is not number of Unicode codepoints.
*/
template <typename Ch>
inline SizeType StrLen(const Ch* s) {
    const Ch* p = s;
    while (*p) ++p;
    return SizeType(p - s);
}

} // namespace internal
} // namespace rapidjson

#endif // RAPIDJSON_INTERNAL_STRFUNC_H_

///////////////////////////////////////////////////////////////////////////////
// Allocators and Encodings

//==============================================================================
// allocators.h
//==============================================================================

// Copyright (C) 2011 Milo Yip
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#ifndef RAPIDJSON_ALLOCATORS_H_
#define RAPIDJSON_ALLOCATORS_H_

namespace rapidjson {

///////////////////////////////////////////////////////////////////////////////
// Allocator

/*! \class rapidjson::Allocator
    \brief Concept for allocating, resizing and freeing memory block.
    
    Note that Malloc() and Realloc() are non-static but Free() is static.
    
    So if an allocator need to support Free(), it needs to put its pointer in 
    the header of memory block.

\code
concept Allocator {
    static const bool kNeedFree;    //!< Whether this allocator needs to call Free().

    // Allocate a memory block.
    // \param size of the memory block in bytes.
    // \returns pointer to the memory block.
    void* Malloc(size_t size);

    // Resize a memory block.
    // \param originalPtr The pointer to current memory block. Null pointer is permitted.
    // \param originalSize The current size in bytes. (Design issue: since some allocator may not book-keep this, explicitly pass to it can save memory.)
    // \param newSize the new size in bytes.
    void* Realloc(void* originalPtr, size_t originalSize, size_t newSize);

    // Free a memory block.
    // \param pointer to the memory block. Null pointer is permitted.
    static void Free(void *ptr);
};
\endcode
*/

///////////////////////////////////////////////////////////////////////////////
// CrtAllocator

//! C-runtime library allocator.
/*! This class is just wrapper for standard C library memory routines.
    \note implements Allocator concept
*/
class CrtAllocator {
public:
    static const bool kNeedFree = true;
    void* Malloc(size_t size) { return malloc(size); }
    void* Realloc(void* originalPtr, size_t originalSize, size_t newSize) { (void)originalSize; return realloc(originalPtr, newSize); }
    static void Free(void *ptr) { free(ptr); }
};

///////////////////////////////////////////////////////////////////////////////
// MemoryPoolAllocator

//! Default memory allocator used by the parser and DOM.
/*! This allocator allocate memory blocks from pre-allocated memory chunks. 

    It does not free memory blocks. And Realloc() only allocate new memory.

    The memory chunks are allocated by BaseAllocator, which is CrtAllocator by default.

    User may also supply a buffer as the first chunk.

    If the user-buffer is full then additional chunks are allocated by BaseAllocator.

    The user-buffer is not deallocated by this allocator.

    \tparam BaseAllocator the allocator type for allocating memory chunks. Default is CrtAllocator.
    \note implements Allocator concept
*/
template <typename BaseAllocator = CrtAllocator>
class MemoryPoolAllocator {
public:
    static const bool kNeedFree = false;    //!< Tell users that no need to call Free() with this allocator. (concept Allocator)

    //! Constructor with chunkSize.
    /*! \param chunkSize The size of memory chunk. The default is kDefaultChunkSize.
        \param baseAllocator The allocator for allocating memory chunks.
    */
    MemoryPoolAllocator(size_t chunkSize = kDefaultChunkCapacity, BaseAllocator* baseAllocator = 0) : 
        chunkHead_(0), chunk_capacity_(chunkSize), userBuffer_(0), baseAllocator_(baseAllocator), ownBaseAllocator_(0)
    {
        if (!baseAllocator_)
            ownBaseAllocator_ = baseAllocator_ = new BaseAllocator();
        AddChunk(chunk_capacity_);
    }

    //! Constructor with user-supplied buffer.
    /*! The user buffer will be used firstly. When it is full, memory pool allocates new chunk with chunk size.

        The user buffer will not be deallocated when this allocator is destructed.

        \param buffer User supplied buffer.
        \param size Size of the buffer in bytes. It must at least larger than sizeof(ChunkHeader).
        \param chunkSize The size of memory chunk. The default is kDefaultChunkSize.
        \param baseAllocator The allocator for allocating memory chunks.
    */
    MemoryPoolAllocator(void *buffer, size_t size, size_t chunkSize = kDefaultChunkCapacity, BaseAllocator* baseAllocator = 0) :
        chunkHead_(0), chunk_capacity_(chunkSize), userBuffer_(buffer), baseAllocator_(baseAllocator), ownBaseAllocator_(0)
    {
        RAPIDJSON_ASSERT(buffer != 0);
        RAPIDJSON_ASSERT(size > sizeof(ChunkHeader));
        chunkHead_ = reinterpret_cast<ChunkHeader*>(buffer);
        chunkHead_->capacity = size - sizeof(ChunkHeader);
        chunkHead_->size = 0;
        chunkHead_->next = 0;
    }

    //! Destructor.
    /*! This deallocates all memory chunks, excluding the user-supplied buffer.
    */
    ~MemoryPoolAllocator() {
        Clear();
        delete ownBaseAllocator_;
    }

    //! Deallocates all memory chunks, excluding the user-supplied buffer.
    void Clear() {
        while(chunkHead_ != 0 && chunkHead_ != userBuffer_) {
            ChunkHeader* next = chunkHead_->next;
            baseAllocator_->Free(chunkHead_);
            chunkHead_ = next;
        }
    }

    //! Computes the total capacity of allocated memory chunks.
    /*! \return total capacity in bytes.
    */
    size_t Capacity() const {
        size_t capacity = 0;
        for (ChunkHeader* c = chunkHead_; c != 0; c = c->next)
            capacity += c->capacity;
        return capacity;
    }

    //! Computes the memory blocks allocated.
    /*! \return total used bytes.
    */
    size_t Size() const {
        size_t size = 0;
        for (ChunkHeader* c = chunkHead_; c != 0; c = c->next)
            size += c->size;
        return size;
    }

    //! Allocates a memory block. (concept Allocator)
    void* Malloc(size_t size) {
        size = RAPIDJSON_ALIGN(size);
        if (chunkHead_->size + size > chunkHead_->capacity)
            AddChunk(chunk_capacity_ > size ? chunk_capacity_ : size);

        void *buffer = reinterpret_cast<char *>(chunkHead_ + 1) + chunkHead_->size;
        chunkHead_->size += size;
        return buffer;
    }

    //! Resizes a memory block (concept Allocator)
    void* Realloc(void* originalPtr, size_t originalSize, size_t newSize) {
        if (originalPtr == 0)
            return Malloc(newSize);

        // Do not shrink if new size is smaller than original
        if (originalSize >= newSize)
            return originalPtr;

        // Simply expand it if it is the last allocation and there is sufficient space
        if (originalPtr == (char *)(chunkHead_ + 1) + chunkHead_->size - originalSize) {
            size_t increment = static_cast<size_t>(newSize - originalSize);
            increment = RAPIDJSON_ALIGN(increment);
            if (chunkHead_->size + increment <= chunkHead_->capacity) {
                chunkHead_->size += increment;
                return originalPtr;
            }
        }

        // Realloc process: allocate and copy memory, do not free original buffer.
        void* newBuffer = Malloc(newSize);
        RAPIDJSON_ASSERT(newBuffer != 0);   // Do not handle out-of-memory explicitly.
        return memcpy(newBuffer, originalPtr, originalSize);
    }

    //! Frees a memory block (concept Allocator)
    static void Free(void *ptr) { (void)ptr; } // Do nothing

private:
    //! Copy constructor is not permitted.
    MemoryPoolAllocator(const MemoryPoolAllocator& rhs) /* = delete */;
    //! Copy assignment operator is not permitted.
    MemoryPoolAllocator& operator=(const MemoryPoolAllocator& rhs) /* = delete */;

    //! Creates a new chunk.
    /*! \param capacity Capacity of the chunk in bytes.
    */
    void AddChunk(size_t capacity) {
        ChunkHeader* chunk = reinterpret_cast<ChunkHeader*>(baseAllocator_->Malloc(sizeof(ChunkHeader) + capacity));
        chunk->capacity = capacity;
        chunk->size = 0;
        chunk->next = chunkHead_;
        chunkHead_ =  chunk;
    }

    static const int kDefaultChunkCapacity = 64 * 1024; //!< Default chunk capacity.

    //! Chunk header for perpending to each chunk.
    /*! Chunks are stored as a singly linked list.
    */
    struct ChunkHeader {
        size_t capacity;    //!< Capacity of the chunk in bytes (excluding the header itself).
        size_t size;        //!< Current size of allocated memory in bytes.
        ChunkHeader *next;  //!< Next chunk in the linked list.
    };

    ChunkHeader *chunkHead_;    //!< Head of the chunk linked-list. Only the head chunk serves allocation.
    size_t chunk_capacity_;     //!< The minimum capacity of chunk when they are allocated.
    void *userBuffer_;          //!< User supplied buffer.
    BaseAllocator* baseAllocator_;  //!< base allocator for allocating memory chunks.
    BaseAllocator* ownBaseAllocator_;   //!< base allocator created by this object.
};

} // namespace rapidjson

#endif // RAPIDJSON_ENCODINGS_H_

//==============================================================================
// encoding.h
//==============================================================================

// Copyright (C) 2011 Milo Yip
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#ifndef RAPIDJSON_ENCODINGS_H_
#define RAPIDJSON_ENCODINGS_H_

#ifdef _MSC_VER
RAPIDJSON_DIAG_PUSH
RAPIDJSON_DIAG_OFF(4244) // conversion from 'type1' to 'type2', possible loss of data
RAPIDJSON_DIAG_OFF(4702)  // unreachable code
#elif defined(__GNUC__)
RAPIDJSON_DIAG_PUSH
RAPIDJSON_DIAG_OFF(effc++)
#endif

namespace rapidjson {

///////////////////////////////////////////////////////////////////////////////
// Encoding

/*! \class rapidjson::Encoding
    \brief Concept for encoding of Unicode characters.

\code
concept Encoding {
    typename Ch;    //! Type of character. A "character" is actually a code unit in unicode's definition.

    enum { supportUnicode = 1 }; // or 0 if not supporting unicode

    //! \brief Encode a Unicode codepoint to an output stream.
    //! \param os Output stream.
    //! \param codepoint An unicode codepoint, ranging from 0x0 to 0x10FFFF inclusively.
    template<typename OutputStream>
    static void Encode(OutputStream& os, unsigned codepoint);

    //! \brief Decode a Unicode codepoint from an input stream.
    //! \param is Input stream.
    //! \param codepoint Output of the unicode codepoint.
    //! \return true if a valid codepoint can be decoded from the stream.
    template <typename InputStream>
    static bool Decode(InputStream& is, unsigned* codepoint);

    //! \brief Validate one Unicode codepoint from an encoded stream.
    //! \param is Input stream to obtain codepoint.
    //! \param os Output for copying one codepoint.
    //! \return true if it is valid.
    //! \note This function just validating and copying the codepoint without actually decode it.
    template <typename InputStream, typename OutputStream>
    static bool Validate(InputStream& is, OutputStream& os);

    // The following functions are deal with byte streams.

    //! Take a character from input byte stream, skip BOM if exist.
    template <typename InputByteStream>
    static CharType TakeBOM(InputByteStream& is);

    //! Take a character from input byte stream.
    template <typename InputByteStream>
    static Ch Take(InputByteStream& is);

    //! Put BOM to output byte stream.
    template <typename OutputByteStream>
    static void PutBOM(OutputByteStream& os);

    //! Put a character to output byte stream.
    template <typename OutputByteStream>
    static void Put(OutputByteStream& os, Ch c);
};
\endcode
*/

///////////////////////////////////////////////////////////////////////////////
// UTF8

//! UTF-8 encoding.
/*! http://en.wikipedia.org/wiki/UTF-8
    http://tools.ietf.org/html/rfc3629
    \tparam CharType Code unit for storing 8-bit UTF-8 data. Default is char.
    \note implements Encoding concept
*/
template<typename CharType = char>
struct UTF8 {
    typedef CharType Ch;

    enum { supportUnicode = 1 };

    template<typename OutputStream>
    static void Encode(OutputStream& os, unsigned codepoint) {
        if (codepoint <= 0x7F) 
            os.Put(static_cast<Ch>(codepoint & 0xFF));
        else if (codepoint <= 0x7FF) {
            os.Put(static_cast<Ch>(0xC0 | ((codepoint >> 6) & 0xFF)));
            os.Put(static_cast<Ch>(0x80 | ((codepoint & 0x3F))));
        }
        else if (codepoint <= 0xFFFF) {
            os.Put(static_cast<Ch>(0xE0 | ((codepoint >> 12) & 0xFF)));
            os.Put(static_cast<Ch>(0x80 | ((codepoint >> 6) & 0x3F)));
            os.Put(static_cast<Ch>(0x80 | (codepoint & 0x3F)));
        }
        else {
            RAPIDJSON_ASSERT(codepoint <= 0x10FFFF);
            os.Put(static_cast<Ch>(0xF0 | ((codepoint >> 18) & 0xFF)));
            os.Put(static_cast<Ch>(0x80 | ((codepoint >> 12) & 0x3F)));
            os.Put(static_cast<Ch>(0x80 | ((codepoint >> 6) & 0x3F)));
            os.Put(static_cast<Ch>(0x80 | (codepoint & 0x3F)));
        }
    }

    template <typename InputStream>
    static bool Decode(InputStream& is, unsigned* codepoint) {
#define COPY() c = is.Take(); *codepoint = (*codepoint << 6) | ((unsigned char)c & 0x3Fu)
#define TRANS(mask) result &= ((GetRange((unsigned char)c) & mask) != 0)
#define TAIL() COPY(); TRANS(0x70)
        Ch c = is.Take();
        if (!(c & 0x80)) {
            *codepoint = (unsigned char)c;
            return true;
        }

        unsigned char type = GetRange((unsigned char)c);
        *codepoint = (0xFF >> type) & (unsigned char)c;
        bool result = true;
        switch (type) {
        case 2: TAIL(); return result;
        case 3: TAIL(); TAIL(); return result;
        case 4: COPY(); TRANS(0x50); TAIL(); return result;
        case 5: COPY(); TRANS(0x10); TAIL(); TAIL(); return result;
        case 6: TAIL(); TAIL(); TAIL(); return result;
        case 10: COPY(); TRANS(0x20); TAIL(); return result;
        case 11: COPY(); TRANS(0x60); TAIL(); TAIL(); return result;
        default: return false;
        }
#undef COPY
#undef TRANS
#undef TAIL
    }

    template <typename InputStream, typename OutputStream>
    static bool Validate(InputStream& is, OutputStream& os) {
#define COPY() os.Put(c = is.Take())
#define TRANS(mask) result &= ((GetRange((unsigned char)c) & mask) != 0)
#define TAIL() COPY(); TRANS(0x70)
        Ch c;
        COPY();
        if (!(c & 0x80))
            return true;

        bool result = true;
        switch (GetRange((unsigned char)c)) {
        case 2: TAIL(); return result;
        case 3: TAIL(); TAIL(); return result;
        case 4: COPY(); TRANS(0x50); TAIL(); return result;
        case 5: COPY(); TRANS(0x10); TAIL(); TAIL(); return result;
        case 6: TAIL(); TAIL(); TAIL(); return result;
        case 10: COPY(); TRANS(0x20); TAIL(); return result;
        case 11: COPY(); TRANS(0x60); TAIL(); TAIL(); return result;
        default: return false;
        }
#undef COPY
#undef TRANS
#undef TAIL
    }

    static unsigned char GetRange(unsigned char c) {
        // Referring to DFA of http://bjoern.hoehrmann.de/utf-8/decoder/dfa/
        // With new mapping 1 -> 0x10, 7 -> 0x20, 9 -> 0x40, such that AND operation can test multiple types.
        static const unsigned char type[] = {
            0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
            0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,
            0x40,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0x40,
            0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
            0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,
            8,8,2,2,2,2,2,2,2,2,2,2,2,2,2,2,  2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
            10,3,3,3,3,3,3,3,3,3,3,3,3,4,3,3, 11,6,6,6,5,8,8,8,8,8,8,8,8,8,8,8,
        };
        return type[c];
    }

    template <typename InputByteStream>
    static CharType TakeBOM(InputByteStream& is) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename InputByteStream::Ch) == 1);
        Ch c = Take(is);
        if ((unsigned char)c != 0xEFu) return c;
        c = is.Take();
        if ((unsigned char)c != 0xBBu) return c;
        c = is.Take();
        if ((unsigned char)c != 0xBFu) return c;
        c = is.Take();
        return c;
    }

    template <typename InputByteStream>
    static Ch Take(InputByteStream& is) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename InputByteStream::Ch) == 1);
        return is.Take();
    }

    template <typename OutputByteStream>
    static void PutBOM(OutputByteStream& os) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename OutputByteStream::Ch) == 1);
        os.Put(0xEFu); os.Put(0xBBu); os.Put(0xBFu);
    }

    template <typename OutputByteStream>
    static void Put(OutputByteStream& os, Ch c) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename OutputByteStream::Ch) == 1);
        os.Put(static_cast<typename OutputByteStream::Ch>(c));
    }
};

///////////////////////////////////////////////////////////////////////////////
// UTF16

//! UTF-16 encoding.
/*! http://en.wikipedia.org/wiki/UTF-16
    http://tools.ietf.org/html/rfc2781
    \tparam CharType Type for storing 16-bit UTF-16 data. Default is wchar_t. C++11 may use char16_t instead.
    \note implements Encoding concept

    \note For in-memory access, no need to concern endianness. The code units and code points are represented by CPU's endianness.
    For streaming, use UTF16LE and UTF16BE, which handle endianness.
*/
template<typename CharType = wchar_t>
struct UTF16 {
    typedef CharType Ch;
    RAPIDJSON_STATIC_ASSERT(sizeof(Ch) >= 2);

    enum { supportUnicode = 1 };

    template<typename OutputStream>
    static void Encode(OutputStream& os, unsigned codepoint) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename OutputStream::Ch) >= 2);
        if (codepoint <= 0xFFFF) {
            RAPIDJSON_ASSERT(codepoint < 0xD800 || codepoint > 0xDFFF); // Code point itself cannot be surrogate pair 
            os.Put(static_cast<typename OutputStream::Ch>(codepoint));
        }
        else {
            RAPIDJSON_ASSERT(codepoint <= 0x10FFFF);
            unsigned v = codepoint - 0x10000;
            os.Put(static_cast<typename OutputStream::Ch>((v >> 10) | 0xD800));
            os.Put((v & 0x3FF) | 0xDC00);
        }
    }

    template <typename InputStream>
    static bool Decode(InputStream& is, unsigned* codepoint) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename InputStream::Ch) >= 2);
        Ch c = is.Take();
        if (c < 0xD800 || c > 0xDFFF) {
            *codepoint = c;
            return true;
        }
        else if (c <= 0xDBFF) {
            *codepoint = (c & 0x3FF) << 10;
            c = is.Take();
            *codepoint |= (c & 0x3FF);
            *codepoint += 0x10000;
            return c >= 0xDC00 && c <= 0xDFFF;
        }
        return false;
    }

    template <typename InputStream, typename OutputStream>
    static bool Validate(InputStream& is, OutputStream& os) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename InputStream::Ch) >= 2);
        RAPIDJSON_STATIC_ASSERT(sizeof(typename OutputStream::Ch) >= 2);
        Ch c;
        os.Put(c = is.Take());
        if (c < 0xD800 || c > 0xDFFF)
            return true;
        else if (c <= 0xDBFF) {
            os.Put(c = is.Take());
            return c >= 0xDC00 && c <= 0xDFFF;
        }
        return false;
    }
};

//! UTF-16 little endian encoding.
template<typename CharType = wchar_t>
struct UTF16LE : UTF16<CharType> {
    template <typename InputByteStream>
    static CharType TakeBOM(InputByteStream& is) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename InputByteStream::Ch) == 1);
        CharType c = Take(is);
        return (unsigned short)c == 0xFEFFu ? Take(is) : c;
    }

    template <typename InputByteStream>
    static CharType Take(InputByteStream& is) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename InputByteStream::Ch) == 1);
        CharType c = (unsigned char)is.Take();
        c |= (unsigned char)is.Take() << 8;
        return c;
    }

    template <typename OutputByteStream>
    static void PutBOM(OutputByteStream& os) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename OutputByteStream::Ch) == 1);
        os.Put(0xFFu); os.Put(0xFEu);
    }

    template <typename OutputByteStream>
    static void Put(OutputByteStream& os, CharType c) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename OutputByteStream::Ch) == 1);
        os.Put(c & 0xFFu);
        os.Put((c >> 8) & 0xFFu);
    }
};

//! UTF-16 big endian encoding.
template<typename CharType = wchar_t>
struct UTF16BE : UTF16<CharType> {
    template <typename InputByteStream>
    static CharType TakeBOM(InputByteStream& is) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename InputByteStream::Ch) == 1);
        CharType c = Take(is);
        return (unsigned short)c == 0xFEFFu ? Take(is) : c;
    }

    template <typename InputByteStream>
    static CharType Take(InputByteStream& is) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename InputByteStream::Ch) == 1);
        CharType c = (unsigned char)is.Take() << 8;
        c |= (unsigned char)is.Take();
        return c;
    }

    template <typename OutputByteStream>
    static void PutBOM(OutputByteStream& os) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename OutputByteStream::Ch) == 1);
        os.Put(0xFEu); os.Put(0xFFu);
    }

    template <typename OutputByteStream>
    static void Put(OutputByteStream& os, CharType c) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename OutputByteStream::Ch) == 1);
        os.Put((c >> 8) & 0xFFu);
        os.Put(c & 0xFFu);
    }
};

///////////////////////////////////////////////////////////////////////////////
// UTF32

//! UTF-32 encoding. 
/*! http://en.wikipedia.org/wiki/UTF-32
    \tparam CharType Type for storing 32-bit UTF-32 data. Default is unsigned. C++11 may use char32_t instead.
    \note implements Encoding concept

    \note For in-memory access, no need to concern endianness. The code units and code points are represented by CPU's endianness.
    For streaming, use UTF32LE and UTF32BE, which handle endianness.
*/
template<typename CharType = unsigned>
struct UTF32 {
    typedef CharType Ch;
    RAPIDJSON_STATIC_ASSERT(sizeof(Ch) >= 4);

    enum { supportUnicode = 1 };

    template<typename OutputStream>
    static void Encode(OutputStream& os, unsigned codepoint) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename OutputStream::Ch) >= 4);
        RAPIDJSON_ASSERT(codepoint <= 0x10FFFF);
        os.Put(codepoint);
    }

    template <typename InputStream>
    static bool Decode(InputStream& is, unsigned* codepoint) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename InputStream::Ch) >= 4);
        Ch c = is.Take();
        *codepoint = c;
        return c <= 0x10FFFF;
    }

    template <typename InputStream, typename OutputStream>
    static bool Validate(InputStream& is, OutputStream& os) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename InputStream::Ch) >= 4);
        Ch c;
        os.Put(c = is.Take());
        return c <= 0x10FFFF;
    }
};

//! UTF-32 little endian enocoding.
template<typename CharType = unsigned>
struct UTF32LE : UTF32<CharType> {
    template <typename InputByteStream>
    static CharType TakeBOM(InputByteStream& is) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename InputByteStream::Ch) == 1);
        CharType c = Take(is);
        return (unsigned)c == 0x0000FEFFu ? Take(is) : c;
    }

    template <typename InputByteStream>
    static CharType Take(InputByteStream& is) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename InputByteStream::Ch) == 1);
        CharType c = (unsigned char)is.Take();
        c |= (unsigned char)is.Take() << 8;
        c |= (unsigned char)is.Take() << 16;
        c |= (unsigned char)is.Take() << 24;
        return c;
    }

    template <typename OutputByteStream>
    static void PutBOM(OutputByteStream& os) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename OutputByteStream::Ch) == 1);
        os.Put(0xFFu); os.Put(0xFEu); os.Put(0x00u); os.Put(0x00u);
    }

    template <typename OutputByteStream>
    static void Put(OutputByteStream& os, CharType c) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename OutputByteStream::Ch) == 1);
        os.Put(c & 0xFFu);
        os.Put((c >> 8) & 0xFFu);
        os.Put((c >> 16) & 0xFFu);
        os.Put((c >> 24) & 0xFFu);
    }
};

//! UTF-32 big endian encoding.
template<typename CharType = unsigned>
struct UTF32BE : UTF32<CharType> {
    template <typename InputByteStream>
    static CharType TakeBOM(InputByteStream& is) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename InputByteStream::Ch) == 1);
        CharType c = Take(is);
        return (unsigned)c == 0x0000FEFFu ? Take(is) : c; 
    }

    template <typename InputByteStream>
    static CharType Take(InputByteStream& is) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename InputByteStream::Ch) == 1);
        CharType c = (unsigned char)is.Take() << 24;
        c |= (unsigned char)is.Take() << 16;
        c |= (unsigned char)is.Take() << 8;
        c |= (unsigned char)is.Take();
        return c;
    }

    template <typename OutputByteStream>
    static void PutBOM(OutputByteStream& os) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename OutputByteStream::Ch) == 1);
        os.Put(0x00u); os.Put(0x00u); os.Put(0xFEu); os.Put(0xFFu);
    }

    template <typename OutputByteStream>
    static void Put(OutputByteStream& os, CharType c) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename OutputByteStream::Ch) == 1);
        os.Put((c >> 24) & 0xFFu);
        os.Put((c >> 16) & 0xFFu);
        os.Put((c >> 8) & 0xFFu);
        os.Put(c & 0xFFu);
    }
};

///////////////////////////////////////////////////////////////////////////////
// ASCII

//! ASCII encoding.
/*! http://en.wikipedia.org/wiki/ASCII
    \tparam CharType Code unit for storing 7-bit ASCII data. Default is char.
    \note implements Encoding concept
*/
template<typename CharType = char>
struct ASCII {
    typedef CharType Ch;

    enum { supportUnicode = 0 };

    template<typename OutputStream>
    static void Encode(OutputStream& os, unsigned codepoint) {
        RAPIDJSON_ASSERT(codepoint <= 0x7F);
        os.Put(static_cast<Ch>(codepoint & 0xFF));
    }

    template <typename InputStream>
    static bool Decode(InputStream& is, unsigned* codepoint) {
        unsigned char c = static_cast<unsigned char>(is.Take());
        *codepoint = c;
        return c <= 0X7F;
    }

    template <typename InputStream, typename OutputStream>
    static bool Validate(InputStream& is, OutputStream& os) {
        unsigned char c = is.Take();
        os.Put(c);
        return c <= 0x7F;
    }

    template <typename InputByteStream>
    static CharType TakeBOM(InputByteStream& is) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename InputByteStream::Ch) == 1);
        Ch c = Take(is);
        return c;
    }

    template <typename InputByteStream>
    static Ch Take(InputByteStream& is) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename InputByteStream::Ch) == 1);
        return is.Take();
    }

    template <typename OutputByteStream>
    static void PutBOM(OutputByteStream& os) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename OutputByteStream::Ch) == 1);
        (void)os;
    }

    template <typename OutputByteStream>
    static void Put(OutputByteStream& os, Ch c) {
        RAPIDJSON_STATIC_ASSERT(sizeof(typename OutputByteStream::Ch) == 1);
        os.Put(static_cast<typename OutputByteStream::Ch>(c));
    }
};

///////////////////////////////////////////////////////////////////////////////
// AutoUTF

//! Runtime-specified UTF encoding type of a stream.
enum UTFType {
    kUTF8 = 0,      //!< UTF-8.
    kUTF16LE = 1,   //!< UTF-16 little endian.
    kUTF16BE = 2,   //!< UTF-16 big endian.
    kUTF32LE = 3,   //!< UTF-32 little endian.
    kUTF32BE = 4    //!< UTF-32 big endian.
};

//! Dynamically select encoding according to stream's runtime-specified UTF encoding type.
/*! \note This class can be used with AutoUTFInputtStream and AutoUTFOutputStream, which provides GetType().
*/
template<typename CharType>
struct AutoUTF {
    typedef CharType Ch;

    enum { supportUnicode = 1 };

#define RAPIDJSON_ENCODINGS_FUNC(x) UTF8<Ch>::x, UTF16LE<Ch>::x, UTF16BE<Ch>::x, UTF32LE<Ch>::x, UTF32BE<Ch>::x

    template<typename OutputStream>
    RAPIDJSON_FORCEINLINE static void Encode(OutputStream& os, unsigned codepoint) {
        typedef void (*EncodeFunc)(OutputStream&, unsigned);
        static const EncodeFunc f[] = { RAPIDJSON_ENCODINGS_FUNC(Encode) };
        (*f[os.GetType()])(os, codepoint);
    }

    template <typename InputStream>
    RAPIDJSON_FORCEINLINE static bool Decode(InputStream& is, unsigned* codepoint) {
        typedef bool (*DecodeFunc)(InputStream&, unsigned*);
        static const DecodeFunc f[] = { RAPIDJSON_ENCODINGS_FUNC(Decode) };
        return (*f[is.GetType()])(is, codepoint);
    }

    template <typename InputStream, typename OutputStream>
    RAPIDJSON_FORCEINLINE static bool Validate(InputStream& is, OutputStream& os) {
        typedef bool (*ValidateFunc)(InputStream&, OutputStream&);
        static const ValidateFunc f[] = { RAPIDJSON_ENCODINGS_FUNC(Validate) };
        return (*f[is.GetType()])(is, os);
    }

#undef RAPIDJSON_ENCODINGS_FUNC
};

///////////////////////////////////////////////////////////////////////////////
// Transcoder

//! Encoding conversion.
template<typename SourceEncoding, typename TargetEncoding>
struct Transcoder {
    //! Take one Unicode codepoint from source encoding, convert it to target encoding and put it to the output stream.
    template<typename InputStream, typename OutputStream>
    RAPIDJSON_FORCEINLINE static bool Transcode(InputStream& is, OutputStream& os) {
        unsigned codepoint;
        if (!SourceEncoding::Decode(is, &codepoint))
            return false;
        TargetEncoding::Encode(os, codepoint);
        return true;
    }

    //! Validate one Unicode codepoint from an encoded stream.
    template<typename InputStream, typename OutputStream>
    RAPIDJSON_FORCEINLINE static bool Validate(InputStream& is, OutputStream& os) {
        return Transcode(is, os);   // Since source/target encoding is different, must transcode.
    }
};

//! Specialization of Transcoder with same source and target encoding.
template<typename Encoding>
struct Transcoder<Encoding, Encoding> {
    template<typename InputStream, typename OutputStream>
    RAPIDJSON_FORCEINLINE static bool Transcode(InputStream& is, OutputStream& os) {
        os.Put(is.Take());  // Just copy one code unit. This semantic is different from primary template class.
        return true;
    }
    
    template<typename InputStream, typename OutputStream>
    RAPIDJSON_FORCEINLINE static bool Validate(InputStream& is, OutputStream& os) {
        return Encoding::Validate(is, os);  // source/target encoding are the same
    }
};

} // namespace rapidjson

#if defined(__GNUC__) || defined(_MSV_VER)
RAPIDJSON_DIAG_POP
#endif

#endif // RAPIDJSON_ENCODINGS_H_

//! main RapidJSON namespace
namespace rapidjson {

///////////////////////////////////////////////////////////////////////////////
//  Stream

/*! \class rapidjson::Stream
    \brief Concept for reading and writing characters.

    For read-only stream, no need to implement PutBegin(), Put(), Flush() and PutEnd().

    For write-only stream, only need to implement Put() and Flush().

\code
concept Stream {
    typename Ch;    //!< Character type of the stream.

    //! Read the current character from stream without moving the read cursor.
    Ch Peek() const;

    //! Read the current character from stream and moving the read cursor to next character.
    Ch Take();

    //! Get the current read cursor.
    //! \return Number of characters read from start.
    size_t Tell();

    //! Begin writing operation at the current read pointer.
    //! \return The begin writer pointer.
    Ch* PutBegin();

    //! Write a character.
    void Put(Ch c);

    //! Flush the buffer.
    void Flush();

    //! End the writing operation.
    //! \param begin The begin write pointer returned by PutBegin().
    //! \return Number of characters written.
    size_t PutEnd(Ch* begin);
}
\endcode
*/

//! Provides additional information for stream.
/*!
    By using traits pattern, this type provides a default configuration for stream.
    For custom stream, this type can be specialized for other configuration.
    See TEST(Reader, CustomStringStream) in readertest.cpp for example.
*/
template<typename Stream>
struct StreamTraits {
    //! Whether to make local copy of stream for optimization during parsing.
    /*!
        By default, for safety, streams do not use local copy optimization.
        Stream that can be copied fast should specialize this, like StreamTraits<StringStream>.
    */
    enum { copyOptimization = 0 };
};

//! Put N copies of a character to a stream.
template<typename Stream, typename Ch>
inline void PutN(Stream& stream, Ch c, size_t n) {
    for (size_t i = 0; i < n; i++)
        stream.Put(c);
}

///////////////////////////////////////////////////////////////////////////////
// StringStream

//! Read-only string stream.
/*! \note implements Stream concept
*/
template <typename Encoding>
struct GenericStringStream {
    typedef typename Encoding::Ch Ch;

    GenericStringStream(const Ch *src) : src_(src), head_(src) {}

    Ch Peek() const { return *src_; }
    Ch Take() { return *src_++; }
    size_t Tell() const { return static_cast<size_t>(src_ - head_); }

    Ch* PutBegin() { RAPIDJSON_ASSERT(false); return 0; }
    void Put(Ch) { RAPIDJSON_ASSERT(false); }
    void Flush() { RAPIDJSON_ASSERT(false); }
    size_t PutEnd(Ch*) { RAPIDJSON_ASSERT(false); return 0; }

    const Ch* src_;     //!< Current read position.
    const Ch* head_;    //!< Original head of the string.
};

template <typename Encoding>
struct StreamTraits<GenericStringStream<Encoding> > {
    enum { copyOptimization = 1 };
};

//! String stream with UTF8 encoding.
typedef GenericStringStream<UTF8<> > StringStream;

///////////////////////////////////////////////////////////////////////////////
// InsituStringStream

//! A read-write string stream.
/*! This string stream is particularly designed for in-situ parsing.
    \note implements Stream concept
*/
template <typename Encoding>
struct GenericInsituStringStream {
    typedef typename Encoding::Ch Ch;

    GenericInsituStringStream(Ch *src) : src_(src), dst_(0), head_(src) {}

    // Read
    Ch Peek() { return *src_; }
    Ch Take() { return *src_++; }
    size_t Tell() { return static_cast<size_t>(src_ - head_); }

    // Write
    void Put(Ch c) { RAPIDJSON_ASSERT(dst_ != 0); *dst_++ = c; }

    Ch* PutBegin() { return dst_ = src_; }
    size_t PutEnd(Ch* begin) { return static_cast<size_t>(dst_ - begin); }
    void Flush() {}

    Ch* Push(size_t count) { Ch* begin = dst_; dst_ += count; return begin; }
    void Pop(size_t count) { dst_ -= count; }

    Ch* src_;
    Ch* dst_;
    Ch* head_;
};

template <typename Encoding>
struct StreamTraits<GenericInsituStringStream<Encoding> > {
    enum { copyOptimization = 1 };
};

//! Insitu string stream with UTF8 encoding.
typedef GenericInsituStringStream<UTF8<> > InsituStringStream;

///////////////////////////////////////////////////////////////////////////////
// Type

//! Type of JSON value
enum Type {
    kNullType = 0,      //!< null
    kFalseType = 1,     //!< false
    kTrueType = 2,      //!< true
    kObjectType = 3,    //!< object
    kArrayType = 4,     //!< array 
    kStringType = 5,    //!< string
    kNumberType = 6     //!< number
};

} // namespace rapidjson

#endif // RAPIDJSON_RAPIDJSON_H_

//==============================================================================
// stringbuffer.h
//==============================================================================

// Copyright (C) 2011 Milo Yip
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#ifndef RAPIDJSON_STRINGBUFFER_H_
#define RAPIDJSON_STRINGBUFFER_H_

namespace rapidjson {

//! Represents an in-memory output stream.
/*!
    \tparam Encoding Encoding of the stream.
    \tparam Allocator type for allocating memory buffer.
    \note implements Stream concept
*/
template <typename Encoding, typename Allocator = CrtAllocator>
struct GenericStringBuffer {
    typedef typename Encoding::Ch Ch;

    GenericStringBuffer(Allocator* allocator = 0, size_t capacity = kDefaultCapacity) : stack_(allocator, capacity) {}

    void Put(Ch c) { *stack_.template Push<Ch>() = c; }
    void Flush() {}

    void Clear() { stack_.Clear(); }
    void ShrinkToFit() {
        // Push and pop a null terminator. This is safe.
        *stack_.template Push<Ch>() = '\0';
        stack_.ShrinkToFit();
        stack_.template Pop<Ch>(1);
    }
    Ch* Push(size_t count) { return stack_.template Push<Ch>(count); }
    void Pop(size_t count) { stack_.template Pop<Ch>(count); }

    const Ch* GetString() const {
        // Push and pop a null terminator. This is safe.
        *stack_.template Push<Ch>() = '\0';
        stack_.template Pop<Ch>(1);

        return stack_.template Bottom<Ch>();
    }

    size_t GetSize() const { return stack_.GetSize(); }

    static const size_t kDefaultCapacity = 256;
    mutable internal::Stack<Allocator> stack_;
};

//! String buffer with UTF8 encoding
typedef GenericStringBuffer<UTF8<> > StringBuffer;

//! Implement specialized version of PutN() with memset() for better performance.
template<>
inline void PutN(GenericStringBuffer<UTF8<> >& stream, char c, size_t n) {
    memset(stream.stack_.Push<char>(n), c, n * sizeof(c));
}

} // namespace rapidjson

#endif // RAPIDJSON_STRINGBUFFER_H_

//==============================================================================
// writer.h
//==============================================================================

// Copyright (C) 2011 Milo Yip
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#ifndef RAPIDJSON_WRITER_H_
#define RAPIDJSON_WRITER_H_

#include <new>      // placement new

#ifdef _MSC_VER
RAPIDJSON_DIAG_PUSH
RAPIDJSON_DIAG_OFF(4127) // conditional expression is constant
#endif

namespace rapidjson {

//! JSON writer
/*! Writer implements the concept Handler.
    It generates JSON text by events to an output os.

    User may programmatically calls the functions of a writer to generate JSON text.

    On the other side, a writer can also be passed to objects that generates events, 

    for example Reader::Parse() and Document::Accept().

    \tparam OutputStream Type of output stream.
    \tparam SourceEncoding Encoding of source string.
    \tparam TargetEncoding Encoding of output stream.
    \tparam StackAllocator Type of allocator for allocating memory of stack.
    \note implements Handler concept
*/
template<typename OutputStream, typename SourceEncoding = UTF8<>, typename TargetEncoding = UTF8<>, typename StackAllocator = CrtAllocator>
class Writer {
public:
    typedef typename SourceEncoding::Ch Ch;

    //! Constructor
    /*! \param os Output stream.
        \param allocator User supplied allocator. If it is null, it will create a private one.
        \param levelDepth Initial capacity of stack.
    */
    Writer(OutputStream& os, StackAllocator* stackAllocator = 0, size_t levelDepth = kDefaultLevelDepth) : 
        os_(&os), level_stack_(stackAllocator, levelDepth * sizeof(Level)), hasRoot_(false) {}

    Writer(StackAllocator* allocator = 0, size_t levelDepth = kDefaultLevelDepth) :
        os_(0), level_stack_(allocator, levelDepth * sizeof(Level)), hasRoot_(false) {}

    //! Reset the writer with a new stream.
    /*!
        This function reset the writer with a new stream and default settings,
        in order to make a Writer object reusable for output multiple JSONs.

        \param os New output stream.
        \code
        Writer<OutputStream> writer(os1);
        writer.StartObject();
        // ...
        writer.EndObject();

        writer.Reset(os2);
        writer.StartObject();
        // ...
        writer.EndObject();
        \endcode
    */
    void Reset(OutputStream& os) {
        os_ = &os;
        hasRoot_ = false;
        level_stack_.Clear();
    }

    //! Checks whether the output is a complete JSON.
    /*!
        A complete JSON has a complete root object or array.
    */
    bool IsComplete() const {
        return hasRoot_ && level_stack_.Empty();
    }

    /*!@name Implementation of Handler
        \see Handler
    */
    //@{

    bool Null()                 { Prefix(kNullType);   return WriteNull(); }
    bool Bool(bool b)           { Prefix(b ? kTrueType : kFalseType); return WriteBool(b); }
    bool Int(int i)             { Prefix(kNumberType); return WriteInt(i); }
    bool Uint(unsigned u)       { Prefix(kNumberType); return WriteUint(u); }
    bool Int64(int64_t i64)     { Prefix(kNumberType); return WriteInt64(i64); }
    bool Uint64(uint64_t u64)   { Prefix(kNumberType); return WriteUint64(u64); }

    //! Writes the given \c double value to the stream
    /*!
        \param d The value to be written.
        \return Whether it is succeed.
    */
    bool Double(double d)       { Prefix(kNumberType); return WriteDouble(d); }

    bool String(const Ch* str, SizeType length, bool copy = false) {
        (void)copy;
        Prefix(kStringType);
        return WriteString(str, length);
    }

    bool StartObject() {
        Prefix(kObjectType);
        new (level_stack_.template Push<Level>()) Level(false);
        return WriteStartObject();
    }

    bool EndObject(SizeType memberCount = 0) {
        (void)memberCount;
        RAPIDJSON_ASSERT(level_stack_.GetSize() >= sizeof(Level));
        RAPIDJSON_ASSERT(!level_stack_.template Top<Level>()->inArray);
        level_stack_.template Pop<Level>(1);
        bool ret = WriteEndObject();
        if (level_stack_.Empty())   // end of json text
            os_->Flush();
        return ret;
    }

    bool StartArray() {
        Prefix(kArrayType);
        new (level_stack_.template Push<Level>()) Level(true);
        return WriteStartArray();
    }

    bool EndArray(SizeType elementCount = 0) {
        (void)elementCount;
        RAPIDJSON_ASSERT(level_stack_.GetSize() >= sizeof(Level));
        RAPIDJSON_ASSERT(level_stack_.template Top<Level>()->inArray);
        level_stack_.template Pop<Level>(1);
        bool ret = WriteEndArray();
        if (level_stack_.Empty())   // end of json text
            os_->Flush();
        return ret;
    }
    //@}

    /*! @name Convenience extensions */
    //@{

    //! Simpler but slower overload.
    bool String(const Ch* str) { return String(str, internal::StrLen(str)); }

    //@}

protected:
    //! Information for each nested level
    struct Level {
        Level(bool inArray_) : valueCount(0), inArray(inArray_) {}
        size_t valueCount;  //!< number of values in this level
        bool inArray;       //!< true if in array, otherwise in object
    };

    static const size_t kDefaultLevelDepth = 32;

    bool WriteNull()  {
        os_->Put('n'); os_->Put('u'); os_->Put('l'); os_->Put('l'); return true;
    }

    bool WriteBool(bool b)  {
        if (b) {
            os_->Put('t'); os_->Put('r'); os_->Put('u'); os_->Put('e');
        }
        else {
            os_->Put('f'); os_->Put('a'); os_->Put('l'); os_->Put('s'); os_->Put('e');
        }
        return true;
    }

    bool WriteInt(int i) {
        char buffer[11];
        const char* end = internal::i32toa(i, buffer);
        for (const char* p = buffer; p != end; ++p)
            os_->Put(*p);
        return true;
    }

    bool WriteUint(unsigned u) {
        char buffer[10];
        const char* end = internal::u32toa(u, buffer);
        for (const char* p = buffer; p != end; ++p)
            os_->Put(*p);
        return true;
    }

    bool WriteInt64(int64_t i64) {
        char buffer[21];
        const char* end = internal::i64toa(i64, buffer);
        for (const char* p = buffer; p != end; ++p)
            os_->Put(*p);
        return true;
    }

    bool WriteUint64(uint64_t u64) {
        char buffer[20];
        char* end = internal::u64toa(u64, buffer);
        for (char* p = buffer; p != end; ++p)
            os_->Put(*p);
        return true;
    }

    bool WriteDouble(double d) {
        char buffer[25];
        char* end = internal::dtoa(d, buffer);
        for (char* p = buffer; p != end; ++p)
            os_->Put(*p);
        return true;
    }

    bool WriteString(const Ch* str, SizeType length)  {
        static const char hexDigits[16] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
        static const char escape[256] = {
#define Z16 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            //0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F
            'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'b', 't', 'n', 'u', 'f', 'r', 'u', 'u', // 00
            'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', // 10
              0,   0, '"',   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, // 20
            Z16, Z16,                                                                       // 30~4F
              0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,'\\',   0,   0,   0, // 50
            Z16, Z16, Z16, Z16, Z16, Z16, Z16, Z16, Z16, Z16                                // 60~FF
#undef Z16
        };

        os_->Put('\"');
        GenericStringStream<SourceEncoding> is(str);
        while (is.Tell() < length) {
            const Ch c = is.Peek();
            if (!TargetEncoding::supportUnicode && (unsigned)c >= 0x80) {
                // Unicode escaping
                unsigned codepoint;
                if (!SourceEncoding::Decode(is, &codepoint))
                    return false;
                os_->Put('\\');
                os_->Put('u');
                if (codepoint <= 0xD7FF || (codepoint >= 0xE000 && codepoint <= 0xFFFF)) {
                    os_->Put(hexDigits[(codepoint >> 12) & 15]);
                    os_->Put(hexDigits[(codepoint >>  8) & 15]);
                    os_->Put(hexDigits[(codepoint >>  4) & 15]);
                    os_->Put(hexDigits[(codepoint      ) & 15]);
                }
                else if (codepoint >= 0x010000 && codepoint <= 0x10FFFF)    {
                    // Surrogate pair
                    unsigned s = codepoint - 0x010000;
                    unsigned lead = (s >> 10) + 0xD800;
                    unsigned trail = (s & 0x3FF) + 0xDC00;
                    os_->Put(hexDigits[(lead >> 12) & 15]);
                    os_->Put(hexDigits[(lead >>  8) & 15]);
                    os_->Put(hexDigits[(lead >>  4) & 15]);
                    os_->Put(hexDigits[(lead      ) & 15]);
                    os_->Put('\\');
                    os_->Put('u');
                    os_->Put(hexDigits[(trail >> 12) & 15]);
                    os_->Put(hexDigits[(trail >>  8) & 15]);
                    os_->Put(hexDigits[(trail >>  4) & 15]);
                    os_->Put(hexDigits[(trail      ) & 15]);                    
                }
                else
                    return false;   // invalid code point
            }
            else if ((sizeof(Ch) == 1 || (unsigned)c < 256) && escape[(unsigned char)c])  {
                is.Take();
                os_->Put('\\');
                os_->Put(escape[(unsigned char)c]);
                if (escape[(unsigned char)c] == 'u') {
                    os_->Put('0');
                    os_->Put('0');
                    os_->Put(hexDigits[(unsigned char)c >> 4]);
                    os_->Put(hexDigits[(unsigned char)c & 0xF]);
                }
            }
            else
                Transcoder<SourceEncoding, TargetEncoding>::Transcode(is, *os_);
        }
        os_->Put('\"');
        return true;
    }

    bool WriteStartObject() { os_->Put('{'); return true; }
    bool WriteEndObject()   { os_->Put('}'); return true; }
    bool WriteStartArray()  { os_->Put('['); return true; }
    bool WriteEndArray()    { os_->Put(']'); return true; }

    void Prefix(Type type) {
        (void)type;
        if (level_stack_.GetSize() != 0) { // this value is not at root
            Level* level = level_stack_.template Top<Level>();
            if (level->valueCount > 0) {
                if (level->inArray) 
                    os_->Put(','); // add comma if it is not the first element in array
                else  // in object
                    os_->Put((level->valueCount % 2 == 0) ? ',' : ':');
            }
            if (!level->inArray && level->valueCount % 2 == 0)
                RAPIDJSON_ASSERT(type == kStringType);  // if it's in object, then even number should be a name
            level->valueCount++;
        }
        else {
            RAPIDJSON_ASSERT(!hasRoot_);    // Should only has one and only one root.
            hasRoot_ = true;
        }
    }

    OutputStream* os_;
    internal::Stack<StackAllocator> level_stack_;
    bool hasRoot_;

private:
    // Prohibit copy constructor & assignment operator.
    Writer(const Writer&);
    Writer& operator=(const Writer&);
};

// Full specialization for StringStream to prevent memory copying

template<>
inline bool Writer<StringBuffer>::WriteInt(int i) {
    char *buffer = os_->Push(11);
    const char* end = internal::i32toa(i, buffer);
    os_->Pop(11 - (end - buffer));
    return true;
}

template<>
inline bool Writer<StringBuffer>::WriteUint(unsigned u) {
    char *buffer = os_->Push(10);
    const char* end = internal::u32toa(u, buffer);
    os_->Pop(10 - (end - buffer));
    return true;
}

template<>
inline bool Writer<StringBuffer>::WriteInt64(int64_t i64) {
    char *buffer = os_->Push(21);
    const char* end = internal::i64toa(i64, buffer);
    os_->Pop(21 - (end - buffer));
    return true;
}

template<>
inline bool Writer<StringBuffer>::WriteUint64(uint64_t u) {
    char *buffer = os_->Push(20);
    const char* end = internal::u64toa(u, buffer);
    os_->Pop(20 - (end - buffer));
    return true;
}

template<>
inline bool Writer<StringBuffer>::WriteDouble(double d) {
    char *buffer = os_->Push(25);
    char* end = internal::dtoa(d, buffer);
    os_->Pop(25 - (end - buffer));
    return true;
}

} // namespace rapidjson

#ifdef _MSC_VER
RAPIDJSON_DIAG_POP
#endif

#endif // RAPIDJSON_RAPIDJSON_H_

//==============================================================================
// writer.h
//==============================================================================

// Copyright (C) 2011 Milo Yip
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#ifndef RAPIDJSON_READER_H_
#define RAPIDJSON_READER_H_

/*! \file reader.h */

#if defined(RAPIDJSON_SIMD) && defined(_MSC_VER)
#include <intrin.h>
#pragma intrinsic(_BitScanForward)
#endif
#ifdef RAPIDJSON_SSE42
#include <nmmintrin.h>
#elif defined(RAPIDJSON_SSE2)
#include <emmintrin.h>
#endif

#ifdef _MSC_VER
RAPIDJSON_DIAG_PUSH
RAPIDJSON_DIAG_OFF(4127)  // conditional expression is constant
RAPIDJSON_DIAG_OFF(4702)  // unreachable code
#endif

//!@cond RAPIDJSON_HIDDEN_FROM_DOXYGEN
#define RAPIDJSON_NOTHING /* deliberately empty */
#ifndef RAPIDJSON_PARSE_ERROR_EARLY_RETURN
#define RAPIDJSON_PARSE_ERROR_EARLY_RETURN(value) \
    RAPIDJSON_MULTILINEMACRO_BEGIN \
    if (HasParseError()) { return value; } \
    RAPIDJSON_MULTILINEMACRO_END
#endif
#define RAPIDJSON_PARSE_ERROR_EARLY_RETURN_VOID \
    RAPIDJSON_PARSE_ERROR_EARLY_RETURN(RAPIDJSON_NOTHING)
//!@endcond

/*! \def RAPIDJSON_PARSE_ERROR_NORETURN
    \ingroup RAPIDJSON_ERRORS
    \brief Macro to indicate a parse error.
    \param parseErrorCode \ref rapidjson::ParseErrorCode of the error
    \param offset  position of the error in JSON input (\c size_t)

    This macros can be used as a customization point for the internal
    error handling mechanism of RapidJSON.

    A common usage model is to throw an exception instead of requiring the
    caller to explicitly check the \ref rapidjson::GenericReader::Parse's
    return value:

    \code
    #define RAPIDJSON_PARSE_ERROR_NORETURN(parseErrorCode,offset) \
       throw ParseException(parseErrorCode, #parseErrorCode, offset)

    #include <stdexcept>               // std::runtime_error
    #include "rapidjson/error/error.h" // rapidjson::ParseResult

    struct ParseException : std::runtime_error, rapidjson::ParseResult {
      ParseException(rapidjson::ParseErrorCode code, const char* msg, size_t offset)
        : std::runtime_error(msg), ParseResult(code, offset) {}
    };

    #include "rapidjson/reader.h"
    \endcode

    \see RAPIDJSON_PARSE_ERROR, rapidjson::GenericReader::Parse
 */
#ifndef RAPIDJSON_PARSE_ERROR_NORETURN
#define RAPIDJSON_PARSE_ERROR_NORETURN(parseErrorCode, offset) \
    RAPIDJSON_MULTILINEMACRO_BEGIN \
    RAPIDJSON_ASSERT(!HasParseError()); /* Error can only be assigned once */ \
    SetParseError(parseErrorCode, offset); \
    RAPIDJSON_MULTILINEMACRO_END
#endif

/*! \def RAPIDJSON_PARSE_ERROR
    \ingroup RAPIDJSON_ERRORS
    \brief (Internal) macro to indicate and handle a parse error.
    \param parseErrorCode \ref rapidjson::ParseErrorCode of the error
    \param offset  position of the error in JSON input (\c size_t)

    Invokes RAPIDJSON_PARSE_ERROR_NORETURN and stops the parsing.

    \see RAPIDJSON_PARSE_ERROR_NORETURN
    \hideinitializer
 */
#ifndef RAPIDJSON_PARSE_ERROR
#define RAPIDJSON_PARSE_ERROR(parseErrorCode, offset) \
    RAPIDJSON_MULTILINEMACRO_BEGIN \
    RAPIDJSON_PARSE_ERROR_NORETURN(parseErrorCode, offset); \
    RAPIDJSON_PARSE_ERROR_EARLY_RETURN_VOID; \
    RAPIDJSON_MULTILINEMACRO_END
#endif

namespace rapidjson {

///////////////////////////////////////////////////////////////////////////////
// ParseFlag

//! Combination of parseFlags
/*! \see Reader::Parse, Document::Parse, Document::ParseInsitu, Document::ParseStream
 */
enum ParseFlag {
    kParseDefaultFlags = 0,         //!< Default parse flags. Non-destructive parsing. Text strings are decoded into allocated buffer.
    kParseInsituFlag = 1,           //!< In-situ(destructive) parsing.
    kParseValidateEncodingFlag = 2, //!< Validate encoding of JSON strings.
    kParseIterativeFlag = 4,        //!< Iterative(constant complexity in terms of function call stack size) parsing.
    kParseStopWhenDoneFlag = 8      //!< After parsing a complete JSON root from stream, stop further processing the rest of stream. When this flag is used, parser will not generate kParseErrorDocumentRootNotSingular error.
};

///////////////////////////////////////////////////////////////////////////////
// Handler

/*! \class rapidjson::Handler
    \brief Concept for receiving events from GenericReader upon parsing.
    The functions return true if no error occurs. If they return false, 
    the event publisher should terminate the process.
\code
concept Handler {
    typename Ch;

    bool Null();
    bool Bool(bool b);
    bool Int(int i);
    bool Uint(unsigned i);
    bool Int64(int64_t i);
    bool Uint64(uint64_t i);
    bool Double(double d);
    bool String(const Ch* str, SizeType length, bool copy);
    bool StartObject();
    bool EndObject(SizeType memberCount);
    bool StartArray();
    bool EndArray(SizeType elementCount);
};
\endcode
*/
///////////////////////////////////////////////////////////////////////////////
// BaseReaderHandler

//! Default implementation of Handler.
/*! This can be used as base class of any reader handler.
    \note implements Handler concept
*/
template<typename Encoding = UTF8<>, typename Derived = void>
struct BaseReaderHandler {
    typedef typename Encoding::Ch Ch;

    typedef typename internal::SelectIf<internal::IsSame<Derived, void>, BaseReaderHandler, Derived>::Type Override;

    bool Default() { return true; }
    bool Null() { return static_cast<Override&>(*this).Default(); }
    bool Bool(bool) { return static_cast<Override&>(*this).Default(); }
    bool Int(int) { return static_cast<Override&>(*this).Default(); }
    bool Uint(unsigned) { return static_cast<Override&>(*this).Default(); }
    bool Int64(int64_t) { return static_cast<Override&>(*this).Default(); }
    bool Uint64(uint64_t) { return static_cast<Override&>(*this).Default(); }
    bool Double(double) { return static_cast<Override&>(*this).Default(); }
    bool String(const Ch*, SizeType, bool) { return static_cast<Override&>(*this).Default(); }
    bool StartObject() { return static_cast<Override&>(*this).Default(); }
    bool EndObject(SizeType) { return static_cast<Override&>(*this).Default(); }
    bool StartArray() { return static_cast<Override&>(*this).Default(); }
    bool EndArray(SizeType) { return static_cast<Override&>(*this).Default(); }
};

///////////////////////////////////////////////////////////////////////////////
// StreamLocalCopy

namespace internal {

template<typename Stream, int = StreamTraits<Stream>::copyOptimization>
class StreamLocalCopy;

//! Do copy optimization.
template<typename Stream>
class StreamLocalCopy<Stream, 1> {
public:
    StreamLocalCopy(Stream& original) : s(original), original_(original) {}
    ~StreamLocalCopy() { original_ = s; }

    Stream s;

private:
    StreamLocalCopy& operator=(const StreamLocalCopy&) /* = delete */;

    Stream& original_;
};

//! Keep reference.
template<typename Stream>
class StreamLocalCopy<Stream, 0> {
public:
    StreamLocalCopy(Stream& original) : s(original) {}

    Stream& s;

private:
    StreamLocalCopy& operator=(const StreamLocalCopy&) /* = delete */;
};

} // namespace internal

///////////////////////////////////////////////////////////////////////////////
// SkipWhitespace

//! Skip the JSON white spaces in a stream.
/*! \param is A input stream for skipping white spaces.
    \note This function has SSE2/SSE4.2 specialization.
*/
template<typename InputStream>
void SkipWhitespace(InputStream& is) {
    internal::StreamLocalCopy<InputStream> copy(is);
    InputStream& s(copy.s);

    while (s.Peek() == ' ' || s.Peek() == '\n' || s.Peek() == '\r' || s.Peek() == '\t')
        s.Take();
}

#ifdef RAPIDJSON_SSE42
//! Skip whitespace with SSE 4.2 pcmpistrm instruction, testing 16 8-byte characters at once.
inline const char *SkipWhitespace_SIMD(const char* p) {
	// Fast return for single non-whitespace
	if (*p == ' ' || *p == '\n' || *p == '\r' || *p == '\t')
		++p;
	else
		return p;

	// 16-byte align to the next boundary
	const char* nextAligned = reinterpret_cast<const char*>((reinterpret_cast<size_t>(p) + 15) & ~15);
	while (p != nextAligned)
		if (*p == ' ' || *p == '\n' || *p == '\r' || *p == '\t')
			++p;
		else
			return p;

    // The rest of string using SIMD
	static const char whitespace[16] = " \n\r\t";
	const __m128i w = _mm_loadu_si128((const __m128i *)&whitespace[0]);

    for (;; p += 16) {
        const __m128i s = _mm_load_si128((const __m128i *)p);
        const unsigned r = _mm_cvtsi128_si32(_mm_cmpistrm(w, s, _SIDD_UBYTE_OPS | _SIDD_CMP_EQUAL_ANY | _SIDD_BIT_MASK | _SIDD_NEGATIVE_POLARITY));
        if (r != 0) {   // some of characters is non-whitespace
#ifdef _MSC_VER         // Find the index of first non-whitespace
            unsigned long offset;
            _BitScanForward(&offset, r);
            return p + offset;
#else
            return p + __builtin_ffs(r) - 1;
#endif
        }
    }
}

#elif defined(RAPIDJSON_SSE2)

//! Skip whitespace with SSE2 instructions, testing 16 8-byte characters at once.
inline const char *SkipWhitespace_SIMD(const char* p) {
	// Fast return for single non-whitespace
	if (*p == ' ' || *p == '\n' || *p == '\r' || *p == '\t')
		++p;
	else
		return p;

    // 16-byte align to the next boundary
	const char* nextAligned = reinterpret_cast<const char*>((reinterpret_cast<size_t>(p) + 15) & ~15);
	while (p != nextAligned)
		if (*p == ' ' || *p == '\n' || *p == '\r' || *p == '\t')
			++p;
		else
			return p;

    // The rest of string
	static const char whitespaces[4][17] = {
		"                ",
		"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
		"\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r",
		"\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"};

		const __m128i w0 = _mm_loadu_si128((const __m128i *)&whitespaces[0][0]);
		const __m128i w1 = _mm_loadu_si128((const __m128i *)&whitespaces[1][0]);
		const __m128i w2 = _mm_loadu_si128((const __m128i *)&whitespaces[2][0]);
		const __m128i w3 = _mm_loadu_si128((const __m128i *)&whitespaces[3][0]);

    for (;; p += 16) {
        const __m128i s = _mm_load_si128((const __m128i *)p);
        __m128i x = _mm_cmpeq_epi8(s, w0);
        x = _mm_or_si128(x, _mm_cmpeq_epi8(s, w1));
        x = _mm_or_si128(x, _mm_cmpeq_epi8(s, w2));
        x = _mm_or_si128(x, _mm_cmpeq_epi8(s, w3));
        unsigned short r = (unsigned short)~_mm_movemask_epi8(x);
        if (r != 0) {   // some of characters may be non-whitespace
#ifdef _MSC_VER         // Find the index of first non-whitespace
            unsigned long offset;
            _BitScanForward(&offset, r);
            return p + offset;
#else
            return p + __builtin_ffs(r) - 1;
#endif
        }
    }
}

#endif // RAPIDJSON_SSE2

#ifdef RAPIDJSON_SIMD
//! Template function specialization for InsituStringStream
template<> inline void SkipWhitespace(InsituStringStream& is) { 
    is.src_ = const_cast<char*>(SkipWhitespace_SIMD(is.src_));
}

//! Template function specialization for StringStream
template<> inline void SkipWhitespace(StringStream& is) {
    is.src_ = SkipWhitespace_SIMD(is.src_);
}
#endif // RAPIDJSON_SIMD

///////////////////////////////////////////////////////////////////////////////
// GenericReader

//! SAX-style JSON parser. Use \ref Reader for UTF8 encoding and default allocator.
/*! GenericReader parses JSON text from a stream, and send events synchronously to an 
    object implementing Handler concept.

    It needs to allocate a stack for storing a single decoded string during 
    non-destructive parsing.

    For in-situ parsing, the decoded string is directly written to the source 
    text string, no temporary buffer is required.

    A GenericReader object can be reused for parsing multiple JSON text.
    
    \tparam SourceEncoding Encoding of the input stream.
    \tparam TargetEncoding Encoding of the parse output.
    \tparam StackAllocator Allocator type for stack.
*/
template <typename SourceEncoding, typename TargetEncoding, typename StackAllocator = CrtAllocator>
class GenericReader {
public:
    typedef typename SourceEncoding::Ch Ch; //!< SourceEncoding character type

    //! Constructor.
    /*! \param allocator Optional allocator for allocating stack memory. (Only use for non-destructive parsing)
        \param stackCapacity stack capacity in bytes for storing a single decoded string.  (Only use for non-destructive parsing)
    */
    GenericReader(StackAllocator* stackAllocator = 0, size_t stackCapacity = kDefaultStackCapacity) : stack_(stackAllocator, stackCapacity), parseResult_() {}

    //! Parse JSON text.
    /*! \tparam parseFlags Combination of \ref ParseFlag.
        \tparam InputStream Type of input stream, implementing Stream concept.
        \tparam Handler Type of handler, implementing Handler concept.
        \param is Input stream to be parsed.
        \param handler The handler to receive events.
        \return Whether the parsing is successful.
    */
    template <unsigned parseFlags, typename InputStream, typename Handler>
    ParseResult Parse(InputStream& is, Handler& handler) {
        if (parseFlags & kParseIterativeFlag)
            return IterativeParse<parseFlags>(is, handler);

        parseResult_.Clear();

        ClearStackOnExit scope(*this);

        SkipWhitespace(is);

        if (is.Peek() == '\0') {
            RAPIDJSON_PARSE_ERROR_NORETURN(kParseErrorDocumentEmpty, is.Tell());
            RAPIDJSON_PARSE_ERROR_EARLY_RETURN(parseResult_);
        }
        else {
            ParseValue<parseFlags>(is, handler);
            RAPIDJSON_PARSE_ERROR_EARLY_RETURN(parseResult_);

            if (!(parseFlags & kParseStopWhenDoneFlag)) {
                SkipWhitespace(is);

                if (is.Peek() != '\0') {
                    RAPIDJSON_PARSE_ERROR_NORETURN(kParseErrorDocumentRootNotSingular, is.Tell());
                    RAPIDJSON_PARSE_ERROR_EARLY_RETURN(parseResult_);
                }
            }
        }

        return parseResult_;
    }

    //! Parse JSON text (with \ref kParseDefaultFlags)
    /*! \tparam InputStream Type of input stream, implementing Stream concept
        \tparam Handler Type of handler, implementing Handler concept.
        \param is Input stream to be parsed.
        \param handler The handler to receive events.
        \return Whether the parsing is successful.
    */
    template <typename InputStream, typename Handler>
    ParseResult Parse(InputStream& is, Handler& handler) {
        return Parse<kParseDefaultFlags>(is, handler);
    }

    //! Whether a parse error has occured in the last parsing.
    bool HasParseError() const { return parseResult_.IsError(); }
    
    //! Get the \ref ParseErrorCode of last parsing.
    ParseErrorCode GetParseErrorCode() const { return parseResult_.Code(); }

    //! Get the position of last parsing error in input, 0 otherwise.
    size_t GetErrorOffset() const { return parseResult_.Offset(); }

protected:
    void SetParseError(ParseErrorCode code, size_t offset) { parseResult_.Set(code, offset); }

private:
    // Prohibit copy constructor & assignment operator.
    GenericReader(const GenericReader&);
    GenericReader& operator=(const GenericReader&);

    void ClearStack() { stack_.Clear(); }

    // clear stack on any exit from ParseStream, e.g. due to exception
    struct ClearStackOnExit {
        explicit ClearStackOnExit(GenericReader& r) : r_(r) {}
        ~ClearStackOnExit() { r_.ClearStack(); }
    private:
        GenericReader& r_;
        ClearStackOnExit(const ClearStackOnExit&);
        ClearStackOnExit& operator=(const ClearStackOnExit&);
    };

    // Parse object: { string : value, ... }
    template<unsigned parseFlags, typename InputStream, typename Handler>
    void ParseObject(InputStream& is, Handler& handler) {
        RAPIDJSON_ASSERT(is.Peek() == '{');
        is.Take();  // Skip '{'
        
        if (!handler.StartObject())
            RAPIDJSON_PARSE_ERROR(kParseErrorTermination, is.Tell());

        SkipWhitespace(is);

        if (is.Peek() == '}') {
            is.Take();
            if (!handler.EndObject(0))  // empty object
                RAPIDJSON_PARSE_ERROR(kParseErrorTermination, is.Tell());
            return;
        }

        for (SizeType memberCount = 0;;) {
            if (is.Peek() != '"')
                RAPIDJSON_PARSE_ERROR(kParseErrorObjectMissName, is.Tell());

            ParseString<parseFlags>(is, handler);
            RAPIDJSON_PARSE_ERROR_EARLY_RETURN_VOID;

            SkipWhitespace(is);

            if (is.Take() != ':')
                RAPIDJSON_PARSE_ERROR(kParseErrorObjectMissColon, is.Tell());

            SkipWhitespace(is);

            ParseValue<parseFlags>(is, handler);
            RAPIDJSON_PARSE_ERROR_EARLY_RETURN_VOID;

            SkipWhitespace(is);

            ++memberCount;

            switch (is.Take()) {
                case ',': SkipWhitespace(is); break;
                case '}': 
                    if (!handler.EndObject(memberCount))
                        RAPIDJSON_PARSE_ERROR(kParseErrorTermination, is.Tell());
                    else
                        return;
                default:  RAPIDJSON_PARSE_ERROR(kParseErrorObjectMissCommaOrCurlyBracket, is.Tell());
            }
        }
    }

    // Parse array: [ value, ... ]
    template<unsigned parseFlags, typename InputStream, typename Handler>
    void ParseArray(InputStream& is, Handler& handler) {
        RAPIDJSON_ASSERT(is.Peek() == '[');
        is.Take();  // Skip '['
        
        if (!handler.StartArray())
            RAPIDJSON_PARSE_ERROR(kParseErrorTermination, is.Tell());
        
        SkipWhitespace(is);

        if (is.Peek() == ']') {
            is.Take();
            if (!handler.EndArray(0)) // empty array
                RAPIDJSON_PARSE_ERROR(kParseErrorTermination, is.Tell());
            return;
        }

        for (SizeType elementCount = 0;;) {
            ParseValue<parseFlags>(is, handler);
            RAPIDJSON_PARSE_ERROR_EARLY_RETURN_VOID;

            ++elementCount;
            SkipWhitespace(is);

            switch (is.Take()) {
                case ',': SkipWhitespace(is); break;
                case ']': 
                    if (!handler.EndArray(elementCount))
                        RAPIDJSON_PARSE_ERROR(kParseErrorTermination, is.Tell());
                    else
                        return;
                default:  RAPIDJSON_PARSE_ERROR(kParseErrorArrayMissCommaOrSquareBracket, is.Tell());
            }
        }
    }

    template<unsigned parseFlags, typename InputStream, typename Handler>
    void ParseNull(InputStream& is, Handler& handler) {
        RAPIDJSON_ASSERT(is.Peek() == 'n');
        is.Take();

        if (is.Take() == 'u' && is.Take() == 'l' && is.Take() == 'l') {
            if (!handler.Null())
                RAPIDJSON_PARSE_ERROR(kParseErrorTermination, is.Tell());
        }
        else
            RAPIDJSON_PARSE_ERROR(kParseErrorValueInvalid, is.Tell() - 1);
    }

    template<unsigned parseFlags, typename InputStream, typename Handler>
    void ParseTrue(InputStream& is, Handler& handler) {
        RAPIDJSON_ASSERT(is.Peek() == 't');
        is.Take();

        if (is.Take() == 'r' && is.Take() == 'u' && is.Take() == 'e') {
            if (!handler.Bool(true))
                RAPIDJSON_PARSE_ERROR(kParseErrorTermination, is.Tell());
        }
        else
            RAPIDJSON_PARSE_ERROR(kParseErrorValueInvalid, is.Tell() - 1);
    }

    template<unsigned parseFlags, typename InputStream, typename Handler>
    void ParseFalse(InputStream& is, Handler& handler) {
        RAPIDJSON_ASSERT(is.Peek() == 'f');
        is.Take();

        if (is.Take() == 'a' && is.Take() == 'l' && is.Take() == 's' && is.Take() == 'e') {
            if (!handler.Bool(false))
                RAPIDJSON_PARSE_ERROR(kParseErrorTermination, is.Tell());
        }
        else
            RAPIDJSON_PARSE_ERROR(kParseErrorValueInvalid, is.Tell() - 1);
    }

    // Helper function to parse four hexidecimal digits in \uXXXX in ParseString().
    template<typename InputStream>
    unsigned ParseHex4(InputStream& is) {
        unsigned codepoint = 0;
        for (int i = 0; i < 4; i++) {
            Ch c = is.Take();
            codepoint <<= 4;
            codepoint += static_cast<unsigned>(c);
            if (c >= '0' && c <= '9')
                codepoint -= '0';
            else if (c >= 'A' && c <= 'F')
                codepoint -= 'A' - 10;
            else if (c >= 'a' && c <= 'f')
                codepoint -= 'a' - 10;
            else {
                RAPIDJSON_PARSE_ERROR_NORETURN(kParseErrorStringUnicodeEscapeInvalidHex, is.Tell() - 1);
                RAPIDJSON_PARSE_ERROR_EARLY_RETURN(0);
            }
        }
        return codepoint;
    }

    class StackStream {
    public:
        typedef typename TargetEncoding::Ch Ch;

        StackStream(internal::Stack<StackAllocator>& stack) : stack_(stack), length_(0) {}
        RAPIDJSON_FORCEINLINE void Put(Ch c) {
            *stack_.template Push<Ch>() = c;
            ++length_;
        }
        internal::Stack<StackAllocator>& stack_;
        SizeType length_;

    private:
        StackStream(const StackStream&);
        StackStream& operator=(const StackStream&);
    };

    // Parse string and generate String event. Different code paths for kParseInsituFlag.
    template<unsigned parseFlags, typename InputStream, typename Handler>
    void ParseString(InputStream& is, Handler& handler) {
        internal::StreamLocalCopy<InputStream> copy(is);
        InputStream& s(copy.s);

        if (parseFlags & kParseInsituFlag) {
            typename InputStream::Ch *head = s.PutBegin();
            ParseStringToStream<parseFlags, SourceEncoding, SourceEncoding>(s, s);
            RAPIDJSON_PARSE_ERROR_EARLY_RETURN_VOID;
            size_t length = s.PutEnd(head) - 1;
            RAPIDJSON_ASSERT(length <= 0xFFFFFFFF);
            if (!handler.String((typename TargetEncoding::Ch*)head, SizeType(length), false))
                RAPIDJSON_PARSE_ERROR(kParseErrorTermination, s.Tell());
        }
        else {
            StackStream stackStream(stack_);
            ParseStringToStream<parseFlags, SourceEncoding, TargetEncoding>(s, stackStream);
            RAPIDJSON_PARSE_ERROR_EARLY_RETURN_VOID;
            if (!handler.String(stack_.template Pop<typename TargetEncoding::Ch>(stackStream.length_), stackStream.length_ - 1, true))
                RAPIDJSON_PARSE_ERROR(kParseErrorTermination, s.Tell());
        }
    }

    // Parse string to an output is
    // This function handles the prefix/suffix double quotes, escaping, and optional encoding validation.
    template<unsigned parseFlags, typename SEncoding, typename TEncoding, typename InputStream, typename OutputStream>
    RAPIDJSON_FORCEINLINE void ParseStringToStream(InputStream& is, OutputStream& os) {
//!@cond RAPIDJSON_HIDDEN_FROM_DOXYGEN
#define Z16 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        static const char escape[256] = {
            Z16, Z16, 0, 0,'\"', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'/', 
            Z16, Z16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'\\', 0, 0, 0, 
            0, 0,'\b', 0, 0, 0,'\f', 0, 0, 0, 0, 0, 0, 0,'\n', 0, 
            0, 0,'\r', 0,'\t', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            Z16, Z16, Z16, Z16, Z16, Z16, Z16, Z16
        };
#undef Z16
//!@endcond

        RAPIDJSON_ASSERT(is.Peek() == '\"');
        is.Take();  // Skip '\"'

        for (;;) {
            Ch c = is.Peek();
            if (c == '\\') {    // Escape
                is.Take();
                Ch e = is.Take();
                if ((sizeof(Ch) == 1 || unsigned(e) < 256) && escape[(unsigned char)e]) {
                    os.Put(escape[(unsigned char)e]);
                }
                else if (e == 'u') {    // Unicode
                    unsigned codepoint = ParseHex4(is);
                    if (codepoint >= 0xD800 && codepoint <= 0xDBFF) {
                        // Handle UTF-16 surrogate pair
                        if (is.Take() != '\\' || is.Take() != 'u')
                            RAPIDJSON_PARSE_ERROR(kParseErrorStringUnicodeSurrogateInvalid, is.Tell() - 2);
                        unsigned codepoint2 = ParseHex4(is);
                        if (codepoint2 < 0xDC00 || codepoint2 > 0xDFFF)
                            RAPIDJSON_PARSE_ERROR(kParseErrorStringUnicodeSurrogateInvalid, is.Tell() - 2);
                        codepoint = (((codepoint - 0xD800) << 10) | (codepoint2 - 0xDC00)) + 0x10000;
                    }
                    TEncoding::Encode(os, codepoint);
                }
                else
                    RAPIDJSON_PARSE_ERROR(kParseErrorStringEscapeInvalid, is.Tell() - 1);
            }
            else if (c == '"') {    // Closing double quote
                is.Take();
                os.Put('\0');   // null-terminate the string
                return;
            }
            else if (c == '\0')
                RAPIDJSON_PARSE_ERROR(kParseErrorStringMissQuotationMark, is.Tell() - 1);
            else if ((unsigned)c < 0x20) // RFC 4627: unescaped = %x20-21 / %x23-5B / %x5D-10FFFF
                RAPIDJSON_PARSE_ERROR(kParseErrorStringEscapeInvalid, is.Tell() - 1);
            else {
                if (parseFlags & kParseValidateEncodingFlag ? 
                    !Transcoder<SEncoding, TEncoding>::Validate(is, os) : 
                    !Transcoder<SEncoding, TEncoding>::Transcode(is, os))
                    RAPIDJSON_PARSE_ERROR(kParseErrorStringInvalidEncoding, is.Tell());
            }
        }
    }

    inline double StrtodFastPath(double significand, int exp) {
        // Fast path only works on limited range of values.
        // But for simplicity and performance, currently only implement this.
        // see http://www.exploringbinary.com/fast-path-decimal-to-floating-point-conversion/
        if (exp < -308)
            return 0.0;
        else if (exp >= 0)
            return significand * internal::Pow10(exp);
        else
            return significand / internal::Pow10(-exp);
    }

    template<unsigned parseFlags, typename InputStream, typename Handler>
    void ParseNumber(InputStream& is, Handler& handler) {
        internal::StreamLocalCopy<InputStream> copy(is);
        InputStream& s(copy.s);

        // Parse minus
        bool minus = false;
        if (s.Peek() == '-') {
            minus = true;
            s.Take();
        }

        // Parse int: zero / ( digit1-9 *DIGIT )
        unsigned i = 0;
        uint64_t i64 = 0;
        bool use64bit = false;
        if (s.Peek() == '0') {
            i = 0;
            s.Take();
        }
        else if (s.Peek() >= '1' && s.Peek() <= '9') {
            i = static_cast<unsigned>(s.Take() - '0');

            if (minus)
                while (s.Peek() >= '0' && s.Peek() <= '9') {
                    if (i >= 214748364) { // 2^31 = 2147483648
                        if (i != 214748364 || s.Peek() > '8') {
                            i64 = i;
                            use64bit = true;
                            break;
                        }
                    }
                    i = i * 10 + static_cast<unsigned>(s.Take() - '0');
                }
            else
                while (s.Peek() >= '0' && s.Peek() <= '9') {
                    if (i >= 429496729) { // 2^32 - 1 = 4294967295
                        if (i != 429496729 || s.Peek() > '5') {
                            i64 = i;
                            use64bit = true;
                            break;
                        }
                    }
                    i = i * 10 + static_cast<unsigned>(s.Take() - '0');
                }
        }
        else
            RAPIDJSON_PARSE_ERROR(kParseErrorValueInvalid, s.Tell());

        // Parse 64bit int
        double d = 0.0;
        bool useDouble = false;
        if (use64bit) {
            if (minus) 
                while (s.Peek() >= '0' && s.Peek() <= '9') {                    
                     if (i64 >= RAPIDJSON_UINT64_C2(0x0CCCCCCC, 0xCCCCCCCC)) // 2^63 = 9223372036854775808
                        if (i64 != RAPIDJSON_UINT64_C2(0x0CCCCCCC, 0xCCCCCCCC) || s.Peek() > '8') {
                            d = (double)i64;
                            useDouble = true;
                            break;
                        }
                    i64 = i64 * 10 + static_cast<unsigned>(s.Take() - '0');
                }
            else
                while (s.Peek() >= '0' && s.Peek() <= '9') {                    
                    if (i64 >= RAPIDJSON_UINT64_C2(0x19999999, 0x99999999)) // 2^64 - 1 = 18446744073709551615
                        if (i64 != RAPIDJSON_UINT64_C2(0x19999999, 0x99999999) || s.Peek() > '5') {
                            d = (double)i64;
                            useDouble = true;
                            break;
                        }
                    i64 = i64 * 10 + static_cast<unsigned>(s.Take() - '0');
                }
        }

        // Force double for big integer
        if (useDouble) {
            while (s.Peek() >= '0' && s.Peek() <= '9') {
                if (d >= 1.7976931348623157e307) // DBL_MAX / 10.0
                    RAPIDJSON_PARSE_ERROR(kParseErrorNumberTooBig, s.Tell());
                d = d * 10 + (s.Take() - '0');
            }
        }

        // Parse frac = decimal-point 1*DIGIT
        int expFrac = 0;
        if (s.Peek() == '.') {
            s.Take();

#if RAPIDJSON_64BIT
            // Use i64 to store significand in 64-bit architecture
            if (!useDouble) {
                if (!use64bit)
                    i64 = i;
        
                while (s.Peek() >= '0' && s.Peek() <= '9') {
                    if (i64 >= RAPIDJSON_UINT64_C2(0x19999999, 0x99999999))
                        break;
                    else {
                        i64 = i64 * 10 + static_cast<unsigned>(s.Take() - '0');
                        --expFrac;
                    }
                }

                d = (double)i64;
            }
#else
            // Use double to store significand in 32-bit architecture
            if (!useDouble)
                d = use64bit ? (double)i64 : (double)i;
#endif
            useDouble = true;

            while (s.Peek() >= '0' && s.Peek() <= '9') {
                d = d * 10 + (s.Take() - '0');
                --expFrac;
            }

            if (expFrac == 0)
                RAPIDJSON_PARSE_ERROR(kParseErrorNumberMissFraction, s.Tell());
        }

        // Parse exp = e [ minus / plus ] 1*DIGIT
        int exp = 0;
        if (s.Peek() == 'e' || s.Peek() == 'E') {
            if (!useDouble) {
                d = use64bit ? (double)i64 : (double)i;
                useDouble = true;
            }
            s.Take();

            bool expMinus = false;
            if (s.Peek() == '+')
                s.Take();
            else if (s.Peek() == '-') {
                s.Take();
                expMinus = true;
            }

            if (s.Peek() >= '0' && s.Peek() <= '9') {
                exp = s.Take() - '0';
                while (s.Peek() >= '0' && s.Peek() <= '9') {
                    exp = exp * 10 + (s.Take() - '0');
                    if (exp > 308 && !expMinus) // exp > 308 should be rare, so it should be checked first.
                        RAPIDJSON_PARSE_ERROR(kParseErrorNumberTooBig, s.Tell());
                }
            }
            else
                RAPIDJSON_PARSE_ERROR(kParseErrorNumberMissExponent, s.Tell());

            if (expMinus)
                exp = -exp;
        }

        // Finish parsing, call event according to the type of number.
        bool cont = true;
        if (useDouble) {
            int expSum = exp + expFrac;
            if (expSum < -308) {
                // Prevent expSum < -308, making Pow10(expSum) = 0
                d = StrtodFastPath(d, exp);
                d = StrtodFastPath(d, expFrac);
            }
            else
                d = StrtodFastPath(d, expSum);

            cont = handler.Double(minus ? -d : d);
        }
        else {
            if (use64bit) {
                if (minus)
                    cont = handler.Int64(-(int64_t)i64);
                else
                    cont = handler.Uint64(i64);
            }
            else {
                if (minus)
                    cont = handler.Int(-(int)i);
                else
                    cont = handler.Uint(i);
            }
        }
        if (!cont)
            RAPIDJSON_PARSE_ERROR(kParseErrorTermination, s.Tell());
    }

    // Parse any JSON value
    template<unsigned parseFlags, typename InputStream, typename Handler>
    void ParseValue(InputStream& is, Handler& handler) {
        switch (is.Peek()) {
            case 'n': ParseNull  <parseFlags>(is, handler); break;
            case 't': ParseTrue  <parseFlags>(is, handler); break;
            case 'f': ParseFalse <parseFlags>(is, handler); break;
            case '"': ParseString<parseFlags>(is, handler); break;
            case '{': ParseObject<parseFlags>(is, handler); break;
            case '[': ParseArray <parseFlags>(is, handler); break;
            default : ParseNumber<parseFlags>(is, handler);
        }
    }

    // Iterative Parsing

    // States
    enum IterativeParsingState {
        IterativeParsingStartState = 0,
        IterativeParsingFinishState,
        IterativeParsingErrorState,

        // Object states
        IterativeParsingObjectInitialState,
        IterativeParsingMemberKeyState,
        IterativeParsingKeyValueDelimiterState,
        IterativeParsingMemberValueState,
        IterativeParsingMemberDelimiterState,
        IterativeParsingObjectFinishState,

        // Array states
        IterativeParsingArrayInitialState,
        IterativeParsingElementState,
        IterativeParsingElementDelimiterState,
        IterativeParsingArrayFinishState,

        // Single value state
        IterativeParsingValueState,

        cIterativeParsingStateCount
    };

    // Tokens
    enum Token {
        LeftBracketToken = 0,
        RightBracketToken,

        LeftCurlyBracketToken,
        RightCurlyBracketToken,

        CommaToken,
        ColonToken,

        StringToken,
        FalseToken,
        TrueToken,
        NullToken,
        NumberToken,

        kTokenCount
    };

    RAPIDJSON_FORCEINLINE Token Tokenize(Ch c) {

//!@cond RAPIDJSON_HIDDEN_FROM_DOXYGEN
#define N NumberToken
#define N16 N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
        // Maps from ASCII to Token
        static const unsigned char tokenMap[256] = {
            N16, // 00~0F
            N16, // 10~1F
            N, N, StringToken, N, N, N, N, N, N, N, N, N, CommaToken, N, N, N, // 20~2F
            N, N, N, N, N, N, N, N, N, N, ColonToken, N, N, N, N, N, // 30~3F
            N16, // 40~4F
            N, N, N, N, N, N, N, N, N, N, N, LeftBracketToken, N, RightBracketToken, N, N, // 50~5F
            N, N, N, N, N, N, FalseToken, N, N, N, N, N, N, N, NullToken, N, // 60~6F
            N, N, N, N, TrueToken, N, N, N, N, N, N, LeftCurlyBracketToken, N, RightCurlyBracketToken, N, N, // 70~7F
            N16, N16, N16, N16, N16, N16, N16, N16 // 80~FF
        };
#undef N
#undef N16
//!@endcond
        
        if (sizeof(Ch) == 1 || unsigned(c) < 256)
            return (Token)tokenMap[(unsigned char)c];
        else
            return NumberToken;
    }

    RAPIDJSON_FORCEINLINE IterativeParsingState Predict(IterativeParsingState state, Token token) {
        // current state x one lookahead token -> new state
        static const char G[cIterativeParsingStateCount][kTokenCount] = {
            // Start
            {
                IterativeParsingArrayInitialState,  // Left bracket
                IterativeParsingErrorState,         // Right bracket
                IterativeParsingObjectInitialState, // Left curly bracket
                IterativeParsingErrorState,         // Right curly bracket
                IterativeParsingErrorState,         // Comma
                IterativeParsingErrorState,         // Colon
                IterativeParsingValueState,         // String
                IterativeParsingValueState,         // False
                IterativeParsingValueState,         // True
                IterativeParsingValueState,         // Null
                IterativeParsingValueState          // Number
            },
            // Finish(sink state)
            {
                IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState,
                IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState,
                IterativeParsingErrorState
            },
            // Error(sink state)
            {
                IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState,
                IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState,
                IterativeParsingErrorState
            },
            // ObjectInitial
            {
                IterativeParsingErrorState,         // Left bracket
                IterativeParsingErrorState,         // Right bracket
                IterativeParsingErrorState,         // Left curly bracket
                IterativeParsingObjectFinishState,  // Right curly bracket
                IterativeParsingErrorState,         // Comma
                IterativeParsingErrorState,         // Colon
                IterativeParsingMemberKeyState,     // String
                IterativeParsingErrorState,         // False
                IterativeParsingErrorState,         // True
                IterativeParsingErrorState,         // Null
                IterativeParsingErrorState          // Number
            },
            // MemberKey
            {
                IterativeParsingErrorState,             // Left bracket
                IterativeParsingErrorState,             // Right bracket
                IterativeParsingErrorState,             // Left curly bracket
                IterativeParsingErrorState,             // Right curly bracket
                IterativeParsingErrorState,             // Comma
                IterativeParsingKeyValueDelimiterState, // Colon
                IterativeParsingErrorState,             // String
                IterativeParsingErrorState,             // False
                IterativeParsingErrorState,             // True
                IterativeParsingErrorState,             // Null
                IterativeParsingErrorState              // Number
            },
            // KeyValueDelimiter
            {
                IterativeParsingArrayInitialState,      // Left bracket(push MemberValue state)
                IterativeParsingErrorState,             // Right bracket
                IterativeParsingObjectInitialState,     // Left curly bracket(push MemberValue state)
                IterativeParsingErrorState,             // Right curly bracket
                IterativeParsingErrorState,             // Comma
                IterativeParsingErrorState,             // Colon
                IterativeParsingMemberValueState,       // String
                IterativeParsingMemberValueState,       // False
                IterativeParsingMemberValueState,       // True
                IterativeParsingMemberValueState,       // Null
                IterativeParsingMemberValueState        // Number
            },
            // MemberValue
            {
                IterativeParsingErrorState,             // Left bracket
                IterativeParsingErrorState,             // Right bracket
                IterativeParsingErrorState,             // Left curly bracket
                IterativeParsingObjectFinishState,      // Right curly bracket
                IterativeParsingMemberDelimiterState,   // Comma
                IterativeParsingErrorState,             // Colon
                IterativeParsingErrorState,             // String
                IterativeParsingErrorState,             // False
                IterativeParsingErrorState,             // True
                IterativeParsingErrorState,             // Null
                IterativeParsingErrorState              // Number
            },
            // MemberDelimiter
            {
                IterativeParsingErrorState,         // Left bracket
                IterativeParsingErrorState,         // Right bracket
                IterativeParsingErrorState,         // Left curly bracket
                IterativeParsingErrorState,         // Right curly bracket
                IterativeParsingErrorState,         // Comma
                IterativeParsingErrorState,         // Colon
                IterativeParsingMemberKeyState,     // String
                IterativeParsingErrorState,         // False
                IterativeParsingErrorState,         // True
                IterativeParsingErrorState,         // Null
                IterativeParsingErrorState          // Number
            },
            // ObjectFinish(sink state)
            {
                IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState,
                IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState,
                IterativeParsingErrorState
            },
            // ArrayInitial
            {
                IterativeParsingArrayInitialState,      // Left bracket(push Element state)
                IterativeParsingArrayFinishState,       // Right bracket
                IterativeParsingObjectInitialState,     // Left curly bracket(push Element state)
                IterativeParsingErrorState,             // Right curly bracket
                IterativeParsingErrorState,             // Comma
                IterativeParsingErrorState,             // Colon
                IterativeParsingElementState,           // String
                IterativeParsingElementState,           // False
                IterativeParsingElementState,           // True
                IterativeParsingElementState,           // Null
                IterativeParsingElementState            // Number
            },
            // Element
            {
                IterativeParsingErrorState,             // Left bracket
                IterativeParsingArrayFinishState,       // Right bracket
                IterativeParsingErrorState,             // Left curly bracket
                IterativeParsingErrorState,             // Right curly bracket
                IterativeParsingElementDelimiterState,  // Comma
                IterativeParsingErrorState,             // Colon
                IterativeParsingErrorState,             // String
                IterativeParsingErrorState,             // False
                IterativeParsingErrorState,             // True
                IterativeParsingErrorState,             // Null
                IterativeParsingErrorState              // Number
            },
            // ElementDelimiter
            {
                IterativeParsingArrayInitialState,      // Left bracket(push Element state)
                IterativeParsingErrorState,             // Right bracket
                IterativeParsingObjectInitialState,     // Left curly bracket(push Element state)
                IterativeParsingErrorState,             // Right curly bracket
                IterativeParsingErrorState,             // Comma
                IterativeParsingErrorState,             // Colon
                IterativeParsingElementState,           // String
                IterativeParsingElementState,           // False
                IterativeParsingElementState,           // True
                IterativeParsingElementState,           // Null
                IterativeParsingElementState            // Number
            },
            // ArrayFinish(sink state)
            {
                IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState,
                IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState,
                IterativeParsingErrorState
            },
            // Single Value (sink state)
            {
                IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState,
                IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState, IterativeParsingErrorState,
                IterativeParsingErrorState
            }
        }; // End of G

        return (IterativeParsingState)G[state][token];
    }

    // Make an advance in the token stream and state based on the candidate destination state which was returned by Transit().
    // May return a new state on state pop.
    template <unsigned parseFlags, typename InputStream, typename Handler>
    RAPIDJSON_FORCEINLINE IterativeParsingState Transit(IterativeParsingState src, Token token, IterativeParsingState dst, InputStream& is, Handler& handler) {
        switch (dst) {
        case IterativeParsingStartState:
            RAPIDJSON_ASSERT(false);
            return IterativeParsingErrorState;

        case IterativeParsingFinishState:
            return dst;

        case IterativeParsingErrorState:
            return dst;

        case IterativeParsingObjectInitialState:
        case IterativeParsingArrayInitialState:
        {
            // Push the state(Element or MemeberValue) if we are nested in another array or value of member.
            // In this way we can get the correct state on ObjectFinish or ArrayFinish by frame pop.
            IterativeParsingState n = src;
            if (src == IterativeParsingArrayInitialState || src == IterativeParsingElementDelimiterState)
                n = IterativeParsingElementState;
            else if (src == IterativeParsingKeyValueDelimiterState)
                n = IterativeParsingMemberValueState;
            // Push current state.
            *stack_.template Push<SizeType>(1) = n;
            // Initialize and push the member/element count.
            *stack_.template Push<SizeType>(1) = 0;
            // Call handler
            bool hr = (dst == IterativeParsingObjectInitialState) ? handler.StartObject() : handler.StartArray();
            // On handler short circuits the parsing.
            if (!hr) {
                RAPIDJSON_PARSE_ERROR_NORETURN(kParseErrorTermination, is.Tell());
                return IterativeParsingErrorState;
            }
            else {
                is.Take();
                return dst;
            }
        }

        case IterativeParsingMemberKeyState:
            ParseString<parseFlags>(is, handler);
            if (HasParseError())
                return IterativeParsingErrorState;
            else
                return dst;

        case IterativeParsingKeyValueDelimiterState:
            if (token == ColonToken) {
                is.Take();
                return dst;
            }
            else
                return IterativeParsingErrorState;

        case IterativeParsingMemberValueState:
            // Must be non-compound value. Or it would be ObjectInitial or ArrayInitial state.
            ParseValue<parseFlags>(is, handler);
            if (HasParseError()) {
                return IterativeParsingErrorState;
            }
            return dst;

        case IterativeParsingElementState:
            // Must be non-compound value. Or it would be ObjectInitial or ArrayInitial state.
            ParseValue<parseFlags>(is, handler);
            if (HasParseError()) {
                return IterativeParsingErrorState;
            }
            return dst;

        case IterativeParsingMemberDelimiterState:
        case IterativeParsingElementDelimiterState:
            is.Take();
            // Update member/element count.
            *stack_.template Top<SizeType>() = *stack_.template Top<SizeType>() + 1;
            return dst;

        case IterativeParsingObjectFinishState:
        {
            // Get member count.
            SizeType c = *stack_.template Pop<SizeType>(1);
            // If the object is not empty, count the last member.
            if (src == IterativeParsingMemberValueState)
                ++c;
            // Restore the state.
            IterativeParsingState n = static_cast<IterativeParsingState>(*stack_.template Pop<SizeType>(1));
            // Transit to Finish state if this is the topmost scope.
            if (n == IterativeParsingStartState)
                n = IterativeParsingFinishState;
            // Call handler
            bool hr = handler.EndObject(c);
            // On handler short circuits the parsing.
            if (!hr) {
                RAPIDJSON_PARSE_ERROR_NORETURN(kParseErrorTermination, is.Tell());
                return IterativeParsingErrorState;
            }
            else {
                is.Take();
                return n;
            }
        }

        case IterativeParsingArrayFinishState:
        {
            // Get element count.
            SizeType c = *stack_.template Pop<SizeType>(1);
            // If the array is not empty, count the last element.
            if (src == IterativeParsingElementState)
                ++c;
            // Restore the state.
            IterativeParsingState n = static_cast<IterativeParsingState>(*stack_.template Pop<SizeType>(1));
            // Transit to Finish state if this is the topmost scope.
            if (n == IterativeParsingStartState)
                n = IterativeParsingFinishState;
            // Call handler
            bool hr = handler.EndArray(c);
            // On handler short circuits the parsing.
            if (!hr) {
                RAPIDJSON_PARSE_ERROR_NORETURN(kParseErrorTermination, is.Tell());
                return IterativeParsingErrorState;
            }
            else {
                is.Take();
                return n;
            }
        }

        case IterativeParsingValueState:
            // Must be non-compound value. Or it would be ObjectInitial or ArrayInitial state.
            ParseValue<parseFlags>(is, handler);
            if (HasParseError()) {
                return IterativeParsingErrorState;
            }
            return IterativeParsingFinishState;

        default:
            RAPIDJSON_ASSERT(false);
            return IterativeParsingErrorState;
        }
    }

    template <typename InputStream>
    void HandleError(IterativeParsingState src, InputStream& is) {
        if (HasParseError()) {
            // Error flag has been set.
            return;
        }
        
        switch (src) {
        case IterativeParsingStartState:            RAPIDJSON_PARSE_ERROR(kParseErrorDocumentEmpty, is.Tell());
        case IterativeParsingFinishState:           RAPIDJSON_PARSE_ERROR(kParseErrorDocumentRootNotSingular, is.Tell());
        case IterativeParsingObjectInitialState:
        case IterativeParsingMemberDelimiterState:  RAPIDJSON_PARSE_ERROR(kParseErrorObjectMissName, is.Tell());
        case IterativeParsingMemberKeyState:        RAPIDJSON_PARSE_ERROR(kParseErrorObjectMissColon, is.Tell());
        case IterativeParsingMemberValueState:      RAPIDJSON_PARSE_ERROR(kParseErrorObjectMissCommaOrCurlyBracket, is.Tell());
        case IterativeParsingElementState:          RAPIDJSON_PARSE_ERROR(kParseErrorArrayMissCommaOrSquareBracket, is.Tell());
        default:                                    RAPIDJSON_PARSE_ERROR(kParseErrorUnspecificSyntaxError, is.Tell());
        }       
    }

    template <unsigned parseFlags, typename InputStream, typename Handler>
    ParseResult IterativeParse(InputStream& is, Handler& handler) {
        parseResult_.Clear();
        ClearStackOnExit scope(*this);
        IterativeParsingState state = IterativeParsingStartState;

        SkipWhitespace(is);
        while (is.Peek() != '\0') {
            Token t = Tokenize(is.Peek());
            IterativeParsingState n = Predict(state, t);
            IterativeParsingState d = Transit<parseFlags>(state, t, n, is, handler);

            if (d == IterativeParsingErrorState) {
                HandleError(state, is);
                break;
            }

            state = d;

            // Do not further consume streams if a root JSON has been parsed.
            if ((parseFlags & kParseStopWhenDoneFlag) && state == IterativeParsingFinishState)
                break;

            SkipWhitespace(is);
        }

        // Handle the end of file.
        if (state != IterativeParsingFinishState)
            HandleError(state, is);

        return parseResult_;
    }

    static const size_t kDefaultStackCapacity = 256;    //!< Default stack capacity in bytes for storing a single decoded string.
    internal::Stack<StackAllocator> stack_;  //!< A stack for storing decoded string temporarily during non-destructive parsing.
    ParseResult parseResult_;
}; // class GenericReader

//! Reader with UTF8 encoding and default allocator.
typedef GenericReader<UTF8<>, UTF8<> > Reader;

} // namespace rapidjson

#ifdef _MSC_VER
RAPIDJSON_DIAG_POP
#endif

#endif // RAPIDJSON_READER_H_

//==============================================================================
// document.h
//==============================================================================

// Copyright (C) 2011 Milo Yip
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#ifndef RAPIDJSON_DOCUMENT_H_
#define RAPIDJSON_DOCUMENT_H_

/*! \file document.h */

#include <new>      // placement new

#ifdef _MSC_VER
RAPIDJSON_DIAG_PUSH
RAPIDJSON_DIAG_OFF(4127) // conditional expression is constant
#elif defined(__GNUC__)
RAPIDJSON_DIAG_PUSH
RAPIDJSON_DIAG_OFF(effc++)
#endif

///////////////////////////////////////////////////////////////////////////////
// RAPIDJSON_HAS_STDSTRING

#ifdef RAPIDJSON_DOXYGEN_RUNNING
#define RAPIDJSON_HAS_STDSTRING 1 // force generation of documentation
#endif
#ifdef RAPIDJSON_HAS_STDSTRING
/*! \def RAPIDJSON_HAS_STDSTRING
    \ingroup RAPIDJSON_CONFIG
    \brief Enable RapidJSON support for \c std::string

    By defining this preprocessor symbol, several convenience functions for using
    \ref rapidjson::GenericValue with \c std::string are enabled, especially
    for construction and comparison.

    \hideinitializer
*/
#include <string>
#endif // RAPIDJSON_HAS_STDSTRING

#ifndef RAPIDJSON_NOMEMBERITERATORCLASS
#include <iterator> // std::iterator, std::random_access_iterator_tag
#endif

namespace rapidjson {

// Forward declaration.
template <typename Encoding, typename Allocator>
class GenericValue;

//! Name-value pair in a JSON object value.
/*!
    This class was internal to GenericValue. It used to be a inner struct.
    But a compiler (IBM XL C/C++ for AIX) have reported to have problem with that so it moved as a namespace scope struct.
    https://code.google.com/p/rapidjson/issues/detail?id=64
*/
template <typename Encoding, typename Allocator> 
struct GenericMember { 
    GenericValue<Encoding, Allocator> name;     //!< name of member (must be a string)
    GenericValue<Encoding, Allocator> value;    //!< value of member.
};

///////////////////////////////////////////////////////////////////////////////
// GenericMemberIterator

#ifndef RAPIDJSON_NOMEMBERITERATORCLASS

//! (Constant) member iterator for a JSON object value
/*!
    \tparam Const Is this a constant iterator?
    \tparam Encoding    Encoding of the value. (Even non-string values need to have the same encoding in a document)
    \tparam Allocator   Allocator type for allocating memory of object, array and string.

    This class implements a Random Access Iterator for GenericMember elements
    of a GenericValue, see ISO/IEC 14882:2003(E) C++ standard, 24.1 [lib.iterator.requirements].

    \note This iterator implementation is mainly intended to avoid implicit
        conversions from iterator values to \c NULL,
        e.g. from GenericValue::FindMember.

    \note Define \c RAPIDJSON_NOMEMBERITERATORCLASS to fall back to a
        pointer-based implementation, if your platform doesn't provide
        the C++ <iterator> header.

    \see GenericMember, GenericValue::MemberIterator, GenericValue::ConstMemberIterator
 */
template <bool Const, typename Encoding, typename Allocator>
class GenericMemberIterator
    : public std::iterator<std::random_access_iterator_tag
        , typename internal::MaybeAddConst<Const,GenericMember<Encoding,Allocator> >::Type> {

    friend class GenericValue<Encoding,Allocator>;
    template <bool, typename, typename> friend class GenericMemberIterator;

    typedef GenericMember<Encoding,Allocator> PlainType;
    typedef typename internal::MaybeAddConst<Const,PlainType>::Type ValueType;
    typedef std::iterator<std::random_access_iterator_tag,ValueType> BaseType;

public:
    //! Iterator type itself
    typedef GenericMemberIterator Iterator;
    //! Constant iterator type
    typedef GenericMemberIterator<true,Encoding,Allocator>  ConstIterator;
    //! Non-constant iterator type
    typedef GenericMemberIterator<false,Encoding,Allocator> NonConstIterator;

    //! Pointer to (const) GenericMember
    typedef typename BaseType::pointer         Pointer;
    //! Reference to (const) GenericMember
    typedef typename BaseType::reference       Reference;
    //! Signed integer type (e.g. \c ptrdiff_t)
    typedef typename BaseType::difference_type DifferenceType;

    //! Default constructor (singular value)
    /*! Creates an iterator pointing to no element.
        \note All operations, except for comparisons, are undefined on such values.
     */
    GenericMemberIterator() : ptr_() {}

    //! Iterator conversions to more const
    /*!
        \param it (Non-const) iterator to copy from

        Allows the creation of an iterator from another GenericMemberIterator
        that is "less const".  Especially, creating a non-constant iterator
        from a constant iterator are disabled:
        \li const -> non-const (not ok)
        \li const -> const (ok)
        \li non-const -> const (ok)
        \li non-const -> non-const (ok)

        \note If the \c Const template parameter is already \c false, this
            constructor effectively defines a regular copy-constructor.
            Otherwise, the copy constructor is implicitly defined.
    */
    GenericMemberIterator(const NonConstIterator & it) : ptr_(it.ptr_) {}

    //! @name stepping
    //@{
    Iterator& operator++(){ ++ptr_; return *this; }
    Iterator& operator--(){ --ptr_; return *this; }
    Iterator  operator++(int){ Iterator old(*this); ++ptr_; return old; }
    Iterator  operator--(int){ Iterator old(*this); --ptr_; return old; }
    //@}

    //! @name increment/decrement
    //@{
    Iterator operator+(DifferenceType n) const { return Iterator(ptr_+n); }
    Iterator operator-(DifferenceType n) const { return Iterator(ptr_-n); }

    Iterator& operator+=(DifferenceType n) { ptr_+=n; return *this; }
    Iterator& operator-=(DifferenceType n) { ptr_-=n; return *this; }
    //@}

    //! @name relations
    //@{
    bool operator==(ConstIterator that) const { return ptr_ == that.ptr_; }
    bool operator!=(ConstIterator that) const { return ptr_ != that.ptr_; }
    bool operator<=(ConstIterator that) const { return ptr_ <= that.ptr_; }
    bool operator>=(ConstIterator that) const { return ptr_ >= that.ptr_; }
    bool operator< (ConstIterator that) const { return ptr_ < that.ptr_; }
    bool operator> (ConstIterator that) const { return ptr_ > that.ptr_; }
    //@}

    //! @name dereference
    //@{
    Reference operator*() const { return *ptr_; }
    Pointer   operator->() const { return ptr_; }
    Reference operator[](DifferenceType n) const { return ptr_[n]; }
    //@}

    //! Distance
    DifferenceType operator-(ConstIterator that) const { return ptr_-that.ptr_; }

private:
    //! Internal constructor from plain pointer
    explicit GenericMemberIterator(Pointer p) : ptr_(p) {}

    Pointer ptr_; //!< raw pointer
};

#else // RAPIDJSON_NOMEMBERITERATORCLASS

// class-based member iterator implementation disabled, use plain pointers

template <bool Const, typename Encoding, typename Allocator>
struct GenericMemberIterator;

//! non-const GenericMemberIterator
template <typename Encoding, typename Allocator>
struct GenericMemberIterator<false,Encoding,Allocator> {
    //! use plain pointer as iterator type
    typedef GenericMember<Encoding,Allocator>* Iterator;
};
//! const GenericMemberIterator
template <typename Encoding, typename Allocator>
struct GenericMemberIterator<true,Encoding,Allocator> {
    //! use plain const pointer as iterator type
    typedef const GenericMember<Encoding,Allocator>* Iterator;
};

#endif // RAPIDJSON_NOMEMBERITERATORCLASS

///////////////////////////////////////////////////////////////////////////////
// GenericStringRef

//! Reference to a constant string (not taking a copy)
/*!
    \tparam CharType character type of the string

    This helper class is used to automatically infer constant string
    references for string literals, especially from \c const \b (!)
    character arrays.

    The main use is for creating JSON string values without copying the
    source string via an \ref Allocator.  This requires that the referenced
    string pointers have a sufficient lifetime, which exceeds the lifetime
    of the associated GenericValue.

    \b Example
    \code
    Value v("foo");   // ok, no need to copy & calculate length
    const char foo[] = "foo";
    v.SetString(foo); // ok

    const char* bar = foo;
    // Value x(bar); // not ok, can't rely on bar's lifetime
    Value x(StringRef(bar)); // lifetime explicitly guaranteed by user
    Value y(StringRef(bar, 3));  // ok, explicitly pass length
    \endcode

    \see StringRef, GenericValue::SetString
*/
template<typename CharType>
struct GenericStringRef {
    typedef CharType Ch; //!< character type of the string

    //! Create string reference from \c const character array
    /*!
        This constructor implicitly creates a constant string reference from
        a \c const character array.  It has better performance than
        \ref StringRef(const CharType*) by inferring the string \ref length
        from the array length, and also supports strings containing null
        characters.

        \tparam N length of the string, automatically inferred

        \param str Constant character array, lifetime assumed to be longer
            than the use of the string in e.g. a GenericValue

        \post \ref s == str

        \note Constant complexity.
        \note There is a hidden, private overload to disallow references to
            non-const character arrays to be created via this constructor.
            By this, e.g. function-scope arrays used to be filled via
            \c snprintf are excluded from consideration.
            In such cases, the referenced string should be \b copied to the
            GenericValue instead.
     */
    template<SizeType N>
    GenericStringRef(const CharType (&str)[N])
        : s(str), length(N-1) {}

    //! Explicitly create string reference from \c const character pointer
    /*!
        This constructor can be used to \b explicitly  create a reference to
        a constant string pointer.

        \see StringRef(const CharType*)

        \param str Constant character pointer, lifetime assumed to be longer
            than the use of the string in e.g. a GenericValue

        \post \ref s == str

        \note There is a hidden, private overload to disallow references to
            non-const character arrays to be created via this constructor.
            By this, e.g. function-scope arrays used to be filled via
            \c snprintf are excluded from consideration.
            In such cases, the referenced string should be \b copied to the
            GenericValue instead.
     */
    explicit GenericStringRef(const CharType* str)
        : s(str), length(internal::StrLen(str)){}

    //! Create constant string reference from pointer and length
    /*! \param str constant string, lifetime assumed to be longer than the use of the string in e.g. a GenericValue
        \param len length of the string, excluding the trailing NULL terminator

        \post \ref s == str && \ref length == len
        \note Constant complexity.
     */
    GenericStringRef(const CharType* str, SizeType len)
        : s(str), length(len) { RAPIDJSON_ASSERT(s != NULL); }

    //! implicit conversion to plain CharType pointer
    operator const Ch *() const { return s; }

    const Ch* const s; //!< plain CharType pointer
    const SizeType length; //!< length of the string (excluding the trailing NULL terminator)

private:
    //! Disallow copy-assignment
    GenericStringRef operator=(const GenericStringRef&);
    //! Disallow construction from non-const array
    template<SizeType N>
    GenericStringRef(CharType (&str)[N]) /* = delete */;
};

//! Mark a character pointer as constant string
/*! Mark a plain character pointer as a "string literal".  This function
    can be used to avoid copying a character string to be referenced as a
    value in a JSON GenericValue object, if the string's lifetime is known
    to be valid long enough.
    \tparam CharType Character type of the string
    \param str Constant string, lifetime assumed to be longer than the use of the string in e.g. a GenericValue
    \return GenericStringRef string reference object
    \relatesalso GenericStringRef

    \see GenericValue::GenericValue(StringRefType), GenericValue::operator=(StringRefType), GenericValue::SetString(StringRefType), GenericValue::PushBack(StringRefType, Allocator&), GenericValue::AddMember
*/
template<typename CharType>
inline GenericStringRef<CharType> StringRef(const CharType* str) {
    return GenericStringRef<CharType>(str, internal::StrLen(str));
}

//! Mark a character pointer as constant string
/*! Mark a plain character pointer as a "string literal".  This function
    can be used to avoid copying a character string to be referenced as a
    value in a JSON GenericValue object, if the string's lifetime is known
    to be valid long enough.

    This version has better performance with supplied length, and also
    supports string containing null characters.

    \tparam CharType character type of the string
    \param str Constant string, lifetime assumed to be longer than the use of the string in e.g. a GenericValue
    \param length The length of source string.
    \return GenericStringRef string reference object
    \relatesalso GenericStringRef
*/
template<typename CharType>
inline GenericStringRef<CharType> StringRef(const CharType* str, size_t length) {
    return GenericStringRef<CharType>(str, SizeType(length));
}

#ifdef RAPIDJSON_HAS_STDSTRING
//! Mark a string object as constant string
/*! Mark a string object (e.g. \c std::string) as a "string literal".
    This function can be used to avoid copying a string to be referenced as a
    value in a JSON GenericValue object, if the string's lifetime is known
    to be valid long enough.

    \tparam CharType character type of the string
    \param str Constant string, lifetime assumed to be longer than the use of the string in e.g. a GenericValue
    \return GenericStringRef string reference object
    \relatesalso GenericStringRef
    \note Requires the definition of the preprocessor symbol \ref RAPIDJSON_HAS_STDSTRING.
*/
template<typename CharType>
inline GenericStringRef<CharType> StringRef(const std::basic_string<CharType>& str) {
    return GenericStringRef<CharType>(str.data(), SizeType(str.size()));
}
#endif

///////////////////////////////////////////////////////////////////////////////
// GenericValue

//! Represents a JSON value. Use Value for UTF8 encoding and default allocator.
/*!
    A JSON value can be one of 7 types. This class is a variant type supporting
    these types.

    Use the Value if UTF8 and default allocator

    \tparam Encoding    Encoding of the value. (Even non-string values need to have the same encoding in a document)
    \tparam Allocator   Allocator type for allocating memory of object, array and string.
*/
#pragma pack (push, 4)
template <typename Encoding, typename Allocator = MemoryPoolAllocator<> > 
class GenericValue {
public:
    //! Name-value pair in an object.
    typedef GenericMember<Encoding, Allocator> Member;
    typedef Encoding EncodingType;                  //!< Encoding type from template parameter.
    typedef Allocator AllocatorType;                //!< Allocator type from template parameter.
    typedef typename Encoding::Ch Ch;               //!< Character type derived from Encoding.
    typedef GenericStringRef<Ch> StringRefType;     //!< Reference to a constant string
    typedef typename GenericMemberIterator<false,Encoding,Allocator>::Iterator MemberIterator;  //!< Member iterator for iterating in object.
    typedef typename GenericMemberIterator<true,Encoding,Allocator>::Iterator ConstMemberIterator;  //!< Constant member iterator for iterating in object.
    typedef GenericValue* ValueIterator;            //!< Value iterator for iterating in array.
    typedef const GenericValue* ConstValueIterator; //!< Constant value iterator for iterating in array.

    //!@name Constructors and destructor.
    //@{

    //! Default constructor creates a null value.
    GenericValue() : data_(), flags_(kNullFlag) {}

private:
    //! Copy constructor is not permitted.
    GenericValue(const GenericValue& rhs);

public:

    //! Constructor with JSON value type.
    /*! This creates a Value of specified type with default content.
        \param type Type of the value.
        \note Default content for number is zero.
    */
    GenericValue(Type type) : data_(), flags_() {
        static const unsigned defaultFlags[7] = {
            kNullFlag, kFalseFlag, kTrueFlag, kObjectFlag, kArrayFlag, kConstStringFlag,
            kNumberAnyFlag
        };
        RAPIDJSON_ASSERT(type <= kNumberType);
        flags_ = defaultFlags[type];
    }

    //! Explicit copy constructor (with allocator)
    /*! Creates a copy of a Value by using the given Allocator
        \tparam SourceAllocator allocator of \c rhs
        \param rhs Value to copy from (read-only)
        \param allocator Allocator for allocating copied elements and buffers. Commonly use GenericDocument::GetAllocator().
        \see CopyFrom()
    */
    template< typename SourceAllocator >
    GenericValue(const GenericValue<Encoding,SourceAllocator>& rhs, Allocator & allocator);

    //! Constructor for boolean value.
    /*! \param b Boolean value
        \note This constructor is limited to \em real boolean values and rejects
            implicitly converted types like arbitrary pointers.  Use an explicit cast
            to \c bool, if you want to construct a boolean JSON value in such cases.
     */
#ifndef RAPIDJSON_DOXYGEN_RUNNING // hide SFINAE from Doxygen
    template <typename T>
    explicit GenericValue(T b, RAPIDJSON_ENABLEIF((internal::IsSame<T,bool>)))
#else
    explicit GenericValue(bool b)
#endif
        : data_(), flags_(b ? kTrueFlag : kFalseFlag) {
            // safe-guard against failing SFINAE
            RAPIDJSON_STATIC_ASSERT((internal::IsSame<bool,T>::Value));
    }

    //! Constructor for int value.
    explicit GenericValue(int i) : data_(), flags_(kNumberIntFlag) {
        data_.n.i64 = i;
        if (i >= 0)
            flags_ |= kUintFlag | kUint64Flag;
    }

    //! Constructor for unsigned value.
    explicit GenericValue(unsigned u) : data_(), flags_(kNumberUintFlag) {
        data_.n.u64 = u; 
        if (!(u & 0x80000000))
            flags_ |= kIntFlag | kInt64Flag;
    }

    //! Constructor for int64_t value.
    explicit GenericValue(int64_t i64) : data_(), flags_(kNumberInt64Flag) {
        data_.n.i64 = i64;
        if (i64 >= 0) {
            flags_ |= kNumberUint64Flag;
            if (!(static_cast<uint64_t>(i64) & RAPIDJSON_UINT64_C2(0xFFFFFFFF, 0x00000000)))
                flags_ |= kUintFlag;
            if (!(static_cast<uint64_t>(i64) & RAPIDJSON_UINT64_C2(0xFFFFFFFF, 0x80000000)))
                flags_ |= kIntFlag;
        }
        else if (i64 >= static_cast<int64_t>(RAPIDJSON_UINT64_C2(0xFFFFFFFF, 0x80000000)))
            flags_ |= kIntFlag;
    }

    //! Constructor for uint64_t value.
    explicit GenericValue(uint64_t u64) : data_(), flags_(kNumberUint64Flag) {
        data_.n.u64 = u64;
        if (!(u64 & RAPIDJSON_UINT64_C2(0x80000000, 0x00000000)))
            flags_ |= kInt64Flag;
        if (!(u64 & RAPIDJSON_UINT64_C2(0xFFFFFFFF, 0x00000000)))
            flags_ |= kUintFlag;
        if (!(u64 & RAPIDJSON_UINT64_C2(0xFFFFFFFF, 0x80000000)))
            flags_ |= kIntFlag;
    }

    //! Constructor for double value.
    explicit GenericValue(double d) : data_(), flags_(kNumberDoubleFlag) { data_.n.d = d; }

    //! Constructor for constant string (i.e. do not make a copy of string)
    GenericValue(const Ch* s, SizeType length) : data_(), flags_() { SetStringRaw(StringRef(s, length)); }

    //! Constructor for constant string (i.e. do not make a copy of string)
    explicit GenericValue(StringRefType s) : data_(), flags_() { SetStringRaw(s); }

    //! Constructor for copy-string (i.e. do make a copy of string)
    GenericValue(const Ch* s, SizeType length, Allocator& allocator) : data_(), flags_() { SetStringRaw(StringRef(s, length), allocator); }

    //! Constructor for copy-string (i.e. do make a copy of string)
    GenericValue(const Ch*s, Allocator& allocator) : data_(), flags_() { SetStringRaw(StringRef(s), allocator); }

#ifdef RAPIDJSON_HAS_STDSTRING
    //! Constructor for copy-string from a string object (i.e. do make a copy of string)
    /*! \note Requires the definition of the preprocessor symbol \ref RAPIDJSON_HAS_STDSTRING.
     */
    GenericValue(const std::basic_string<Ch>& s, Allocator& allocator) : data_(), flags_() { SetStringRaw(StringRef(s), allocator); }
#endif

    //! Destructor.
    /*! Need to destruct elements of array, members of object, or copy-string.
    */
    ~GenericValue() {
        if (Allocator::kNeedFree) { // Shortcut by Allocator's trait
            switch(flags_) {
            case kArrayFlag:
                for (GenericValue* v = data_.a.elements; v != data_.a.elements + data_.a.size; ++v)
                    v->~GenericValue();
                Allocator::Free(data_.a.elements);
                break;

            case kObjectFlag:
                for (MemberIterator m = MemberBegin(); m != MemberEnd(); ++m)
                    m->~Member();
                Allocator::Free(data_.o.members);
                break;

            case kCopyStringFlag:
                Allocator::Free(const_cast<Ch*>(data_.s.str));
                break;

            default:
                break;  // Do nothing for other types.
            }
        }
    }

    //@}

    //!@name Assignment operators
    //@{

    //! Assignment with move semantics.
    /*! \param rhs Source of the assignment. It will become a null value after assignment.
    */
    GenericValue& operator=(GenericValue& rhs) {
        RAPIDJSON_ASSERT(this != &rhs);
        this->~GenericValue();
        RawAssign(rhs);
        return *this;
    }

    //! Assignment of constant string reference (no copy)
    /*! \param str Constant string reference to be assigned
        \note This overload is needed to avoid clashes with the generic primitive type assignment overload below.
        \see GenericStringRef, operator=(T)
    */
    GenericValue& operator=(StringRefType str) {
        GenericValue s(str);
        return *this = s;
    }

    //! Assignment with primitive types.
    /*! \tparam T Either \ref Type, \c int, \c unsigned, \c int64_t, \c uint64_t
        \param value The value to be assigned.

        \note The source type \c T explicitly disallows all pointer types,
            especially (\c const) \ref Ch*.  This helps avoiding implicitly
            referencing character strings with insufficient lifetime, use
            \ref SetString(const Ch*, Allocator&) (for copying) or
            \ref StringRef() (to explicitly mark the pointer as constant) instead.
            All other pointer types would implicitly convert to \c bool,
            use \ref SetBool() instead.
    */
    template <typename T>
    RAPIDJSON_DISABLEIF_RETURN((internal::IsPointer<T>), (GenericValue&))
    operator=(T value) {
        GenericValue v(value);
        return *this = v;
    }

    //! Deep-copy assignment from Value
    /*! Assigns a \b copy of the Value to the current Value object
        \tparam SourceAllocator Allocator type of \c rhs
        \param rhs Value to copy from (read-only)
        \param allocator Allocator to use for copying
     */
    template <typename SourceAllocator>
    GenericValue& CopyFrom(const GenericValue<Encoding,SourceAllocator>& rhs, Allocator& allocator) {
        RAPIDJSON_ASSERT((void*)this != (void const*)&rhs);
        this->~GenericValue();
        new (this) GenericValue(rhs,allocator);
        return *this;
    }

    //! Exchange the contents of this value with those of other.
    /*!
        \param other Another value.
        \note Constant complexity.
    */
    GenericValue& Swap(GenericValue& other) {
        GenericValue temp;
        temp.RawAssign(*this);
        RawAssign(other);
        other.RawAssign(temp);
        return *this;
    }

    //! Prepare Value for move semantics
    /*! \return *this */
    GenericValue& Move() { return *this; }
    //@}

    //!@name Equal-to and not-equal-to operators
    //@{
    //! Equal-to operator
    /*!
        \note If an object contains duplicated named member, comparing equality with any object is always \c false.
        \note Linear time complexity (number of all values in the subtree and total lengths of all strings).
    */
    bool operator==(const GenericValue& rhs) const {
        if (GetType() != rhs.GetType())
            return false;

        switch (GetType()) {
        case kObjectType: // Warning: O(n^2) inner-loop
            if (data_.o.size != rhs.data_.o.size)
                return false;           
            for (ConstMemberIterator lhsMemberItr = MemberBegin(); lhsMemberItr != MemberEnd(); ++lhsMemberItr) {
                ConstMemberIterator rhsMemberItr = rhs.FindMember(lhsMemberItr->name);
                if (rhsMemberItr == rhs.MemberEnd() || lhsMemberItr->value != rhsMemberItr->value)
                    return false;
            }
            return true;
            
        case kArrayType:
            if (data_.a.size != rhs.data_.a.size)
                return false;
            for (SizeType i = 0; i < data_.a.size; i++)
                if ((*this)[i] != rhs[i])
                    return false;
            return true;

        case kStringType:
            return StringEqual(rhs);

        case kNumberType:
            if (IsDouble() || rhs.IsDouble())
                return GetDouble() == rhs.GetDouble(); // May convert one operand from integer to double.
            else
                return data_.n.u64 == rhs.data_.n.u64;

        default: // kTrueType, kFalseType, kNullType
            return true;
        }
    }

    //! Equal-to operator with const C-string pointer
    bool operator==(const Ch* rhs) const { return *this == GenericValue(StringRef(rhs)); }

#ifdef RAPIDJSON_HAS_STDSTRING
    //! Equal-to operator with string object
    /*! \note Requires the definition of the preprocessor symbol \ref RAPIDJSON_HAS_STDSTRING.
     */
    bool operator==(const std::basic_string<Ch>& rhs) const { return *this == GenericValue(StringRef(rhs)); }
#endif

    //! Equal-to operator with primitive types
    /*! \tparam T Either \ref Type, \c int, \c unsigned, \c int64_t, \c uint64_t, \c double, \c true, \c false
    */
    template <typename T> RAPIDJSON_DISABLEIF_RETURN((internal::OrExpr<internal::IsPointer<T>,internal::IsBaseOf<GenericValue,T> >), (bool)) operator==(const T& rhs) const { return *this == GenericValue(rhs); }

    //! Not-equal-to operator
    /*! \return !(*this == rhs)
     */
    bool operator!=(const GenericValue& rhs) const { return !(*this == rhs); }

    //! Not-equal-to operator with arbitrary types
    /*! \return !(*this == rhs)
     */
    template <typename T> RAPIDJSON_DISABLEIF_RETURN((internal::IsBaseOf<GenericValue,T>), (bool)) operator!=(const T& rhs) const { return !(*this == rhs); }

    //! Equal-to operator with arbitrary types (symmetric version)
    /*! \return (rhs == lhs)
     */
    template <typename T> friend RAPIDJSON_DISABLEIF_RETURN((internal::IsBaseOf<GenericValue,T>), (bool)) operator==(const T& lhs, const GenericValue& rhs) { return rhs == lhs; }

    //! Not-Equal-to operator with arbitrary types (symmetric version)
    /*! \return !(rhs == lhs)
     */
    template <typename T> friend RAPIDJSON_DISABLEIF_RETURN((internal::IsBaseOf<GenericValue,T>), (bool)) operator!=(const T& lhs, const GenericValue& rhs) { return !(rhs == lhs); }
    //@}

    //!@name Type
    //@{

    Type GetType()  const { return static_cast<Type>(flags_ & kTypeMask); }
    bool IsNull()   const { return flags_ == kNullFlag; }
    bool IsFalse()  const { return flags_ == kFalseFlag; }
    bool IsTrue()   const { return flags_ == kTrueFlag; }
    bool IsBool()   const { return (flags_ & kBoolFlag) != 0; }
    bool IsObject() const { return flags_ == kObjectFlag; }
    bool IsArray()  const { return flags_ == kArrayFlag; }
    bool IsNumber() const { return (flags_ & kNumberFlag) != 0; }
    bool IsInt()    const { return (flags_ & kIntFlag) != 0; }
    bool IsUint()   const { return (flags_ & kUintFlag) != 0; }
    bool IsInt64()  const { return (flags_ & kInt64Flag) != 0; }
    bool IsUint64() const { return (flags_ & kUint64Flag) != 0; }
    bool IsDouble() const { return (flags_ & kDoubleFlag) != 0; }
    bool IsString() const { return (flags_ & kStringFlag) != 0; }

    //@}

    //!@name Null
    //@{

    GenericValue& SetNull() { this->~GenericValue(); new (this) GenericValue(); return *this; }

    //@}

    //!@name Bool
    //@{

    bool GetBool() const { RAPIDJSON_ASSERT(IsBool()); return flags_ == kTrueFlag; }
    //!< Set boolean value
    /*! \post IsBool() == true */
    GenericValue& SetBool(bool b) { this->~GenericValue(); new (this) GenericValue(b); return *this; }

    //@}

    //!@name Object
    //@{

    //! Set this value as an empty object.
    /*! \post IsObject() == true */
    GenericValue& SetObject() { this->~GenericValue(); new (this) GenericValue(kObjectType); return *this; }

    //! Get the number of members in the object.
    SizeType MemberCount() const { RAPIDJSON_ASSERT(IsObject()); return data_.o.size; }

    //! Check whether the object is empty.
    bool ObjectEmpty() const { RAPIDJSON_ASSERT(IsObject()); return data_.o.size == 0; }

    //! Get the value associated with the name.
    /*!
        \note In version 0.1x, if the member is not found, this function returns a null value. This makes issue 7.
        Since 0.2, if the name is not correct, it will assert.
        If user is unsure whether a member exists, user should use HasMember() first.
        A better approach is to use FindMember().
        \note Linear time complexity.
    */
    GenericValue& operator[](const Ch* name) {
        GenericValue n(StringRef(name));
        return (*this)[n];
    }
    const GenericValue& operator[](const Ch* name) const { return const_cast<GenericValue&>(*this)[name]; }

    // This version is faster because it does not need a StrLen(). 
    // It can also handle string with null character.
    GenericValue& operator[](const GenericValue& name) {
        MemberIterator member = FindMember(name);
        if (member != MemberEnd())
            return member->value;
        else {
            RAPIDJSON_ASSERT(false);    // see above note
            static GenericValue NullValue;
            return NullValue;
        }
    }
    const GenericValue& operator[](const GenericValue& name) const { return const_cast<GenericValue&>(*this)[name]; }

    //! Const member iterator
    /*! \pre IsObject() == true */
    ConstMemberIterator MemberBegin() const { RAPIDJSON_ASSERT(IsObject()); return ConstMemberIterator(data_.o.members); }
    //! Const \em past-the-end member iterator
    /*! \pre IsObject() == true */
    ConstMemberIterator MemberEnd() const   { RAPIDJSON_ASSERT(IsObject()); return ConstMemberIterator(data_.o.members + data_.o.size); }
    //! Member iterator
    /*! \pre IsObject() == true */
    MemberIterator MemberBegin()            { RAPIDJSON_ASSERT(IsObject()); return MemberIterator(data_.o.members); }
    //! \em Past-the-end member iterator
    /*! \pre IsObject() == true */
    MemberIterator MemberEnd()              { RAPIDJSON_ASSERT(IsObject()); return MemberIterator(data_.o.members + data_.o.size); }

    //! Check whether a member exists in the object.
    /*!
        \param name Member name to be searched.
        \pre IsObject() == true
        \return Whether a member with that name exists.
        \note It is better to use FindMember() directly if you need the obtain the value as well.
        \note Linear time complexity.
    */
    bool HasMember(const Ch* name) const { return FindMember(name) != MemberEnd(); }

    //! Check whether a member exists in the object with GenericValue name.
    /*!
        This version is faster because it does not need a StrLen(). It can also handle string with null character.
        \param name Member name to be searched.
        \pre IsObject() == true
        \return Whether a member with that name exists.
        \note It is better to use FindMember() directly if you need the obtain the value as well.
        \note Linear time complexity.
    */
    bool HasMember(const GenericValue& name) const { return FindMember(name) != MemberEnd(); }

    //! Find member by name.
    /*!
        \param name Member name to be searched.
        \pre IsObject() == true
        \return Iterator to member, if it exists.
            Otherwise returns \ref MemberEnd().

        \note Earlier versions of Rapidjson returned a \c NULL pointer, in case
            the requested member doesn't exist. For consistency with e.g.
            \c std::map, this has been changed to MemberEnd() now.
        \note Linear time complexity.
    */
    MemberIterator FindMember(const Ch* name) {
        GenericValue n(StringRef(name));
        return FindMember(n);
    }

    ConstMemberIterator FindMember(const Ch* name) const { return const_cast<GenericValue&>(*this).FindMember(name); }

    //! Find member by name.
    /*!
        This version is faster because it does not need a StrLen(). It can also handle string with null character.
        \param name Member name to be searched.
        \pre IsObject() == true
        \return Iterator to member, if it exists.
            Otherwise returns \ref MemberEnd().

        \note Earlier versions of Rapidjson returned a \c NULL pointer, in case
            the requested member doesn't exist. For consistency with e.g.
            \c std::map, this has been changed to MemberEnd() now.
        \note Linear time complexity.
    */
    MemberIterator FindMember(const GenericValue& name) {
        RAPIDJSON_ASSERT(IsObject());
        RAPIDJSON_ASSERT(name.IsString());
        MemberIterator member = MemberBegin();
        for ( ; member != MemberEnd(); ++member)
            if (name.StringEqual(member->name))
                break;
        return member;
    }
    ConstMemberIterator FindMember(const GenericValue& name) const { return const_cast<GenericValue&>(*this).FindMember(name); }

    //! Add a member (name-value pair) to the object.
    /*! \param name A string value as name of member.
        \param value Value of any type.
        \param allocator    Allocator for reallocating memory. It must be the same one as used before. Commonly use GenericDocument::GetAllocator().
        \return The value itself for fluent API.
        \note The ownership of \c name and \c value will be transferred to this object on success.
        \pre  IsObject() && name.IsString()
        \post name.IsNull() && value.IsNull()
        \note Amortized Constant time complexity.
    */
    GenericValue& AddMember(GenericValue& name, GenericValue& value, Allocator& allocator) {
        RAPIDJSON_ASSERT(IsObject());
        RAPIDJSON_ASSERT(name.IsString());

        Object& o = data_.o;
        if (o.size >= o.capacity) {
            if (o.capacity == 0) {
                o.capacity = kDefaultObjectCapacity;
                o.members = reinterpret_cast<Member*>(allocator.Malloc(o.capacity * sizeof(Member)));
            }
            else {
                SizeType oldCapacity = o.capacity;
                o.capacity *= 2;
                o.members = reinterpret_cast<Member*>(allocator.Realloc(o.members, oldCapacity * sizeof(Member), o.capacity * sizeof(Member)));
            }
        }
        o.members[o.size].name.RawAssign(name);
        o.members[o.size].value.RawAssign(value);
        o.size++;
        return *this;
    }

    //! Add a member (name-value pair) to the object.
    /*! \param name A constant string reference as name of member.
        \param value Value of any type.
        \param allocator    Allocator for reallocating memory. It must be the same one as used before. Commonly use GenericDocument::GetAllocator().
        \return The value itself for fluent API.
        \note The ownership of \c value will be transferred to this object on success.
        \pre  IsObject()
        \post value.IsNull()
        \note Amortized Constant time complexity.
    */
    GenericValue& AddMember(StringRefType name, GenericValue& value, Allocator& allocator) {
        GenericValue n(name);
        return AddMember(n, value, allocator);
    }

    //! Add a constant string value as member (name-value pair) to the object.
    /*! \param name A constant string reference as name of member.
        \param value constant string reference as value of member.
        \param allocator    Allocator for reallocating memory. It must be the same one as used before. Commonly use GenericDocument::GetAllocator().
        \return The value itself for fluent API.
        \pre  IsObject()
        \note This overload is needed to avoid clashes with the generic primitive type AddMember(StringRefType,T,Allocator&) overload below.
        \note Amortized Constant time complexity.
    */
    GenericValue& AddMember(StringRefType name, StringRefType value, Allocator& allocator) {
        GenericValue v(value);
        return AddMember(name, v, allocator);
    }

    //! Add any primitive value as member (name-value pair) to the object.
    /*! \tparam T Either \ref Type, \c int, \c unsigned, \c int64_t, \c uint64_t
        \param name A constant string reference as name of member.
        \param value Value of primitive type \c T as value of member
        \param allocator Allocator for reallocating memory. Commonly use GenericDocument::GetAllocator().
        \return The value itself for fluent API.
        \pre  IsObject()

        \note The source type \c T explicitly disallows all pointer types,
            especially (\c const) \ref Ch*.  This helps avoiding implicitly
            referencing character strings with insufficient lifetime, use
            \ref AddMember(StringRefType, GenericValue&, Allocator&) or \ref
            AddMember(StringRefType, StringRefType, Allocator&).
            All other pointer types would implicitly convert to \c bool,
            use an explicit cast instead, if needed.
        \note Amortized Constant time complexity.
    */
    template <typename T>
    RAPIDJSON_DISABLEIF_RETURN((internal::IsPointer<T>), (GenericValue&))
    AddMember(StringRefType name, T value, Allocator& allocator) {
        GenericValue n(name);
        GenericValue v(value);
        return AddMember(n, v, allocator);
    }

    //! Remove all members in the object.
    /*! This function do not deallocate memory in the object, i.e. the capacity is unchanged.
        \note Linear time complexity.
    */
    void RemoveAllMembers() {
        RAPIDJSON_ASSERT(IsObject()); 
        for (MemberIterator m = MemberBegin(); m != MemberEnd(); ++m)
            m->~Member();
        data_.o.size = 0;
    }

    //! Remove a member in object by its name.
    /*! \param name Name of member to be removed.
        \return Whether the member existed.
        \note Removing member is implemented by moving the last member. So the ordering of members is changed.
        \note Linear time complexity.
    */
    bool RemoveMember(const Ch* name) {
        GenericValue n(StringRef(name));
        return RemoveMember(n);
    }

    bool RemoveMember(const GenericValue& name) {
        MemberIterator m = FindMember(name);
        if (m != MemberEnd()) {
            RemoveMember(m);
            return true;
        }
        else
            return false;
    }

    //! Remove a member in object by iterator.
    /*! \param m member iterator (obtained by FindMember() or MemberBegin()).
        \return the new iterator after removal.
        \note Removing member is implemented by moving the last member. So the ordering of members is changed.
        \note Use \ref EraseMember(ConstMemberIterator) instead, if you need to rely on a stable member ordering.
        \note Constant time complexity.
    */
    MemberIterator RemoveMember(MemberIterator m) {
        RAPIDJSON_ASSERT(IsObject());
        RAPIDJSON_ASSERT(data_.o.size > 0);
        RAPIDJSON_ASSERT(data_.o.members != 0);
        RAPIDJSON_ASSERT(m >= MemberBegin() && m < MemberEnd());

        MemberIterator last(data_.o.members + (data_.o.size - 1));
        if (data_.o.size > 1 && m != last) {
            // Move the last one to this place
            *m = *last;
        }
        else {
            // Only one left, just destroy
            m->~Member();
        }
        --data_.o.size;
        return m;
    }

    //! Remove a member from an object by iterator.
    /*! \param pos iterator to the member to remove
        \pre IsObject() == true && \ref MemberBegin() <= \c pos < \ref MemberEnd()
        \return Iterator following the removed element.
            If the iterator \c pos refers to the last element, the \ref MemberEnd() iterator is returned.
        \note Other than \ref RemoveMember(MemberIterator), this function preserves the ordering of the members.
        \note Linear time complexity.
    */
    MemberIterator EraseMember(ConstMemberIterator pos) {
        return EraseMember(pos, pos +1);
    }

    //! Remove members in the range [first, last) from an object.
    /*! \param first iterator to the first member to remove
        \param last  iterator following the last member to remove
        \pre IsObject() == true && \ref MemberBegin() <= \c first <= \c last <= \ref MemberEnd()
        \return Iterator following the last removed element.
        \note Other than \ref RemoveMember(MemberIterator), this function preserves the ordering of the members.
        \note Linear time complexity.
    */
    MemberIterator EraseMember(ConstMemberIterator first, ConstMemberIterator last) {
        RAPIDJSON_ASSERT(IsObject());
        RAPIDJSON_ASSERT(data_.o.size > 0);
        RAPIDJSON_ASSERT(data_.o.members != 0);
        RAPIDJSON_ASSERT(first >= MemberBegin());
        RAPIDJSON_ASSERT(first <= last);
        RAPIDJSON_ASSERT(last <= MemberEnd());

        MemberIterator pos = MemberBegin() + (first - MemberBegin());
        for (MemberIterator itr = pos; itr != last; ++itr)
            itr->~Member();
        memmove(&*pos, &*last, (MemberEnd() - last) * sizeof(Member));
        data_.o.size -= (last - first);
        return pos;
    }

    //@}

    //!@name Array
    //@{

    //! Set this value as an empty array.
    /*! \post IsArray == true */
    GenericValue& SetArray() {  this->~GenericValue(); new (this) GenericValue(kArrayType); return *this; }

    //! Get the number of elements in array.
    SizeType Size() const { RAPIDJSON_ASSERT(IsArray()); return data_.a.size; }

    //! Get the capacity of array.
    SizeType Capacity() const { RAPIDJSON_ASSERT(IsArray()); return data_.a.capacity; }

    //! Check whether the array is empty.
    bool Empty() const { RAPIDJSON_ASSERT(IsArray()); return data_.a.size == 0; }

    //! Remove all elements in the array.
    /*! This function do not deallocate memory in the array, i.e. the capacity is unchanged.
        \note Linear time complexity.
    */
    void Clear() {
        RAPIDJSON_ASSERT(IsArray()); 
        for (SizeType i = 0; i < data_.a.size; ++i)
            data_.a.elements[i].~GenericValue();
        data_.a.size = 0;
    }

    //! Get an element from array by index.
    /*! \param index Zero-based index of element.
\code
Value a(kArrayType);
a.PushBack(123);
int x = a[0].GetInt();              // Error: operator[ is ambiguous, as 0 also mean a null pointer of const char* type.
int y = a[SizeType(0)].GetInt();    // Cast to SizeType will work.
int z = a[0u].GetInt();             // This works too.
\endcode
    */
    GenericValue& operator[](SizeType index) {
        RAPIDJSON_ASSERT(IsArray());
        RAPIDJSON_ASSERT(index < data_.a.size);
        return data_.a.elements[index];
    }
    const GenericValue& operator[](SizeType index) const { return const_cast<GenericValue&>(*this)[index]; }

    //! Element iterator
    /*! \pre IsArray() == true */
    ValueIterator Begin() { RAPIDJSON_ASSERT(IsArray()); return data_.a.elements; }
    //! \em Past-the-end element iterator
    /*! \pre IsArray() == true */
    ValueIterator End() { RAPIDJSON_ASSERT(IsArray()); return data_.a.elements + data_.a.size; }
    //! Constant element iterator
    /*! \pre IsArray() == true */
    ConstValueIterator Begin() const { return const_cast<GenericValue&>(*this).Begin(); }
    //! Constant \em past-the-end element iterator
    /*! \pre IsArray() == true */
    ConstValueIterator End() const { return const_cast<GenericValue&>(*this).End(); }

    //! Request the array to have enough capacity to store elements.
    /*! \param newCapacity  The capacity that the array at least need to have.
        \param allocator    Allocator for reallocating memory. It must be the same one as used before. Commonly use GenericDocument::GetAllocator().
        \return The value itself for fluent API.
        \note Linear time complexity.
    */
    GenericValue& Reserve(SizeType newCapacity, Allocator &allocator) {
        RAPIDJSON_ASSERT(IsArray());
        if (newCapacity > data_.a.capacity) {
            data_.a.elements = (GenericValue*)allocator.Realloc(data_.a.elements, data_.a.capacity * sizeof(GenericValue), newCapacity * sizeof(GenericValue));
            data_.a.capacity = newCapacity;
        }
        return *this;
    }

    //! Append a GenericValue at the end of the array.
    /*! \param value        Value to be appended.
        \param allocator    Allocator for reallocating memory. It must be the same one as used before. Commonly use GenericDocument::GetAllocator().
        \pre IsArray() == true
        \post value.IsNull() == true
        \return The value itself for fluent API.
        \note The ownership of \c value will be transferred to this array on success.
        \note If the number of elements to be appended is known, calls Reserve() once first may be more efficient.
        \note Amortized constant time complexity.
    */
    GenericValue& PushBack(GenericValue& value, Allocator& allocator) {
        RAPIDJSON_ASSERT(IsArray());
        if (data_.a.size >= data_.a.capacity)
            Reserve(data_.a.capacity == 0 ? kDefaultArrayCapacity : data_.a.capacity * 2, allocator);
        data_.a.elements[data_.a.size++].RawAssign(value);
        return *this;
    }

    //! Append a constant string reference at the end of the array.
    /*! \param value        Constant string reference to be appended.
        \param allocator    Allocator for reallocating memory. It must be the same one used previously. Commonly use GenericDocument::GetAllocator().
        \pre IsArray() == true
        \return The value itself for fluent API.
        \note If the number of elements to be appended is known, calls Reserve() once first may be more efficient.
        \note Amortized constant time complexity.
        \see GenericStringRef
    */
    GenericValue& PushBack(StringRefType value, Allocator& allocator) {
        return (*this).template PushBack<StringRefType>(value, allocator);
    }

    //! Append a primitive value at the end of the array.
    /*! \tparam T Either \ref Type, \c int, \c unsigned, \c int64_t, \c uint64_t
        \param value Value of primitive type T to be appended.
        \param allocator    Allocator for reallocating memory. It must be the same one as used before. Commonly use GenericDocument::GetAllocator().
        \pre IsArray() == true
        \return The value itself for fluent API.
        \note If the number of elements to be appended is known, calls Reserve() once first may be more efficient.

        \note The source type \c T explicitly disallows all pointer types,
            especially (\c const) \ref Ch*.  This helps avoiding implicitly
            referencing character strings with insufficient lifetime, use
            \ref PushBack(GenericValue&, Allocator&) or \ref
            PushBack(StringRefType, Allocator&).
            All other pointer types would implicitly convert to \c bool,
            use an explicit cast instead, if needed.
        \note Amortized constant time complexity.
    */
    template <typename T>
    RAPIDJSON_DISABLEIF_RETURN((internal::IsPointer<T>), (GenericValue&))
    PushBack(T value, Allocator& allocator) {
        GenericValue v(value);
        return PushBack(v, allocator);
    }

    //! Remove the last element in the array.
    /*!
        \note Constant time complexity.
    */
    GenericValue& PopBack() {
        RAPIDJSON_ASSERT(IsArray());
        RAPIDJSON_ASSERT(!Empty());
        data_.a.elements[--data_.a.size].~GenericValue();
        return *this;
    }

    //! Remove an element of array by iterator.
    /*!
        \param pos iterator to the element to remove
        \pre IsArray() == true && \ref Begin() <= \c pos < \ref End()
        \return Iterator following the removed element. If the iterator pos refers to the last element, the End() iterator is returned.
        \note Linear time complexity.
    */
    ValueIterator Erase(ConstValueIterator pos) {
        return Erase(pos, pos + 1);
    }

    //! Remove elements in the range [first, last) of the array.
    /*!
        \param first iterator to the first element to remove
        \param last  iterator following the last element to remove
        \pre IsArray() == true && \ref Begin() <= \c first <= \c last <= \ref End()
        \return Iterator following the last removed element.
        \note Linear time complexity.
    */
    ValueIterator Erase(ConstValueIterator first, ConstValueIterator last) {
        RAPIDJSON_ASSERT(IsArray());
        RAPIDJSON_ASSERT(data_.a.size > 0);
        RAPIDJSON_ASSERT(data_.a.elements != 0);
        RAPIDJSON_ASSERT(first >= Begin());
        RAPIDJSON_ASSERT(first <= last);
        RAPIDJSON_ASSERT(last <= End());
        ValueIterator pos = Begin() + (first - Begin());
        for (ValueIterator itr = pos; itr != last; ++itr)
            itr->~GenericValue();       
        memmove(pos, last, (End() - last) * sizeof(GenericValue));
        data_.a.size -= (last - first);
        return pos;
    }

    //@}

    //!@name Number
    //@{

    int GetInt() const          { RAPIDJSON_ASSERT(flags_ & kIntFlag);   return data_.n.i.i;   }
    unsigned GetUint() const    { RAPIDJSON_ASSERT(flags_ & kUintFlag);  return data_.n.u.u;   }
    int64_t GetInt64() const    { RAPIDJSON_ASSERT(flags_ & kInt64Flag); return data_.n.i64; }
    uint64_t GetUint64() const  { RAPIDJSON_ASSERT(flags_ & kUint64Flag); return data_.n.u64; }

    double GetDouble() const {
        RAPIDJSON_ASSERT(IsNumber());
        if ((flags_ & kDoubleFlag) != 0)                return data_.n.d;   // exact type, no conversion.
        if ((flags_ & kIntFlag) != 0)                   return data_.n.i.i; // int -> double
        if ((flags_ & kUintFlag) != 0)                  return data_.n.u.u; // unsigned -> double
        if ((flags_ & kInt64Flag) != 0)                 return (double)data_.n.i64; // int64_t -> double (may lose precision)
        RAPIDJSON_ASSERT((flags_ & kUint64Flag) != 0);  return (double)data_.n.u64; // uint64_t -> double (may lose precision)
    }

    GenericValue& SetInt(int i)             { this->~GenericValue(); new (this) GenericValue(i);    return *this; }
    GenericValue& SetUint(unsigned u)       { this->~GenericValue(); new (this) GenericValue(u);    return *this; }
    GenericValue& SetInt64(int64_t i64)     { this->~GenericValue(); new (this) GenericValue(i64);  return *this; }
    GenericValue& SetUint64(uint64_t u64)   { this->~GenericValue(); new (this) GenericValue(u64);  return *this; }
    GenericValue& SetDouble(double d)       { this->~GenericValue(); new (this) GenericValue(d);    return *this; }

    //@}

    //!@name String
    //@{

    const Ch* GetString() const { RAPIDJSON_ASSERT(IsString()); return data_.s.str; }

    //! Get the length of string.
    /*! Since rapidjson permits "\\u0000" in the json string, strlen(v.GetString()) may not equal to v.GetStringLength().
    */
    SizeType GetStringLength() const { RAPIDJSON_ASSERT(IsString()); return data_.s.length; }

    //! Set this value as a string without copying source string.
    /*! This version has better performance with supplied length, and also support string containing null character.
        \param s source string pointer. 
        \param length The length of source string, excluding the trailing null terminator.
        \return The value itself for fluent API.
        \post IsString() == true && GetString() == s && GetStringLength() == length
        \see SetString(StringRefType)
    */
    GenericValue& SetString(const Ch* s, SizeType length) { return SetString(StringRef(s, length)); }

    //! Set this value as a string without copying source string.
    /*! \param s source string reference
        \return The value itself for fluent API.
        \post IsString() == true && GetString() == s && GetStringLength() == s.length
    */
    GenericValue& SetString(StringRefType s) { this->~GenericValue(); SetStringRaw(s); return *this; }

    //! Set this value as a string by copying from source string.
    /*! This version has better performance with supplied length, and also support string containing null character.
        \param s source string. 
        \param length The length of source string, excluding the trailing null terminator.
        \param allocator Allocator for allocating copied buffer. Commonly use GenericDocument::GetAllocator().
        \return The value itself for fluent API.
        \post IsString() == true && GetString() != s && strcmp(GetString(),s) == 0 && GetStringLength() == length
    */
    GenericValue& SetString(const Ch* s, SizeType length, Allocator& allocator) { this->~GenericValue(); SetStringRaw(StringRef(s, length), allocator); return *this; }

    //! Set this value as a string by copying from source string.
    /*! \param s source string. 
        \param allocator Allocator for allocating copied buffer. Commonly use GenericDocument::GetAllocator().
        \return The value itself for fluent API.
        \post IsString() == true && GetString() != s && strcmp(GetString(),s) == 0 && GetStringLength() == length
    */
    GenericValue& SetString(const Ch* s, Allocator& allocator) { return SetString(s, internal::StrLen(s), allocator); }

#ifdef RAPIDJSON_HAS_STDSTRING
    //! Set this value as a string by copying from source string.
    /*! \param s source string.
        \param allocator Allocator for allocating copied buffer. Commonly use GenericDocument::GetAllocator().
        \return The value itself for fluent API.
        \post IsString() == true && GetString() != s.data() && strcmp(GetString(),s.data() == 0 && GetStringLength() == s.size()
        \note Requires the definition of the preprocessor symbol \ref RAPIDJSON_HAS_STDSTRING.
    */
    GenericValue& SetString(const std::basic_string<Ch>& s, Allocator& allocator) { return SetString(s.data(), s.size(), allocator); }
#endif

    //@}

    //! Generate events of this value to a Handler.
    /*! This function adopts the GoF visitor pattern.
        Typical usage is to output this JSON value as JSON text via Writer, which is a Handler.
        It can also be used to deep clone this value via GenericDocument, which is also a Handler.
        \tparam Handler type of handler.
        \param handler An object implementing concept Handler.
    */
    template <typename Handler>
    bool Accept(Handler& handler) const {
        switch(GetType()) {
        case kNullType:     return handler.Null();
        case kFalseType:    return handler.Bool(false);
        case kTrueType:     return handler.Bool(true);

        case kObjectType:
            if (!handler.StartObject())
                return false;
            for (ConstMemberIterator m = MemberBegin(); m != MemberEnd(); ++m) {
                if (!handler.String(m->name.data_.s.str, m->name.data_.s.length, (m->name.flags_ & kCopyFlag) != 0))
                    return false;
                if (!m->value.Accept(handler))
                    return false;
            }
            return handler.EndObject(data_.o.size);

        case kArrayType:
            if (!handler.StartArray())
                return false;
            for (GenericValue* v = data_.a.elements; v != data_.a.elements + data_.a.size; ++v)
                if (!v->Accept(handler))
                    return false;
            return handler.EndArray(data_.a.size);
    
        case kStringType:
            return handler.String(data_.s.str, data_.s.length, (flags_ & kCopyFlag) != 0);
    
        case kNumberType:
            if (IsInt())            return handler.Int(data_.n.i.i);
            else if (IsUint())      return handler.Uint(data_.n.u.u);
            else if (IsInt64())     return handler.Int64(data_.n.i64);
            else if (IsUint64())    return handler.Uint64(data_.n.u64);
            else                    return handler.Double(data_.n.d);
    
        default:
            RAPIDJSON_ASSERT(false);
        }
        return false;
    }

private:
    template <typename, typename, typename>
    friend class GenericDocument;

    enum {
        kBoolFlag = 0x100,
        kNumberFlag = 0x200,
        kIntFlag = 0x400,
        kUintFlag = 0x800,
        kInt64Flag = 0x1000,
        kUint64Flag = 0x2000,
        kDoubleFlag = 0x4000,
        kStringFlag = 0x100000,
        kCopyFlag = 0x200000,

        // Initial flags of different types.
        kNullFlag = kNullType,
        kTrueFlag = kTrueType | kBoolFlag,
        kFalseFlag = kFalseType | kBoolFlag,
        kNumberIntFlag = kNumberType | kNumberFlag | kIntFlag | kInt64Flag,
        kNumberUintFlag = kNumberType | kNumberFlag | kUintFlag | kUint64Flag | kInt64Flag,
        kNumberInt64Flag = kNumberType | kNumberFlag | kInt64Flag,
        kNumberUint64Flag = kNumberType | kNumberFlag | kUint64Flag,
        kNumberDoubleFlag = kNumberType | kNumberFlag | kDoubleFlag,
        kNumberAnyFlag = kNumberType | kNumberFlag | kIntFlag | kInt64Flag | kUintFlag | kUint64Flag | kDoubleFlag,
        kConstStringFlag = kStringType | kStringFlag,
        kCopyStringFlag = kStringType | kStringFlag | kCopyFlag,
        kObjectFlag = kObjectType,
        kArrayFlag = kArrayType,

        kTypeMask = 0xFF    // bitwise-and with mask of 0xFF can be optimized by compiler
    };

    static const SizeType kDefaultArrayCapacity = 16;
    static const SizeType kDefaultObjectCapacity = 16;

    struct String {
        const Ch* str;
        SizeType length;
        unsigned hashcode;  //!< reserved
    };  // 12 bytes in 32-bit mode, 16 bytes in 64-bit mode

    // By using proper binary layout, retrieval of different integer types do not need conversions.
    union Number {
#if RAPIDJSON_ENDIAN == RAPIDJSON_LITTLEENDIAN
        struct I {
            int i;
            char padding[4];
        }i;
        struct U {
            unsigned u;
            char padding2[4];
        }u;
#else
        struct I {
            char padding[4];
            int i;
        }i;
        struct U {
            char padding2[4];
            unsigned u;
        }u;
#endif
        int64_t i64;
        uint64_t u64;
        double d;
    };  // 8 bytes

    struct Object {
        Member* members;
        SizeType size;
        SizeType capacity;
    };  // 12 bytes in 32-bit mode, 16 bytes in 64-bit mode

    struct Array {
        GenericValue* elements;
        SizeType size;
        SizeType capacity;
    };  // 12 bytes in 32-bit mode, 16 bytes in 64-bit mode

    union Data {
        String s;
        Number n;
        Object o;
        Array a;
    };  // 12 bytes in 32-bit mode, 16 bytes in 64-bit mode

    // Initialize this value as array with initial data, without calling destructor.
    void SetArrayRaw(GenericValue* values, SizeType count, Allocator& allocator) {
        flags_ = kArrayFlag;
        data_.a.elements = (GenericValue*)allocator.Malloc(count * sizeof(GenericValue));
        memcpy(data_.a.elements, values, count * sizeof(GenericValue));
        data_.a.size = data_.a.capacity = count;
    }

    //! Initialize this value as object with initial data, without calling destructor.
    void SetObjectRaw(Member* members, SizeType count, Allocator& allocator) {
        flags_ = kObjectFlag;
        data_.o.members = (Member*)allocator.Malloc(count * sizeof(Member));
        memcpy(data_.o.members, members, count * sizeof(Member));
        data_.o.size = data_.o.capacity = count;
    }

    //! Initialize this value as constant string, without calling destructor.
    void SetStringRaw(StringRefType s) {
        flags_ = kConstStringFlag;
        data_.s.str = s;
        data_.s.length = s.length;
    }

    //! Initialize this value as copy string with initial data, without calling destructor.
    void SetStringRaw(StringRefType s, Allocator& allocator) {
        flags_ = kCopyStringFlag;
        data_.s.str = (Ch *)allocator.Malloc((s.length + 1) * sizeof(Ch));
        data_.s.length = s.length;
        memcpy(const_cast<Ch*>(data_.s.str), s, s.length * sizeof(Ch));
        const_cast<Ch*>(data_.s.str)[s.length] = '\0';
    }

    //! Assignment without calling destructor
    void RawAssign(GenericValue& rhs) {
        data_ = rhs.data_;
        flags_ = rhs.flags_;
        rhs.flags_ = kNullFlag;
    }

    bool StringEqual(const GenericValue& rhs) const {
        RAPIDJSON_ASSERT(IsString());
        RAPIDJSON_ASSERT(rhs.IsString());
        return data_.s.length == rhs.data_.s.length &&
            (data_.s.str == rhs.data_.s.str // fast path for constant string
            || memcmp(data_.s.str, rhs.data_.s.str, sizeof(Ch) * data_.s.length) == 0);
    }

    Data data_;
    unsigned flags_;
};
#pragma pack (pop)

//! GenericValue with UTF8 encoding
typedef GenericValue<UTF8<> > Value;

///////////////////////////////////////////////////////////////////////////////
// GenericDocument 

//! A document for parsing JSON text as DOM.
/*!
    \note implements Handler concept
    \tparam Encoding Encoding for both parsing and string storage.
    \tparam Allocator Allocator for allocating memory for the DOM
    \tparam StackAllocator Allocator for allocating memory for stack during parsing.
    \warning Although GenericDocument inherits from GenericValue, the API does \b not provide any virtual functions, especially no virtual destructor.  To avoid memory leaks, do not \c delete a GenericDocument object via a pointer to a GenericValue.
*/
template <typename Encoding, typename Allocator = MemoryPoolAllocator<>, typename StackAllocator = CrtAllocator>
class GenericDocument : public GenericValue<Encoding, Allocator> {
public:
    typedef typename Encoding::Ch Ch;                       //!< Character type derived from Encoding.
    typedef GenericValue<Encoding, Allocator> ValueType;    //!< Value type of the document.
    typedef Allocator AllocatorType;                        //!< Allocator type from template parameter.

    //! Constructor
    /*! \param allocator        Optional allocator for allocating memory.
        \param stackCapacity    Optional initial capacity of stack in bytes.
        \param stackAllocator   Optional allocator for allocating memory for stack.
    */
    GenericDocument(Allocator* allocator = 0, size_t stackCapacity = kDefaultStackCapacity, StackAllocator* stackAllocator = 0) : 
        allocator_(allocator), ownAllocator_(0), stack_(stackAllocator, stackCapacity), parseResult_()
    {
        if (!allocator_)
            ownAllocator_ = allocator_ = new Allocator();
    }

    ~GenericDocument() {
        delete ownAllocator_;
    }

    //!@name Parse from stream
    //!@{

    //! Parse JSON text from an input stream (with Encoding conversion)
    /*! \tparam parseFlags Combination of \ref ParseFlag.
        \tparam SourceEncoding Encoding of input stream
        \tparam InputStream Type of input stream, implementing Stream concept
        \param is Input stream to be parsed.
        \return The document itself for fluent API.
    */
    template <unsigned parseFlags, typename SourceEncoding, typename InputStream>
    GenericDocument& ParseStream(InputStream& is) {
        ValueType::SetNull(); // Remove existing root if exist
        GenericReader<SourceEncoding, Encoding, Allocator> reader(&GetAllocator());
        ClearStackOnExit scope(*this);
        parseResult_ = reader.template Parse<parseFlags>(is, *this);
        if (parseResult_) {
            RAPIDJSON_ASSERT(stack_.GetSize() == sizeof(ValueType)); // Got one and only one root object
            this->RawAssign(*stack_.template Pop<ValueType>(1));    // Add this-> to prevent issue 13.
        }
        return *this;
    }

    //! Parse JSON text from an input stream
    /*! \tparam parseFlags Combination of \ref ParseFlag.
        \tparam InputStream Type of input stream, implementing Stream concept
        \param is Input stream to be parsed.
        \return The document itself for fluent API.
    */
    template <unsigned parseFlags, typename InputStream>
    GenericDocument& ParseStream(InputStream& is) {
        return ParseStream<parseFlags,Encoding,InputStream>(is);
    }

    //! Parse JSON text from an input stream (with \ref kParseDefaultFlags)
    /*! \tparam InputStream Type of input stream, implementing Stream concept
        \param is Input stream to be parsed.
        \return The document itself for fluent API.
    */
    template <typename InputStream>
    GenericDocument& ParseStream(InputStream& is) {
        return ParseStream<kParseDefaultFlags, Encoding, InputStream>(is);
    }
    //!@}

    //!@name Parse in-place from mutable string
    //!@{

    //! Parse JSON text from a mutable string (with Encoding conversion)
    /*! \tparam parseFlags Combination of \ref ParseFlag.
        \tparam SourceEncoding Transcoding from input Encoding
        \param str Mutable zero-terminated string to be parsed.
        \return The document itself for fluent API.
    */
    template <unsigned parseFlags, typename SourceEncoding>
    GenericDocument& ParseInsitu(Ch* str) {
        GenericInsituStringStream<Encoding> s(str);
        return ParseStream<parseFlags | kParseInsituFlag, SourceEncoding>(s);
    }

    //! Parse JSON text from a mutable string
    /*! \tparam parseFlags Combination of \ref ParseFlag.
        \param str Mutable zero-terminated string to be parsed.
        \return The document itself for fluent API.
    */
    template <unsigned parseFlags>
    GenericDocument& ParseInsitu(Ch* str) {
        return ParseInsitu<parseFlags, Encoding>(str);
    }

    //! Parse JSON text from a mutable string (with \ref kParseDefaultFlags)
    /*! \param str Mutable zero-terminated string to be parsed.
        \return The document itself for fluent API.
    */
    GenericDocument& ParseInsitu(Ch* str) {
        return ParseInsitu<kParseDefaultFlags, Encoding>(str);
    }
    //!@}

    //!@name Parse from read-only string
    //!@{

    //! Parse JSON text from a read-only string (with Encoding conversion)
    /*! \tparam parseFlags Combination of \ref ParseFlag (must not contain \ref kParseInsituFlag).
        \tparam SourceEncoding Transcoding from input Encoding
        \param str Read-only zero-terminated string to be parsed.
    */
    template <unsigned parseFlags, typename SourceEncoding>
    GenericDocument& Parse(const Ch* str) {
        RAPIDJSON_ASSERT(!(parseFlags & kParseInsituFlag));
        GenericStringStream<SourceEncoding> s(str);
        return ParseStream<parseFlags, SourceEncoding>(s);
    }

    //! Parse JSON text from a read-only string
    /*! \tparam parseFlags Combination of \ref ParseFlag (must not contain \ref kParseInsituFlag).
        \param str Read-only zero-terminated string to be parsed.
    */
    template <unsigned parseFlags>
    GenericDocument& Parse(const Ch* str) {
        return Parse<parseFlags, Encoding>(str);
    }

    //! Parse JSON text from a read-only string (with \ref kParseDefaultFlags)
    /*! \param str Read-only zero-terminated string to be parsed.
    */
    GenericDocument& Parse(const Ch* str) {
        return Parse<kParseDefaultFlags>(str);
    }
    //!@}

    //!@name Handling parse errors
    //!@{

    //! Whether a parse error has occured in the last parsing.
    bool HasParseError() const { return parseResult_.IsError(); }

    //! Get the \ref ParseErrorCode of last parsing.
    ParseErrorCode GetParseError() const { return parseResult_.Code(); }

    //! Get the position of last parsing error in input, 0 otherwise.
    size_t GetErrorOffset() const { return parseResult_.Offset(); }

    //!@}

    //! Get the allocator of this document.
    Allocator& GetAllocator() { return *allocator_; }

    //! Get the capacity of stack in bytes.
    size_t GetStackCapacity() const { return stack_.GetCapacity(); }

private:
    // clear stack on any exit from ParseStream, e.g. due to exception
    struct ClearStackOnExit {
        explicit ClearStackOnExit(GenericDocument& d) : d_(d) {}
        ~ClearStackOnExit() { d_.ClearStack(); }
    private:
        ClearStackOnExit(const ClearStackOnExit&);
        ClearStackOnExit& operator=(const ClearStackOnExit&);
        GenericDocument& d_;
    };

    // callers of the following private Handler functions
    template <typename,typename,typename> friend class GenericReader; // for parsing
    friend class GenericValue<Encoding,Allocator>; // for deep copying

    // Implementation of Handler
    bool Null() { new (stack_.template Push<ValueType>()) ValueType(); return true; }
    bool Bool(bool b) { new (stack_.template Push<ValueType>()) ValueType(b); return true; }
    bool Int(int i) { new (stack_.template Push<ValueType>()) ValueType(i); return true; }
    bool Uint(unsigned i) { new (stack_.template Push<ValueType>()) ValueType(i); return true; }
    bool Int64(int64_t i) { new (stack_.template Push<ValueType>()) ValueType(i); return true; }
    bool Uint64(uint64_t i) { new (stack_.template Push<ValueType>()) ValueType(i); return true; }
    bool Double(double d) { new (stack_.template Push<ValueType>()) ValueType(d); return true; }

    bool String(const Ch* str, SizeType length, bool copy) { 
        if (copy) 
            new (stack_.template Push<ValueType>()) ValueType(str, length, GetAllocator());
        else
            new (stack_.template Push<ValueType>()) ValueType(str, length);
        return true;
    }

    bool StartObject() { new (stack_.template Push<ValueType>()) ValueType(kObjectType); return true; }
    
    bool EndObject(SizeType memberCount) {
        typename ValueType::Member* members = stack_.template Pop<typename ValueType::Member>(memberCount);
        stack_.template Top<ValueType>()->SetObjectRaw(members, (SizeType)memberCount, GetAllocator());
        return true;
    }

    bool StartArray() { new (stack_.template Push<ValueType>()) ValueType(kArrayType); return true; }
    
    bool EndArray(SizeType elementCount) {
        ValueType* elements = stack_.template Pop<ValueType>(elementCount);
        stack_.template Top<ValueType>()->SetArrayRaw(elements, elementCount, GetAllocator());
        return true;
    }

private:
    //! Prohibit assignment
    GenericDocument& operator=(const GenericDocument&);

    void ClearStack() {
        if (Allocator::kNeedFree)
            while (stack_.GetSize() > 0)    // Here assumes all elements in stack array are GenericValue (Member is actually 2 GenericValue objects)
                (stack_.template Pop<ValueType>(1))->~ValueType();
        else
            stack_.Clear();
        stack_.ShrinkToFit();
    }

    static const size_t kDefaultStackCapacity = 1024;
    Allocator* allocator_;
    Allocator* ownAllocator_;
    internal::Stack<StackAllocator> stack_;
    ParseResult parseResult_;
};

//! GenericDocument with UTF8 encoding
typedef GenericDocument<UTF8<> > Document;

// defined here due to the dependency on GenericDocument
template <typename Encoding, typename Allocator>
template <typename SourceAllocator>
inline
GenericValue<Encoding,Allocator>::GenericValue(const GenericValue<Encoding,SourceAllocator>& rhs, Allocator& allocator)
{
    GenericDocument<Encoding,Allocator> d(&allocator);
    rhs.Accept(d);
    RawAssign(*d.stack_.template Pop<GenericValue>(1));
}

} // namespace rapidjson

#if defined(_MSC_VER) || defined(__GNUC__)
RAPIDJSON_DIAG_POP
#endif

#endif // RAPIDJSON_DOCUMENT_H_

