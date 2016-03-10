// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

#include <cstring>
#include <cstdio>
#include <cstdlib>
#include <map>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string>
#include <vector>

#include <iostream>
#include <fstream>
#include <sstream>

#include <shader.h>
#include <geoshader.h>

#include "XgHairUtil.h"
#include "XgHelpers.h"
#include "XgSeExpr.h"

#ifndef DLLEXPORT
#define DLLEXPORT
#endif

using namespace XGenMR;
using namespace std;

// Tracing Macros
#if 0
#define DEBUG_TRACE(x) printf("%s %p\n",x, this)
#define DEBUG_TRACEP(x,p) printf("%s %p\n",x, p)
#else
#define DEBUG_TRACE(x)
#define DEBUG_TRACEP(x,p)
#endif

// SeExprShader::ctor
XGenMR::SeExprShader::SeExprShader()
{
	m_pExpression = NULL;
}

// SeExprShader::dtor
XGenMR::SeExprShader::~SeExprShader()
{
	if( m_pExpression )
	{
		delete m_pExpression;
		m_pExpression = NULL;
	}
}

// MRSeExpression::createRefs, creates MRSeExprVarRef wrapper for each variable currently in the tls values
void
XGenMR::SeExprShader::
MRSeExpression::createRefs()
{
	const TLSValues* values = getTLSValues();
	if( values )
	{
		for( TLSValues::const_iterator it= values->begin(); it!=values->end(); ++it )
		{
			m_refs[ it->first ] = MRSeExprVarRef( this, it->first.c_str(), it->second.second );
		}
	}
}

// MRSeExpression::resolveVar, SeExpr callback to lookup a variable by name
SeExprVarRef* 
XGenMR::SeExprShader::
MRSeExpression::resolveVar(const std::string& name) const
{
	std::map<std::string,MRSeExprVarRef>::const_iterator it = m_refs.find( name );
	if( it!=m_refs.end() )
	{
		return (SeExprVarRef*)&(it->second);
	}
	else
	{
		return NULL;
	}
}

// MRSeExprVarRef::isVec, hardcoded to vector for now.
bool  
XGenMR::SeExprShader::
MRSeExprVarRef::isVec()
{
	return m_isVector;
}

// MRSeExprVarRef::eval, evaluates the variable value. Looks in TLS Values()
void 
XGenMR::SeExprShader::
MRSeExprVarRef::eval(const SeExprVarNode* node, SeVec3d& result)
{
	result[0] = result[1] = result[2] = 0.0;
	if( m_parent!=NULL )
	{
		const MRSeExpression::TLSValues* values = m_parent->getTLSValues();

		if( values!=NULL )
		{
			MRSeExpression::TLSValues::const_iterator it = values->find( m_name );
			if( it!=values->end() )
			{
				result = it->second.first;
			}
		}
	}
}

bool XGenMR::SeExprShader::findInstanceUserData( miState* state, miTag in_instance, miTag& out_user )
{
    miTag user = 0;
    // Search directly on the instance data
    if( mi_query(miQ_INST_DATA, state, in_instance, &user) && user!=0 )
    {
        out_user = user;
        return true;
    }

    // Couldn't find a valid user data
    return false;
}

bool XGenMR::SeExprShader::findPlaceholderItemUserData( miState* state, miTag in_instance, miTag& out_user )
{
    miTag placeHolderItemTag = 0;
    miTag user = 0;
    // Seach on the placeholder item object data
    if( mi_query(miQ_INST_PLACEHOLDER_ITEM, state, in_instance, &placeHolderItemTag ) && placeHolderItemTag!=0 &&
        mi_db_type(placeHolderItemTag) == miSCENE_OBJECT &&
        mi_query(miQ_OBJ_DATA, state, placeHolderItemTag, &user) && user!=0 )
    {
        out_user = user;
        return true;
    }

    // Couldn't find a valid user data
    return false;
}

