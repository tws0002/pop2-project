// ==================================================================
// Copyright 2014 Autodesk, Inc.  All rights reserved.
// 
// This computer source code  and related  instructions and comments are
// the unpublished confidential and proprietary information of Autodesk,
// Inc. and are  protected  under applicable  copyright and trade secret
// law. They may not  be disclosed to, copied or used by any third party
// without the prior written consent of Autodesk, Inc.
// ==================================================================
#ifndef VEC_H
#define VEC_H


#include <stdint.h>  // <cstdint> for compilation with icc 11.1
#include <cassert>
#include <cmath>
#include <iostream>
#include <sstream>
#include <bifrostcore/type_meta.h>

#ifndef AMINO_TYPE_PARSING
#include <limits>
#endif

namespace Bifrost {
	template<typename T> struct TypeMeta;
}

namespace amino {
namespace Math {
// -----------------------------------------------------------------------------

template<typename T> inline T
sqr(T x)
{
    return x*x;
}

// -----------------------------------------------------------------------------
/// [OPAQUE TYPE]
/// [Semantics = "Static Array"]
template<unsigned int N, typename T>
struct vec
{
    T v[N];

	vec<N,T>(void)
	{
#ifndef AMINO_TYPE_PARSING
#ifdef AG_ANY_DEBUG
		for(unsigned int i=0; i<N; ++i)
			v[i]=std::numeric_limits<T>::signaling_NaN();
#elif BIFROST_RELEASE_FORCE_VOXEL_INIT_DATA
		for(unsigned int i=0; i<N; ++i)
			v[i]=T(0);
#endif
#endif
	}

    explicit
    vec<N,T>(T value_for_all)
    { for(unsigned int i=0; i<N; ++i) v[i]=value_for_all; }

    template<class S> explicit
    vec<N,T>(const S *source)
    { for(unsigned int i=0; i<N; ++i) v[i]=(T)source[i]; }

    template<class S> explicit
    vec<N,T>(const vec<N,S>& source)
    { for(unsigned int i=0; i<N; ++i) v[i]=(T)source[i]; }

    vec<N,T>(T v0, T v1)
    {
        assert(N==2);
        v[0]=v0; v[1]=v1;
    }

    vec<N,T>(T v0, T v1, T v2)
    {
        assert(N==3);
        v[0]=v0; v[1]=v1; v[2]=v2;
    }

    vec<N,T>(T v0, T v1, T v2, T v3)
    {
        assert(N==4);
        v[0]=v0; v[1]=v1; v[2]=v2; v[3]=v3;
    }

    vec<N,T>(T v0, T v1, T v2, T v3, T v4)
    {
        assert(N==5);
        v[0]=v0; v[1]=v1; v[2]=v2; v[3]=v3; v[4]=v4;
    }

    vec<N,T>(T v0, T v1, T v2, T v3, T v4, T v5)
    {
        assert(N==6);
        v[0]=v0; v[1]=v1; v[2]=v2; v[3]=v3; v[4]=v4; v[5]=v5;
    }

    vec<N,T>(T v0, T v1, T v2, T v3, T v4, T v5, T v6, T v7)
    {
        assert(N==8);
        v[0]=v0; v[1]=v1; v[2]=v2; v[3]=v3; v[4]=v4; v[5]=v5; v[6]=v6; v[7]=v7;
    }

    vec<N,T>(const vec<N-1,T> &x, T y)
    {
        for(unsigned int i=0; i<N-1; ++i)
            v[i]=x[i];
        v[N-1]=y;
    }

    T&
    operator[](int index)
    {
        assert(0<=index && (unsigned int)index<N);
        return v[index];
    }

    const T&
    operator[](int index) const
    {
        assert(0<=index && (unsigned int)index<N);
        return v[index];
    }

    bool
    nonzero(void) const
    {
        for(unsigned int i=0; i<N; ++i) if(v[i]) return true;
        return false;
    }

    template<typename S> vec<N,T>
    operator+=(const vec<N,S>& w)
    {
        for(unsigned int i=0; i<N; ++i) v[i]+=w[i];
        return *this;
    }

    vec<N,T>
    operator+(const vec<N,T>& w) const
    {
        vec<N,T> sum(*this);
        sum+=w;
        return sum;
    }

    vec<N,T>
    operator-=(const vec<N,T>& w)
    {
        for(unsigned int i=0; i<N; ++i) v[i]-=w[i];
        return *this;
    }

    vec<N,T>
    operator-(void) const // unary minus
    {
        vec<N,T> negative;
        for(unsigned int i=0; i<N; ++i) negative.v[i]=-v[i];
        return negative;
    }

    vec<N,T>
    operator-(const vec<N,T>& w) const // (binary) subtraction
    {
        vec<N,T> diff(*this);
        diff-=w;
        return diff;
    }

