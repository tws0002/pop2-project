/****************************************************************************************

   Copyright (C) 2012 Autodesk, Inc.
   All rights reserved.

   Use of this software is subject to the terms of the Autodesk license agreement
   provided at the time of installation or download, or which otherwise accompanies
   this software in either electronic or hard copy form.

****************************************************************************************/
//! \file type_meta.h
//! \brief This file contains functionality for type strings of objects that can be stored in channels.
//! The type strings have to be persistent and portable, therefore we cannot use the RTTI typeid/type_info
//! C++ functionality (ref "Modern C++ design").

#ifndef TYPE_META_H
#define TYPE_META_H

#include <string>
#include <cstdint>
#include <bifrostcore/bifrostcore_decl.h>
#include <aminomath/vec.h>


namespace amino { namespace Math {
	template<unsigned int N, typename T> struct vec;
} // Math
} // amino

namespace Bifrost
{

//! Should support all the functionality required to infer information about
//! a specific type. For example:
//! (1) By the state server client plugins in order to be able to reserve space on the state server without
//!     having access to the type at compile time.
//! (2) By the shape in order to be able to check the type of a channel requested at run-time. Note that all types
//!     that must be stored in channels must support a "static const std::string& typeName()" method.
//! (3) To check whether objects of one type are castable to objects of another type - without 
//!     having access to instances of the types (not possible with the RTTI type_info).
//! (4) To instantiate (using factory classes) objects of the correct type from data stored persistently. Note that
//!     the native C++ RTTI is not persistent, so it cannot be used for this purpose.
struct BIFROSTCORE_API TypeMetaBase
{
    virtual
    ~TypeMetaBase();

    virtual 
    const std::string& 
    typeName() const = 0;

    virtual
    TypeMetaBase*
    newInstance() const = 0;
};


template<typename T>
struct TypeMeta : public TypeMetaBase
{
    TypeMeta() { }
    const std::string& typeName() const { return T::typeName(); }
    TypeMeta<T>* newInstance() const { return new TypeMeta<T>(); }
};


//////////////////////////////////////////////////////////////////
// TEMPLATE SPECIALIZATIONS OF TYPEMETA FOR FUNDAMENTAL TYPES
//////////////////////////////////////////////////////////////////

template<>
struct BIFROSTCORE_API TypeMeta<int8_t> : public TypeMetaBase
{
    TypeMeta() {}
    const std::string& typeName() const;
    TypeMeta<int8_t>* newInstance() const;
};

template<>
struct BIFROSTCORE_API TypeMeta<int16_t> : public TypeMetaBase
{
    TypeMeta() {}
    const std::string& typeName() const;
    TypeMeta<int16_t>* newInstance() const;
};

template<>
struct BIFROSTCORE_API TypeMeta<int32_t> : public TypeMetaBase
{
    TypeMeta() {}
    const std::string& typeName() const;
    TypeMeta<int32_t>* newInstance() const;
};

template<>
struct BIFROSTCORE_API TypeMeta<int64_t> : public TypeMetaBase
{
    TypeMeta() {}
    const std::string& typeName() const;
    TypeMeta<int64_t>* newInstance() const;
};

template<>
struct BIFROSTCORE_API TypeMeta<uint8_t> : public TypeMetaBase
{
    TypeMeta() {}
    const std::string& typeName() const;
    TypeMeta<uint8_t>* newInstance() const;
};

template<>
struct BIFROSTCORE_API TypeMeta<uint16_t> : public TypeMetaBase
{
    TypeMeta() {}
    const std::string& typeName() const;
    TypeMeta<uint16_t>* newInstance() const;
};

template<>
struct BIFROSTCORE_API TypeMeta<uint32_t> : public TypeMetaBase
{
    TypeMeta() {}
    const std::string& typeName() const;
    TypeMeta<uint32_t>* newInstance() const;
};

template<>
struct BIFROSTCORE_API TypeMeta<uint64_t> : public TypeMetaBase
{
    TypeMeta() {}
    const std::string& typeName() const;
    TypeMeta<uint64_t>* newInstance() const;
};

template<>
struct BIFROSTCORE_API TypeMeta<bool> : public TypeMetaBase
{
    TypeMeta() {}
    const std::string& typeName() const;
    TypeMeta<bool>* newInstance() const;
};

template<>
struct BIFROSTCORE_API TypeMeta<float> : public TypeMetaBase
{
    TypeMeta() {}
    const std::string& typeName() const;
    TypeMeta<float>* newInstance() const;
};

template<>
struct BIFROSTCORE_API TypeMeta<double> : public TypeMetaBase
{
    TypeMeta() {}
    const std::string& typeName() const;
    TypeMeta<double>* newInstance() const;
};

template<>
struct BIFROSTCORE_API TypeMeta<amino::Math::vec<3,float> > : public TypeMetaBase
{
    TypeMeta() {}
    const std::string& typeName() const;
    TypeMeta<amino::Math::vec<3,float> >* newInstance() const;
};


//////////////////////////////////////////////////////////////////


} // namespace Bifrost

#endif