bool XGenMR::SeExprShader::findXGMRUserData( miState* state, miTag in_user, char*& out_string, int& out_size )
{
    int userDataSize = 0;
    char* userDataString = NULL;
    if( mi_query(miQ_DATA_PARAM_SIZE, state, in_user, &userDataSize) && userDataSize >=0 &&
        mi_query(miQ_DATA_PARAM, state, in_user, &userDataString) && userDataString!=NULL)
    {
        // Found it.
        if( strncmp( "XGMR", userDataString, 4 )==0 )
        {
            out_string = userDataString;
            out_size = userDataSize;
            return true;
        }
    }

    // Go on the next user data if there is one on the list
    miTag nextUserData = 0;
    if( mi_query(miQ_DATA_NEXT, state, in_user, &nextUserData) && nextUserData!=0 )
        return findXGMRUserData( state, nextUserData, out_string, out_size );

    // No next user data.
    return false;
}

bool XGenMR::SeExprShader::findXGMRUserDataOnInstance( miState* state, miTag in_instance, char*& out_string, int& out_size )
{
    miTag user = 0;

    // Search on instance
    if( findInstanceUserData( state, in_instance, user )  &&
        findXGMRUserData( state, user, out_string, out_size ) )
    {
        return true;
    }

    // if it failed, Search on placeholder item
    if( findPlaceholderItemUserData( state, in_instance, user )  &&
        findXGMRUserData( state, user, out_string, out_size ) )
    {
        return true;
    }

    // Couldn't find anything
    return false;

}

bool XGenMR::SeExprShader::recFindUserDataFormat( miState* state, MRSeExpression::TLSValues& values, UserDataFormatMap& fmts )
{
	if( !state->instance )
		return false;

	if( findUserDataFormat( state, state->instance, values, fmts ) )
		return true;

	// or the instance's parents
	bool bFound = false;
	{
		miInstance* leaf_inst = (miInstance*)mi_db_access(state->instance);
		miTag* leaf_history =  miLEAFHISTORY(leaf_inst);
		for (miUint l=0; l < leaf_inst->history_size; ++l)
		{
			bFound = findUserDataFormat( state, leaf_history[l], values, fmts );
			if( bFound )
				break;
		}
		mi_db_unpin(state->instance);
	}

	// or the assembly instance's parents
	{
		miTag tagAssemblyInstance = 0;
		mi_query(miQ_PRI_ASSEMBLY_INST_TAG, state, 0, &tagAssemblyInstance);
		
		if( tagAssemblyInstance )
		{
			if( findUserDataFormat( state, tagAssemblyInstance, values, fmts ) )
				return true;
				
			miInstance* leaf_inst = (miInstance*)mi_db_access(tagAssemblyInstance);
			miTag* leaf_history =  miLEAFHISTORY(leaf_inst);
			for (miUint l=0; l < leaf_inst->history_size; ++l)
			{
				bFound = findUserDataFormat( state, leaf_history[l], values, fmts );
				if( bFound )
					break;
			}
			mi_db_unpin(tagAssemblyInstance);
		}
	}

	return bFound;
}

bool XGenMR::SeExprShader::recFindUserDataScalars( miState* state, const float*& scalars, UserDataFormatMap& fmts )
{
	if( !state->instance )
		return false;

	if( findUserDataScalars( state, state->instance, scalars, fmts ) )
		return true;

	// or the instance's parents
	bool bFound = false;
	miInstance* leaf_inst = (miInstance*)mi_db_access(state->instance);
	miTag* leaf_history =  miLEAFHISTORY(leaf_inst);
	for (miUint l=0; l < leaf_inst->history_size; ++l)
	{
		bFound = findUserDataScalars( state, leaf_history[l], scalars, fmts );
		if( bFound )
			break;
	}
	mi_db_unpin(state->instance);

	// or the assembly instance's parents
	{
		miTag tagAssemblyInstance = 0;
		mi_query(miQ_PRI_ASSEMBLY_INST_TAG, state, 0, &tagAssemblyInstance);
		
		if( tagAssemblyInstance )
		{
			if( findUserDataScalars( state, tagAssemblyInstance, scalars, fmts ) )
				return true;
				
			miInstance* leaf_inst = (miInstance*)mi_db_access(tagAssemblyInstance);
			miTag* leaf_history =  miLEAFHISTORY(leaf_inst);
			for (miUint l=0; l < leaf_inst->history_size; ++l)
			{
				bFound = findUserDataScalars( state, leaf_history[l], scalars, fmts );
				if( bFound )
					break;
			}
			mi_db_unpin(tagAssemblyInstance);
		}
	}

	return bFound;
}