    template<typename S> vec<N,T>
    operator*=(S a)
    {
        for(unsigned int i=0; i<N; ++i) v[i]=(T)(v[i]*a);
        return *this;
    }

    vec<N,T>
    operator*(T a) const
    {
        vec<N,T> w(*this);
        w*=a;
        return w;
    }

    vec<N,T>
    operator*=(const vec<N,T>& w)
    {
        for(unsigned int i=0; i<N; ++i) v[i]*=w.v[i];
        return *this;
    }

    vec<N,T>
    operator*(const vec<N,T>& w) const
    {
        vec<N,T> componentwise_product;
        for(unsigned int i=0; i<N; ++i) componentwise_product[i]=v[i]*w.v[i];
        return componentwise_product;
    }

    vec<N,T>
    operator/=(T a)
    {
        for(unsigned int i=0; i<N; ++i) v[i]/=a;
        return *this;
    }

    vec<N,T>
    operator/(T a) const
    {
        vec<N,T> w(*this);
        w/=a;
        return w;
    }

    bool
    operator<(const vec<N,T>& w) const
    {
        for(unsigned int i=0; i<N; ++i){
            if(v[i]<w.v[i]) return true;
            else if(v[i]>w.v[i]) return false;
        }
        return false;
    }

    static 
    const std::string& 
    typeName()
    {
        static bool s_first = true;
        static std::string s_typeName;
        if ( s_first )
        {
            std::stringstream s;
            s << "vec<" << N << "," << Bifrost::TypeMeta<T>().typeName() << ">";
            s_typeName = s.str();
        }
        return s_typeName;
    }
};

#include <aminomath/vec.inl>

// -----------------------------------------------------------------------------

/// [TYPE]
typedef vec<2,double>         vec2d;
/// [TYPE]
/// [UID={342D0EF4-D48B-4353-BC0C-0D3E768B9B40}]
typedef vec<2,float>          vec2f;
/// [TYPE]
typedef vec<2,int64_t>        vec2i64;
/// [TYPE]
typedef vec<2,int>            vec2i;
/// [TYPE]
typedef vec<2,unsigned int>   vec2ui;
/// [TYPE]
typedef vec<2,short>          vec2s;
/// [TYPE]
typedef vec<2,unsigned short> vec2us;
/// [TYPE]
typedef vec<2,char>           vec2c;
/// [TYPE]
typedef vec<2,unsigned char>  vec2uc;

/// [TYPE]
typedef vec<3,double>         vec3d;
/// [TYPE]
/// [UID={D6C6469F-7185-4213-9011-38F4FE2E2912}]
typedef vec<3,float>          vec3f;
/// [TYPE]
typedef vec<3,int64_t>        vec3i64;
/// [TYPE]
typedef vec<3,int>            vec3i;
/// [TYPE]
typedef vec<3,unsigned int>   vec3ui;
/// [TYPE]
typedef vec<3,short>          vec3s;
/// [TYPE]
typedef vec<3,unsigned short> vec3us;
/// [TYPE]
typedef vec<3,char>           vec3c;
/// [TYPE]
typedef vec<3,unsigned char>  vec3uc;

/// [TYPE]
typedef vec<4,double>         vec4d;
/// [TYPE]
/// [UID={D115D5DC-008F-45c2-95F9-07C4733A7B45}]
typedef vec<4,float>          vec4f;
/// [TYPE]
typedef vec<4,int>            vec4i;
/// [TYPE]
typedef vec<4,int64_t>        vec4i64;
/// [TYPE]
typedef vec<4,unsigned int>   vec4ui;
/// [TYPE]
typedef vec<4,short>          vec4s;
/// [TYPE]
typedef vec<4,unsigned short> vec4us;
/// [TYPE]
typedef vec<4,char>           vec4c;
/// [TYPE]
typedef vec<4,unsigned char>  vec4uc;

/// [TYPE]
typedef vec<6,double>         vec6d;
/// [TYPE]
typedef vec<6,float>          vec6f;
/// [TYPE]
typedef vec<6,unsigned int>   vec6ui;
/// [TYPE]
typedef vec<6,int>            vec6i;
/// [TYPE]
typedef vec<6,short>          vec6s;
/// [TYPE]
typedef vec<6,unsigned short> vec6us;
/// [TYPE]
typedef vec<6,char>           vec6c;
/// [TYPE]
typedef vec<6,unsigned char>  vec6uc;

/// [TYPE]
typedef vec<8,int>            vec8i;

// -----------------------------------------------------------------------------


} // Math
} // amino

#ifndef AMINO_TYPE_PARSING

namespace std
{

template<unsigned int N, typename T>
class numeric_limits<amino::Math::vec<N,T> >
{
public:
	static inline amino::Math::vec<N,T> signaling_NaN() throw()
	{
		static amino::Math::vec<N,T> vec_NaN(std::numeric_limits<T>::signaling_NaN());
		return vec_NaN;
	}
};


} // std

#endif

#endif
