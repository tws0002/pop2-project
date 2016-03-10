// Copyright 2014 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.
//
// testXgExternalAPI.h

#ifndef __TESTXGEXTERNALAPI_H__
#define __TESTXGEXTERNALAPI_H__

#include <maya/MString.h>
#include <maya/MStringArray.h>
#include <maya/MStatus.h>
#include <map>
#include <string>
#include <vector>

//////////////////////////////////////////////////////////////////////////
//
// Unit Test function pointers stored by name.
//
//////////////////////////////////////////////////////////////////////////
class Tests
{
public:
    typedef MStatus (*Functor)(MStringArray& err);

    void add( const MString& name, Functor fp );
    MStatus run( const MString name, MStringArray& err ) const;
    void tests( std::vector<MString>& out_tests ) const;

    static Tests* instance();

private:
    typedef std::map< std::string, Functor > Map;
    Map m_tests;
};

//////////////////////////////////////////////////////////////////////////
//
// Registers a single test function by name.
//
//////////////////////////////////////////////////////////////////////////
class RegisterTest
{
public:
    RegisterTest( const char* name, Tests::Functor fp );
};

#define self_assertTrue( c, m ) \
if( !(c) ) \
{ \
    err.append( MString( std::string( m ).c_str() ) ); \
}

// Macro to Implement a new test and have it registered in s_tests
#define IMPL_TEST( x ) \
MStatus x( MStringArray& err ); \
static RegisterTest s_ ## x( #x, x ); \
MStatus x(MStringArray& err)

#endif