bool XGenMR::SeExprShader::findUserDataFormat( miState* state, miTag tagInstance, MRSeExpression::TLSValues& values, UserDataFormatMap& fmts )
{
    int tagInstanceType = mi_db_type(tagInstance);
    if( tagInstanceType != miSCENE_INSTANCE )
        return false;

    bool bFound = false;
    int user_data_size = 0;
    char* user_data_string = NULL;

    UserDataFormatMap::const_iterator it = fmts.find( state->instance );
    if( it==fmts.end() && findXGMRUserDataOnInstance( state, tagInstance, user_data_string, user_data_size ) )
    {
        //printf( "UserDataFormat %s %d %d\n", user_data_string, (int)strlen(user_data_string), (int)user_data_size );
        fmts[state->instance] = UserDataFormat( user_data_string, user_data_size );
        it = fmts.find( state->instance );
    }

    if( it!=fmts.end() )
    {
        for( size_t e=0; e<it->second.getEntryCount(); ++e )
            values[ it->second.getEntry(e)->m_name ] = std::make_pair( SeVec3d(), it->second.getEntry(e)->m_numScalars>1 );
        bFound = true;
    }

    return bFound;
}

bool XGenMR::SeExprShader::findUserDataScalars( miState* state, miTag tagInstance, const float*& scalars, UserDataFormatMap& fmts )
{
    if( mi_db_type(tagInstance) != miSCENE_INSTANCE )
        return false;

    bool bFound = false;
    UserDataFormatMap::const_iterator it = fmts.find( state->instance );
    if( it!=fmts.end() && it->second.getType() == UserDataFormat::eInplace && it->second.getOffsetScalars()>0 )
    {
        int user_data_size = 0;
        char* user_data_string = NULL;
        if( findXGMRUserDataOnInstance( state, tagInstance, user_data_string, user_data_size ) )
        {
            scalars = (const float*)(user_data_string + it->second.getOffsetScalars());
            bFound = true;
        }
    }
    return bFound;
}

// SeExprShader::init, mr init, creates/validates the seexpr, hooks up the variable names/types
void XGenMR::SeExprShader::init( miState* state, Params* paras )
{
	m_pExpression = NULL;
	eval_string( state, paras->expression, m_strExpression );

	m_pExpression = new MRSeExpression();
	m_pExpression->setExpr( m_strExpression.c_str() );

	// No name clashing for now. Must declare the RenderAPI variables in here as well.
	m_strNames.resize(8);
	for( int i=0; i<8; ++i )
	{
		eval_string( state, paras->attrs[i].name, m_strNames[i] );
	}
	
	// Register names from the customs.
	{
		std::string strCustoms;
		eval_string( state, paras->customs, strCustoms );

		std::vector<std::string> customNames;
		XGenMR::split( customNames, strCustoms, "," );
		
		m_strNames.insert( m_strNames.end(), customNames.begin(), customNames.end() );
	}
	
	for( std::vector<std::string>::const_iterator it=m_strNames.begin(); it!=m_strNames.end(); ++it )
	{
		const std::string& s = *it;
		if( s.size()>0 )
			m_declValues[s] = std::make_pair( SeVec3d(), true );
	}
			
	// Add built-in attribute
	for(int i=1; HairUtil::Names[i]!=NULL; ++i )
	{
		m_declValues[ HairUtil::Names[i] ] = std::make_pair( SeVec3d(), true );
	}
	
	// Set TLS values and create the variable references wrappers.
	m_pExpression->setTLSValues(&m_declValues);
	m_pExpression->createRefs();

	// Expression is valid
	if( m_pExpression->syntaxOK() && m_pExpression->isValid() )
	{	
		m_pExpression->setTLSValues(NULL);
	}
	else
	{
		// Print error message
		printf("%s\n", m_pExpression->parseError().c_str() );

		// Clear m_pExpression, ::execute won't query an invalid expression.
		delete m_pExpression;
		m_pExpression = NULL;
	}
}

