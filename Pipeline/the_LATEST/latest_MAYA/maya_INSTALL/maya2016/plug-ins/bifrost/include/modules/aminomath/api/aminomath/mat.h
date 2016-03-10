// ==================================================================
// Copyright 2014 Autodesk, Inc.  All rights reserved.
// 
// This computer source code  and related  instructions and comments are
// the unpublished confidential and proprietary information of Autodesk,
// Inc. and are  protected  under applicable  copyright and trade secret
// law. They may not  be disclosed to, copied or used by any third party
// without the prior written consent of Autodesk, Inc.
// ==================================================================
#ifndef MAT_H
#define MAT_H

// Similar to the vec class, a fixed dimension matrix class.

#include <cstring>
#include <cmath>
#include <iostream>
#include <sstream>
#include <aminomath/vec.h>
#include <bifrostcore/type_meta.h>

namespace amino {
namespace Math {

/// [OPAQUE TYPE]
template<unsigned int M, unsigned int N, typename T>
struct mat
{
    T a[M*N]; // entries stored column by column (FORTRAN layout)

    explicit
    mat<M,N,T>(T diagonal_value=T(0))
    {
        for(unsigned int i=0; i<M*N; ++i) a[i]=T(0);

		if(diagonal_value != T(0))
			for(unsigned int i=0; i<M*N; i+=M+1) a[i]=diagonal_value;
    }

    mat<M,N,T>(const T& a00, const T& a01,
               const T& a10, const T& a11)
    {
		static_assert(M==2 && N==2, "matrix is not 2 by 2.");
        a[0]=a00; a[2]=a01;
        a[1]=a10; a[3]=a11;
    }

    mat<M,N,T>(const T& a00, const T& a01, const T& a02,
               const T& a10, const T& a11, const T& a12,
               const T& a20, const T& a21, const T& a22)
    {
        static_assert(M==3 && N==3, "matrix is not 3 by 3.");
        a[0]=a00; a[3]=a01; a[6]=a02;
        a[1]=a10; a[4]=a11; a[7]=a12;
        a[2]=a20; a[5]=a21; a[9]=a22;
    }

    mat<M,N,T>(const T& a00, const T& a01, const T& a02, const T& a03,
               const T& a10, const T& a11, const T& a12, const T& a13,
               const T& a20, const T& a21, const T& a22, const T& a23,
               const T& a30, const T& a31, const T& a32, const T& a33)
    {
        static_assert(M==4 && N==4, "matrix is not 4 by 4.");
        a[0]=a00; a[4]=a01;  a[8]=a02; a[12]=a03;
        a[1]=a10; a[5]=a11;  a[9]=a12; a[13]=a13;
        a[2]=a20; a[6]=a21; a[10]=a22; a[14]=a23;
        a[3]=a30; a[7]=a31; a[11]=a32; a[15]=a33;
    }

    T &operator()(int i, int j)
    {
        assert(0<=i && (unsigned int)i<M && 0<=j && (unsigned int)j<N);
        return a[i+M*j];
    }

    const T &operator()(int i, int j) const
    {
        assert(0<=i && (unsigned int)i<M && 0<=j && (unsigned int)j<N);
        return a[i+M*j];
    }

    amino::Math::vec<M,T> col(int j) const
    {
        assert(0<=j && (unsigned int)j<N);
        return amino::Math::vec<M,T>(a+j*M);
    }

    amino::Math::vec<N,T> row(int i) const
    {
        assert(0<=i && i<M);
        amino::Math::vec<N,T> v;
        for(unsigned int j=0; j<N; ++j) v[j]=(*this)(i,j);
        return v;
    }

    mat<M,N,T> operator+=(const mat<M,N,T> &b)
    {
        for(unsigned int i=0; i<M*N; ++i) a[i]+=b.a[i];
        return *this;
    }

    mat<M,N,T> operator+(const mat<M,N,T> &b) const
    {
        mat<M,N,T> sum(*this);
        sum+=b;
        return sum;
    }

    mat<M,N,T> operator-=(const mat<M,N,T> &b)
    {
        for(unsigned int i=0; i<M*N; ++i) a[i]-=b.a[i];
        return *this;
    }

    mat<M,N,T> operator-(const mat<M,N,T> &b) const
    {
        mat<M,N,T> diff(*this);
        diff-=b;
        return diff;
    }

    mat<M,N,T> operator*=(const T& scalar)
    {
        for(unsigned int i=0; i<M*N; ++i) a[i]*=scalar;
        return *this;
    }

    mat<M,N,T> operator*(const T& scalar) const
    {
        mat<M,N,T> b(*this);
        b*=scalar;
        return b;
    }

    amino::Math::vec<M,T> operator*(const amino::Math::vec<N,T> v) const
    {
        amino::Math::vec<M,T> r;
        for(unsigned int i=0; i<M; ++i){
            r[i]=0;
            for(unsigned int j=0; j<N; ++j)
                r[i]+=(*this)(i,j)*v[j];
        }
        return r;
    }

    template<unsigned int P>
    mat<M,P,T> operator*(const mat<N,P,T> b) const
    {
        mat<M,P,T> c;
        for(unsigned int i=0; i<M; ++i){
            for(unsigned int j=0; j<P; ++j){
                c(i,j)=0;
                for(unsigned int k=0; k<N; ++k)
                    c(i,j)+=(*this)(i,k)*b(k,j);
            }
        }
        return c;
    }

    mat<M,N,T> operator/=(const T& scalar)
    {
        for(unsigned int i=0; i<M*N; ++i) a[i]/=scalar;
        return *this;
    }

    mat<M,N,T> operator/(const T& scalar) const
    {
        mat<M,N,T> b(*this);
        b/=scalar;
        return b;
    }

    bool operator == ( const mat<M,N,T>& mat ) const
    {
		for( unsigned int i=0; i<M*N; ++i) {
			if ( a[i] != mat.a[i] ) {
				return false;
			}
		}
		return true;
    }

    mat<N,M,T> transpose() const
    {
        mat<N,M,T> result;
        for(unsigned int i = 0; i < M; ++i){
            for(unsigned int j = 0; j < N; ++j){
                result(j,i) = (*this)(i,j);
            }
        }
        return result;
	}

	static const std::string& typeName()
	{
		static std::string s_typeName;
		std::stringstream s;
		s << "mat<" << M << "," << N << "," << Bifrost::TypeMeta<T>().typeName() << ">";
		s_typeName = s.str();
		return s_typeName;
	}
};

#include <aminomath/mat.inl>

/// [TYPE]
typedef mat<2,2,double> mat22d;
/// [TYPE]
typedef mat<2,2,float>  mat22f;
/// [TYPE]
typedef mat<2,2,int>    mat22i;
/// [TYPE]
typedef mat<3,2,double> mat32d;
/// [TYPE]
typedef mat<3,2,float>  mat32f;
/// [TYPE]
typedef mat<3,2,int>    mat32i;
/// [TYPE]
typedef mat<2,3,double> mat23d;
/// [TYPE]
typedef mat<2,3,float>  mat23f;
/// [TYPE]
typedef mat<2,3,int>    mat23i;
/// [TYPE]
typedef mat<3,3,double> mat33d;
/// [TYPE]
typedef mat<3,3,float>  mat33f;
/// [TYPE]
typedef mat<3,3,int>    mat33i;
/// [TYPE]
typedef mat<4,4,double> mat44d;
/// [TYPE]
typedef mat<4,4,float>  mat44f;
/// [TYPE]
typedef mat<4,4,int>    mat44i;


} // Math
} // amino

#endif
