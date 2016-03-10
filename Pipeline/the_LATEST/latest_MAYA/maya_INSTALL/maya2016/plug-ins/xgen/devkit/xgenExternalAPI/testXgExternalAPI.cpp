// Copyright 2014 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.
//
// testXgExternalAPI.cpp
//
// Description:
//  Sample plug-in demonstrating how to use the XgExternalAPI.
//  This sample is also used internally as a unit test.
//
//  testXgExternalAPI -help will list the options.
//
// Example usages:
// testXgExternalAPI -t 0;

//
//
#include <maya/MPxCommand.h>
#include <maya/MSyntax.h>
#include <maya/MArgList.h>
#include <maya/MArgDatabase.h>
#include <maya/MGlobal.h>
#include <maya/MFnPlugin.h>
#include "testXgExternalAPI.h"
;
#define kCmdName "testXgExternalAPI"
#define CLASSNAME testXgExternalAPICmd
#define kTestRunFlag "-t"
#define kTestRunFlagLong "-testRun"

//////////////////////////////////////////////////////////////////////////
//
// Unit Test function pointers stored by name.
//
//////////////////////////////////////////////////////////////////////////

void Tests::add( const MString& name, Functor fp )
{
    std::string key = name.asChar();
    m_tests.insert( std::make_pair( key, fp ) );
}

MStatus Tests::run( const MString name, MStringArray& err ) const
{
    Map::const_iterator it = m_tests.find( name.asChar() );
    if( it == m_tests.end() )
    {
        MGlobal::displayError("Test name isn't registered in Tests");
        return MS::kFailure;
    }

    Functor f = it->second;
    return f(err);
}

void Tests::tests( std::vector<MString>& out_tests ) const
{
    out_tests.clear();
    for( Map::const_iterator it = m_tests.begin(); it!= m_tests.end(); ++it )
    {
        out_tests.push_back( it->first.c_str() );
    }
}

Tests* Tests::instance()
{
    static Tests s;
    return &s;
}

RegisterTest::RegisterTest( const char* name, Tests::Functor fp )
{
    Tests::instance()->add( name, fp );
}

//////////////////////////////////////////////////////////////////////////
//
// Command class declaration
//
//////////////////////////////////////////////////////////////////////////

class CLASSNAME : public MPxCommand
{
public:
    CLASSNAME() {};
    virtual ~CLASSNAME();
    MStatus doIt( const MArgList& args );

    static void* creator();

    /* Syntax setup. */
    bool hasSyntax() const { return true; }
    static MSyntax newSyntax();

    /* Display the command syntax. */
    void displayCommand() const;

private:
    MStatus parseArgs(const MArgList &args);
    void getCamPath(const MString &camName, MDagPath &camPath);

    MString _testName;
};

//////////////////////////////////////////////////////////////////////////
//
// Command class implementation
//
//////////////////////////////////////////////////////////////////////////

CLASSNAME::~CLASSNAME()
{
}

void* CLASSNAME::creator()
{
    return new CLASSNAME();
}

MStatus CLASSNAME::parseArgs( const MArgList& args)
{
    MArgDatabase argData( syntax(), args );

    if( !argData.isFlagSet(kTestRunFlagLong) )
        return MS::kFailure;

    argData.getFlagArgument( kTestRunFlagLong, 0, _testName );

    return MS::kSuccess;
}

MStatus CLASSNAME::doIt( const MArgList& args)
{
    MStatus status = parseArgs(args);
    if (status != MS::kSuccess)
    {
        displayCommand();
        return status;
    }

    MStringArray err;
    MStatus ret = Tests::instance()->run( _testName, err );
    setResult( err );
    return ret;
}
/** Describe the command syntax. */
MSyntax CLASSNAME::newSyntax()
{
    MSyntax syntax;

    syntax.enableEdit( false );
    syntax.enableQuery( false );
    syntax.addFlag( kTestRunFlag, kTestRunFlagLong, MSyntax::kString );

    return syntax;
}

/** Display the command syntax. */
void CLASSNAME::displayCommand() const
{
    MString message;

    message = "Command syntax: \n";
    message += "\t" kCmdName " -t testName\n";

    std::vector< MString > tests;
    Tests::instance()->tests( tests );

    message += "Registered tests:";
    for( std::vector<MString>::const_iterator it=tests.begin(); it!=tests.end(); ++it )
    {
        message += "\n\t";
        message += *it;
    }
    message += "\n";

    MGlobal::displayInfo( message );
}

//////////////////////////////////////////////////////////////////////////
//
// Plugin registration
//
//////////////////////////////////////////////////////////////////////////

MStatus initializePlugin( MObject obj )
{
    MFnPlugin plugin( obj );
    MStatus stat = plugin.registerCommand( kCmdName, CLASSNAME::creator, CLASSNAME::newSyntax );
    return stat;
}

MStatus uninitializePlugin( MObject obj)
{
    MFnPlugin plugin( obj );
    return plugin.deregisterCommand( kCmdName );
}