// Auto Mutex
/////////////////////////////////////////////////////////////////////////////////
SeExprInternal::_Mutex gSeExprEvalMutex;
class AutoSeExprEvalMutex {
public:
	AutoSeExprEvalMutex() {
		gSeExprEvalMutex.lock();
	}
	~AutoSeExprEvalMutex() {
		gSeExprEvalMutex.unlock();
	}
};

// MR execute
/////////////////////////////////////////////////////////////////////////////////
miBoolean XGenMR::SeExprShader::execute( miVector* result, miState* state, Params* paras )
{
	// Start with black result
	result->x = 0.f;
	result->y = 0.f;
	result->z = 0.f;
	
	// Check if the expression is valid. 
	// It can be invalid when the expression didn't validate properly. 
	if( m_pExpression )
	{
		TLSData* pTLSData = NULL;
		MRSeExpression* pExpression = NULL;
		{
			// Check if there's already a TLSData/
			TLSData** ppTLSData = NULL;
			mi_query(miQ_FUNC_TLS_GET, state, miNULLTAG, (void*)&ppTLSData);
			
			// Need to ccreate a new one.
			if( !ppTLSData )
			{
				// Allocate space for the pointer.
				ppTLSData = (TLSData**)mi_mem_allocate(sizeof(TLSData*));
				mi_query(miQ_FUNC_TLS_SET, state, miNULLTAG, &ppTLSData);

				// New TLSData
				pTLSData = new TLSData();
				pExpression = &pTLSData->m_expression;
				*ppTLSData = pTLSData;

				// Initalize the new expressions( since we can't use the copy ctor ).
				pExpression->setExpr( m_strExpression.c_str() );
				pExpression->setTLSValues( &m_declValues );
				pExpression->createRefs();

				// Don't care about the return value. We assume it's been already validate.
				pExpression->syntaxOK();
				pExpression->isValid();
				pExpression->setTLSValues(NULL);
			}
			else // Reuse the already created expression.
			{
				pTLSData = *ppTLSData;
				pExpression = &pTLSData->m_expression;
			}
		}
		
		// Create or reuse the TLSValues from the cache
		MRSeExpression::TLSMap::iterator itC;
		{
			itC = pTLSData->m_cacheTLS.find( state->instance );
			if( itC==pTLSData->m_cacheTLS.end() )
			{	
				MRSeExpression::TLSMapPair insertedPair( state->instance , MRSeExpression::TLSValues() );
				MRSeExpression::TLSMapInsert itI = pTLSData->m_cacheTLS.insert( insertedPair );
				itC = itI.first;
			}
		}
		MRSeExpression::TLSValues& values( itC->second );

		//Overload the values with state variables
		{
			miVector v = {0.f,0.f,0.f};

			// Add built-in attribute first
			for(int i=1; HairUtil::Names[i]!=NULL; ++i )
			{
				if( pExpression->usesVar(HairUtil::Names[i]) )
				{
					
					values[HairUtil::Names[i]] = std::make_pair( SeVec3d( (double)HairUtil::getField(state,(HairUtil::Field)i,HairUtil::x), 
																			(double)HairUtil::getField(state,(HairUtil::Field)i,HairUtil::y), 
																			(double)HairUtil::getField(state,(HairUtil::Field)i,HairUtil::z)), 
																	true );
				}
			}

			// Then shader parameter attributes
			for( int i=0; i<m_strNames.size(); ++i )
			{
				if( m_strNames[i].size()>0 )
				{
					if( pExpression->usesVar(m_strNames[i]) )
					{
						if( i<8 )
							v = *mi_eval_vector( &paras->attrs[i].vec );
						else
							v.x = v.y = v.z = 0.f;
						
						values[m_strNames[i]] = std::make_pair( SeVec3d( (double)v.x, (double)v.y, (double)v.z ), true );
					}
				}
			}

			// Get the XGMR user data from the instance
			{
				UserDataFormatMap& fmts( pTLSData->m_fmts );

				MRSeExpression::TLSValues tmpvalues;
				recFindUserDataFormat( state, tmpvalues, fmts );
	
				// Then parameters from format user data
				UserDataFormatMap::const_iterator it = fmts.find( state->instance );
				if( it!=fmts.end() )
				{
					const float* scalars = NULL;
					if( it->second.getType()==UserDataFormat::eTexList )
						scalars = ((miScalar*)state->tex_list);
					else if( it->second.getType()==UserDataFormat::eInplace )
						recFindUserDataScalars( state, scalars, fmts );

					if( scalars !=NULL )
					{
						for(int i=0; i<it->second.getEntryCount(); ++i )
						{
							const UserDataFormat::Entry* e = it->second.getEntry(i);
							if( pExpression->usesVar(e->m_name) )
							{
								const float* cur = scalars + e->m_offset;
								if( e->m_numScalars==1 )
								{
									values[e->m_name] = std::make_pair( SeVec3d( (double)cur[0], (double)cur[0], (double)cur[0] ), false );
								}
								else if( e->m_numScalars==2 )
								{
									values[e->m_name] = std::make_pair( SeVec3d( (double)cur[0], (double)cur[1], 0.0 ), true );
								}
								else if( e->m_numScalars>=3 )
								{
									values[e->m_name] = std::make_pair( SeVec3d( (double)cur[0], (double)cur[1], (double)cur[2] ), true );
								}
							}
						}
					}
				}
			}
		}
		
		// evaluate the expression with scoped Set/Clean the TLS values
		{
			pExpression->setTLSValues( &values );
			SeVec3d res = pExpression->evaluate();
			pExpression->setTLSValues( NULL );

			// Write to mental ray result
			result->x = (float)res[0];
			result->y = (float)res[1];
			result->z = (float)res[2];
		}
	}

	return miTRUE;
}

// mental ray init callback
/////////////////////////////////////////////////////////////////////////////////
extern "C" DLLEXPORT void xgen_seexpr_init(miState* state, void* paras, miBoolean *inst_init_req )
{
	if (!paras) /* main shader init */
	{
		DEBUG_TRACEP( "xgen_seexpr_init", NULL );
		*inst_init_req = miTRUE; /* want inst inits too */
	} else /* shader instance init */
	{
		void **user;
		mi_query(miQ_FUNC_USERPTR, state, 0, &user);
		SeExprShader* ud = new SeExprShader();
		DEBUG_TRACEP( "xgen_seexpr_init_instance", ud );
		ud->init(state,(SeExprShader::Params*)paras);
		*user = (void*) ud;
	}
}

// mental ray exit callback
/////////////////////////////////////////////////////////////////////////////////
extern "C" DLLEXPORT void xgen_seexpr_exit(miState* state, void* paras) 
{
	if (!paras) /* main shader exit */
	{
		DEBUG_TRACEP( "xgen_seexpr_exit", NULL );
		/* no further inst exits
		 * will occur */
	} else {
		/* shader instance exit */
		
		// Free user data
		{
			void **user;
			mi_query(miQ_FUNC_USERPTR, state, 0, &user);
			SeExprShader* ud = (SeExprShader*) *user;
			DEBUG_TRACEP( "xgen_seexpr_exit_instance", ud );
			delete ud;
			*user = NULL;
		}

		// Free thread local storage
		{
			XGenMR::SeExprShader::TLSData*** ppp;
			int num =0;
			mi_query(miQ_FUNC_TLS_GETALL, state, miNULLTAG, &ppp, &num);
			for (int i=0; i < num; i++)
			{
				XGenMR::SeExprShader::TLSData** pp = ppp[i];
				delete *pp;
				*pp=NULL;
				mi_mem_release(pp);
				pp = NULL;
			}
		}
	}
}

// mental ray version callback
/////////////////////////////////////////////////////////////////////////////////
extern "C" DLLEXPORT int xgen_seexpr_version( void )
{
	return 1;
}

// mental ray execute callback
/////////////////////////////////////////////////////////////////////////////////
extern "C" DLLEXPORT miBoolean xgen_seexpr( miVector* result, miState* state, void* paras ) 
{
	void **user;
	mi_query(miQ_FUNC_USERPTR, state, 0, &user);

	SeExprShader* ud = (SeExprShader*) *user;
	DEBUG_TRACEP( "xgen_seexpr", ud );
	return ud->execute(result, state, (SeExprShader::Params*) paras);
}
