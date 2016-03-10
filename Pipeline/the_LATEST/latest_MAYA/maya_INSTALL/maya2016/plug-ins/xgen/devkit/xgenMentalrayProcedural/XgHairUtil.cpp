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

#include <SePlatform.h>

#include "XgHelpers.h"
#include "XgHairUtil.h"

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

// Names for all the supported fields
const char* XGenMR::HairUtil::Names[] =
{
	"",
	"bary",
	"point",
	"normal",
	"normal_geom",
	"direction",
	"tex",
	"derivs0",
	"derivs1",
	"derivs2",
	"derivs3",
	"derivs4",
	"derivs5",
	"derivs6",
	"derivs7",
	"derivs8",
	"derivs9",
	"scalars0",
	"scalars1",
	"scalars2",
	"scalars3",
	"scalars4",
	"scalars5",
	"scalars6",
	"scalars7",
	"scalars8",
	"scalars9",
	"hair_min_raster_size",
	"hair_raster_area",
	"hair_min_pixel_size",
	"hair_pixel_area",
	"tex_list0",
	"tex_list1",
	"tex_list2",
	"tex_list3",
	"tex_list4",
	"tex_list5",
	"tex_list6",
	"tex_list7",
	"tex_list8",
	"tex_list9",
	NULL
};




XGenMR::UserDataFormat::Entry::Entry()
: m_offset(0)
, m_numScalars(0)
{
}

XGenMR::UserDataFormat::Entry::Entry( const std::string& str, unsigned int offset, unsigned int numScalars )
: m_name(str)
, m_offset(offset)
, m_numScalars(numScalars)
{
	
}

// Checks if name and size are valid.
bool XGenMR::UserDataFormat::Entry::isValid() const
{
	return m_numScalars>0 && m_name.size()>0;
}

// We'll persist all the hair layout information in a custom user data, on the hair object
void XGenMR::UserDataFormat::Entry::toString( std::string& out_str ) const
{
	std::stringstream sstream;
	sstream << m_name << ";" << m_offset << ";" <<  m_numScalars << ";";
	out_str+=sstream.str();
}

XGenMR::UserDataFormat::UserDataFormat()
: m_offsetScalars( 0 )
{

}

XGenMR::UserDataFormat::UserDataFormat( const char* in_str, size_t size )
: m_offsetScalars( 0 )
{
	if( in_str!=NULL && size>0 )
	{
		std::string str = in_str;

		//printf( "%s, %d, %d\n",in_str, (int)str.size(), (int)size);

		// Create from big string
		if( str.size()>0 )
		{
			// This means there's an inplace float buffer after the '\0'
			if( size > str.size()+1 )
			{
				m_offsetScalars = (str.size()+1);
			}

			// Split the string on ';' characters
			std::vector<std::string> tokens;
			XGenMR::split( tokens, str, ";" );

			if( tokens.size()>2 )
			{
				std::vector<std::string>::iterator itLast = tokens.begin() + (tokens.size()-1);
				// Erase empty ending token
				if( itLast->size()==0 )
					tokens.erase( itLast );

				if( tokens.size()>2 )
				{
					// Eat the first token.
					std::vector<std::string>::iterator itFirst = tokens.begin();
					if( *itFirst == "XGMR" )
					{
						tokens.erase( itFirst );

						// Eat the second token.
						std::vector<std::string>::iterator itSecond = tokens.begin();
						if( *itSecond == "1" )
							setType( UserDataFormat::eTexList );
						else if( *itSecond == "2" )
							setType( UserDataFormat::eInplace );
						tokens.erase( itSecond );

						if( getType() != UserDataFormat::eInvalid )
						{
							if(  tokens.size() % 3 == 0 ) // Must be multiple of 3
							{
								for( std::vector<std::string>::const_iterator it=tokens.begin(); it!=tokens.end(); )
								{
									const std::string& name = *(it++);
									unsigned int offset = (unsigned int)atoi( (it++)->c_str() );
									unsigned int numComponents = (unsigned int)atoi( (it++)->c_str() );
									addUserData( name, offset, numComponents );

									m_list.push_back( Entry(name,offset,numComponents) );
								}
							}
						}
					}
				}

			}
		}
	}

}

// We'll persist all the hair layout information in a custom user data, on the hair object
void XGenMR::UserDataFormat::toString( std::string& out_str ) const
{
	if( m_type==eInvalid )
		return;

	if( m_type==eTexList )
		out_str += "XGMR;1";
	else
		out_str += "XGMR;2";

	out_str += ";";

	for( std::map<std::string,Entry>::const_iterator it=m_map.begin(); it!=m_map.end(); ++it )
	{
		it->second.toString(out_str);
	}
}

// register a user data to the list, the map is filled later on by buildMap()
void XGenMR::UserDataFormat::registerUserData( const std::string& str, unsigned int numScalars, int perPoint )
{
	m_list.push_back( Entry( str, (unsigned int)perPoint, numScalars ) );
}

// build the map from the list of registered user data.
// It builds the offsets correctly
void XGenMR::UserDataFormat::buildMap()
{
	int offset = 0;

	for( std::vector<Entry>::iterator it=m_list.begin(); it!=m_list.end(); ++it )
	{
		if( it->m_offset==0 ) // Per hair first.
		{
			addUserData( it->m_name, offset, it->m_numScalars );
			offset += it->m_numScalars;
		}
	}

	for( std::vector<Entry>::iterator it=m_list.begin(); it!=m_list.end(); ++it )
	{
		if( it->m_offset==1 ) // Per point after.
		{
			addUserData( it->m_name, offset, it->m_numScalars );
			offset += it->m_numScalars;
		}
	}
}

// Add a user data to the map. The offset must be known.
bool XGenMR::UserDataFormat::addUserData( const std::string& str, unsigned int offset, unsigned int numScalars )
{
	Entry ud( str, offset, numScalars );
		
	if( !ud.isValid() )
		return false;
		
	m_map[str] = ud;
	return true;
}

XGenMR::UserDataFormat::Entry* XGenMR::UserDataFormat::find( const std::string& str )
{
	std::map<std::string,Entry>::iterator it = m_map.find(str);
	if( it==m_map.end() )
		return NULL;
		
	return &it->second;
}

XGenMR::UserDataFormat::Entry* XGenMR::UserDataFormat::getEntry( size_t i )
{
	return i<m_list.size() ? &m_list[i] : NULL;
}

const XGenMR::UserDataFormat::Entry* XGenMR::UserDataFormat::getEntry( size_t i ) const
{
	return i<m_list.size() ? &m_list[i] : NULL;
}

size_t XGenMR::UserDataFormat::getEntryCount() const
{
	return m_list.size();
}

void XGenMR::HairUtil::init( miState* state, Params* paras )
{
	m_fields[0] = m_fields[1] = m_fields[2] = no_field;
	m_components[0] = m_components[1] = m_components[2] = no_comp;

	eval_string( state, paras->format, m_format );

	// Empty string, log something to list the available names.
	if( m_format.size()==0 )
	{
		
	}
		
	// For now, we just look at names. We don't do any string parsing.
	else if( m_format == "bary" )
	{
		m_fields[0] = m_fields[1] = m_fields[2] = bary;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "point" )
	{
		m_fields[0] = m_fields[1] = m_fields[2] = point;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "normal" )
	{
		m_fields[0] = m_fields[1] = m_fields[2] = normal;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "normal_geom" )
	{
		m_fields[0] = m_fields[1] = m_fields[2] = normal_geom;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}
	else if( m_format == "direction" )
	{
		m_fields[0] = m_fields[1] = m_fields[2] = direction;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "derivs[0]" || m_format == "derivs0")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = derivs0;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "derivs[1]" || m_format == "derivs1")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = derivs1;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "derivs[2]" || m_format == "derivs2")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = derivs2;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "derivs[3]" || m_format == "derivs3")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = derivs3;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "derivs[4]" || m_format == "derivs4")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = derivs4;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "scalars[0]" || m_format == "scalars0")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = scalars0;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "scalars[1]" || m_format == "scalars1")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = scalars1;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "scalars[2]" || m_format == "scalars2")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = scalars2;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "scalars[3]" || m_format == "scalars3")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = scalars3;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "scalars[4]" || m_format == "scalars4")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = scalars4;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "scalars[5]" || m_format == "scalars5")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = scalars5;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "scalars[6]" || m_format == "scalars6")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = scalars6;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "scalars[7]" || m_format == "scalars7")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = scalars7;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "scalars[8]" || m_format == "scalars8")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = scalars8;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "scalars[9]" || m_format == "scalars9")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = scalars9;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}


		
	else if( m_format == "hair_pixel_area")
	{
		m_fields[0] = hair_pixel_area;
		m_components[0] = x;
	}

	else if( m_format == "hair_min_pixel_size")
	{
		m_fields[0] = hair_min_pixel_size;
		m_components[0] = x;
	}

	else if( m_format == "hair_raster_area")
	{
		m_fields[0] = hair_raster_area;
		m_components[0] = x;
	}

	else if( m_format == "hair_min_raster_size")
	{
		m_fields[0] = hair_min_raster_size;
		m_components[0] = x;
	}

	else if( m_format == "tex" )
	{
		m_fields[0] = m_fields[1] = m_fields[2] = tex;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "tex_list[0]" || m_format == "tex_list0")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = tex_list0;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "tex_list[1]" || m_format == "tex_list1")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = tex_list1;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "tex_list[2]" || m_format == "tex_list2")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = tex_list2;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "tex_list[3]" || m_format == "tex_list3")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = tex_list3;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "tex_list[4]" || m_format == "tex_list4")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = tex_list4;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "tex_list[5]" || m_format == "tex_list5")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = tex_list5;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "tex_list[6]" || m_format == "tex_list6")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = tex_list6;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "tex_list[7]" || m_format == "tex_list7")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = tex_list7;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "tex_list[8]" || m_format == "tex_list8")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = tex_list8;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

	else if( m_format == "tex_list[9]" || m_format == "tex_list9")
	{
		m_fields[0] = m_fields[1] = m_fields[2] = tex_list9;
		m_components[0] = x;
		m_components[1] = y;
		m_components[2] = z;
	}

}

// calls getField for the 3 components, based on the what init() picked.
miBoolean XGenMR::HairUtil::execute( miVector* result, miState* state, Params* paras )
{
	result->x = getField( state, m_fields[0], m_components[0] );
	result->y = getField( state, m_fields[1], m_components[1] );
	result->z = getField( state, m_fields[2], m_components[2] );

	return miTRUE;
}

// Texture Helper
bool XGenMR::HairUtil::getTextures( miState *state, int& max_tex, miVector** out_tex  )
{
	// In the case of hair, we need special bits
	miObject_type	obj_type = (miObject_type)-1;
	miTag			obj_tag = miNULLTAG;

	*out_tex = state->tex_list;

	if( state->instance )
	{
		mi_query( miQ_INST_ITEM, NULL, state->instance, (void *)&obj_tag );
		mi_query( miQ_OBJ_TYPE, NULL, obj_tag, (void *)&obj_type );
		if( obj_type == miOBJECT_PLACEHOLDER )
		{
			miTag			real_obj_tag;
			const miObject	*obj = (const miObject *)mi_db_access( obj_tag );
			real_obj_tag = obj->geo.placeholder_list.object;
			obj_type = obj->geo.placeholder_list.type;
			mi_db_unpin( obj_tag );

			obj_tag = real_obj_tag;
		}
	}

	max_tex = 0;

	if( obj_type == miOBJECT_HAIR )
	{
		if( !mi_query( miQ_HAIR_NUM_TEXTURES, state, 0, &max_tex ) )
			return( false );
	}
	else
	{
		if( !mi_query( miQ_NUM_TEXTURES, state, 0, &max_tex ) )
			return( false );
	}

	return( true );
}

// Hair scalars helper
bool XGenMR::HairUtil::getHairScalars( miState *state, int& max_scalars, std::vector<miScalar>& out_scalars )
{
	// In the case of hair, we need special bits
	miObject_type	obj_type = (miObject_type)-1;
	miTag			obj_tag = miNULLTAG;

	if( state->instance )
	{
		mi_query( miQ_INST_ITEM, NULL, state->instance, (void *)&obj_tag );
		mi_query( miQ_OBJ_TYPE, NULL, obj_tag, (void *)&obj_type );
		if( obj_type == miOBJECT_PLACEHOLDER )
		{
			miTag			real_obj_tag;
			const miObject	*obj = (const miObject *)mi_db_access( obj_tag );
			real_obj_tag = obj->geo.placeholder_list.object;
			obj_type = obj->geo.placeholder_list.type;
			mi_db_unpin( obj_tag );

			obj_tag = real_obj_tag;
		}
	}

	max_scalars = 0;

	if( obj_type != miOBJECT_HAIR )
		return false;

	if( !mi_query( miQ_HAIR_NUM_TEXTURES, state, 0, &max_scalars ) )
		return false;

	if( max_scalars>0 )
	{
		out_scalars.resize( max_scalars );
		if( !mi_query( miQ_HAIR_USERS, state, 0, &out_scalars[0] ) )
			return false;
	}

	return true;
}

// Return the data from the miState
float XGenMR::HairUtil::getField( miState* state, Field field, Comp component )
{
	if( field == bary )
	{
		if( component == x )		return state->bary[0];
		else if( component == y )	return state->bary[1];
		else if( component == z )	return state->bary[2];
	}
	else if( field == point )
	{
		if( component == x )		return state->point.x;
		else if( component == y )	return state->point.y;
		else if( component == z )	return state->point.z;
	}
	else if( field == normal )
	{
		if( component == x )		return state->normal.x;
		else if( component == y )	return state->normal.y;
		else if( component == z )	return state->normal.z;
	}
	else if( field == normal_geom )
	{
		if( component == x )		return state->normal_geom.x;
		else if( component == y )	return state->normal_geom.y;
		else if( component == z )	return state->normal_geom.z;
	}
	else if( field == direction )
	{
		if( component == x )		return state->dir.x;
		else if( component == y )	return state->dir.y;
		else if( component == z )	return state->dir.z;
	}
	else if( field == tex )
	{
		if( component == x )		return state->tex.x;
		else if( component == y )	return state->tex.y;
		else if( component == z )	return state->tex.z;
	}
	else if( field >= derivs0 && field <= derivs4 )
	{
		int offset = field - derivs0;
		if( component == x )		return state->derivs[offset].x;
		else if( component == y )	return state->derivs[offset].y;
		else if( component == z )	return state->derivs[offset].z;
	}
	else if( field >= tex_list0 && field <= tex_list9 )
	{

		int offset = field - tex_list0;
			
		// Double check the tex index is valid.
		bool bValid = false;
		miVector* tex_list=NULL;
		{
			int maxTextures=0;
			getTextures( state, maxTextures, &tex_list );

			bValid = ( offset>=0 && offset<maxTextures );
		}

		if( bValid )
		{
			if( component == x )		return state->tex_list[offset].x;
			else if( component == y )	return state->tex_list[offset].y;
			else if( component == z )	return state->tex_list[offset].z;
		}
	}
	else if( field >= scalars0 && field <= scalars9 )
	{

		int offset[3];
		offset[0] = (int)(field - scalars0) * 3;
		offset[1] = offset[0] + 1;
		offset[2] = offset[0] + 2;
			
		// Double check the tex index is valid.
		bool bValid[3] = { false, false, false };
		std::vector<miScalar> scalar_list;
		{
			int maxScalars=0;
			getHairScalars( state, maxScalars, scalar_list );

			bValid[0] = ( offset[0]>=0 && offset[0]<maxScalars );
			bValid[1] = ( offset[1]>=0 && offset[1]<maxScalars );
			bValid[2] = ( offset[2]>=0 && offset[2]<maxScalars );
		}

		if( bValid[0] && component == x )		return scalar_list[offset[0]];
		else if( bValid[1] && component == y )	return scalar_list[offset[1]];
		else if( bValid[2] && component == z )	return scalar_list[offset[2]];
	}
	else if( field>=hair_min_raster_size && field<=hair_pixel_area )
	{
		// Convert the point to world space
		miVector pointWS;
		mi_point_to_world( state, &pointWS, &state->point );

		// get the hair radius fromt he scalars
		float hairRadius = 0.2f; // Todo: 
		{
			
		}
			
		// Get a right and up vector based on the hair tangent.
		miVector xdir, ydir;
		{
			ydir = state->derivs[0];
			mi_normal_to_world( state, &ydir, &state->derivs[0] );
			mi_vector_normalize( &ydir );

			miVector nWS;
			mi_normal_to_world( state, &nWS, &state->normal );
			mi_vector_prod( &xdir, &nWS, &ydir );
			mi_vector_normalize( &xdir );

			mi_vector_prod( &ydir, &nWS, &xdir );
			mi_vector_normalize( &ydir );

			mi_vector_mul( &xdir, hairRadius );
			mi_vector_mul( &ydir, hairRadius );
		}

		// Add or Subtract them to the point to get a the max/min coords of a small rectangle.
		miVector pointWSMin,pointWSMax;
		{
			miVector tmp;
			mi_vector_sub( &tmp, &pointWS, &xdir );
			mi_vector_sub( &pointWSMin, &tmp, &ydir );

			mi_vector_add( &tmp, &pointWS, &xdir );
			mi_vector_add( &pointWSMax, &tmp, &ydir ); 
		}

		// Convert to raster space
		miVector pointRSMin,pointRSMax;
		{
			miVector pointISMin,pointISMax;
			mi_point_from_world( state, &pointISMin, &pointWSMin );
			mi_point_from_world( state, &pointISMax, &pointWSMax );

			mi_point_to_raster( state, &pointRSMin, &pointISMin );
			mi_point_to_raster( state, &pointRSMax, &pointISMax );
		}

		// put in 0..1 range if needed
		if( field==hair_min_raster_size || field==hair_raster_area )
		{
			pointRSMin.x /= (miScalar)state->camera->x_resolution;
			pointRSMin.y /= (miScalar)state->camera->y_resolution;
			pointRSMax.x /= (miScalar)state->camera->x_resolution;
			pointRSMax.y /= (miScalar)state->camera->y_resolution;
		}

		// Cmpute the size in projected rectangle size in x and y
		float xSize = fabs( pointRSMax.x - pointRSMin.x );
		float ySize = fabs( pointRSMax.y - pointRSMin.y );

		// Return the min 
		if( field==hair_min_raster_size || field==hair_min_pixel_size )
		{
			return xSize < ySize ? xSize : ySize;
		}
			
		// Return the area
		else
		{
			return sqrt( xSize*xSize + ySize*ySize );
		}
	}

	return 0.0;
}

// mental ray init callback
/////////////////////////////////////////////////////////////////////////////////
extern "C" DLLEXPORT void xgen_hair_util_init( miState* state, void* paras, miBoolean *inst_init_req )
{
	if (!paras) /* main shader init */
	{
		DEBUG_TRACEP( "xgen_hair_util_init", NULL );
		*inst_init_req = miTRUE; /* want inst inits too */
	} else /* shader instance init */
	{
		void **user;
		mi_query(miQ_FUNC_USERPTR, state, 0, &user);
		HairUtil* ud = new HairUtil();
		DEBUG_TRACEP( "xgen_hair_util_init_instance", ud );
		ud->init(state,(HairUtil::Params*)paras);
		*user = (void*) ud;
	}
}

extern "C" DLLEXPORT void xgen_hair_util_exit(miState* state, void* paras)
{
	if (!paras) /* main shader exit */
	{
		DEBUG_TRACEP( "xgen_hair_util_exit", NULL );
		/* no further inst exits
		 * will occur */
	} else {
		/* shader instance exit */
		void **user;
		mi_query(miQ_FUNC_USERPTR, state, 0, &user);
		HairUtil* ud = (HairUtil*) *user;
		DEBUG_TRACEP( "xgen_hair_util_exit_instance", ud );
		delete ud;
		*user = NULL;
	}
}

extern "C" DLLEXPORT int xgen_hair_util_version( void ) 
{
	return 1;
}

extern "C" DLLEXPORT miBoolean xgen_hair_util( miVector* result, miState* state, void* paras )
{
	void **user;
	mi_query(miQ_FUNC_USERPTR, state, 0, &user);

	HairUtil* ud = (HairUtil*) *user;
	DEBUG_TRACEP( "xgen_hair_util", ud );
	return ud->execute(result, state, (HairUtil::Params*) paras);
}

extern "C" DLLEXPORT int xgen_scalar_to_integer_version( void ) 
{
	return 1;
}

extern "C" DLLEXPORT miBoolean xgen_scalar_to_integer( miInteger* result, miState* state, miScalar* input )
{
	*result = (miInteger)*mi_eval_scalar( input );

	return miTRUE;
}

extern "C" DLLEXPORT int xgen_integer_to_vector_version( void ) 
{
	return 1;
}

extern "C" DLLEXPORT miBoolean xgen_integer_to_vector( miVector* result, miState* state, miInteger* input )
{
	result->x = result->y = result->z = (miScalar)*mi_eval_integer( input );

	return miTRUE;
}

extern "C" DLLEXPORT int xgen_scalar_to_vector_version( void ) 
{
	return 1;
}

extern "C" DLLEXPORT miBoolean xgen_scalar_to_vector( miVector* result, miState* state, miScalar* input )
{
	result->x = result->y = result->z = *mi_eval_scalar( input );

	return miTRUE;
}

extern "C" DLLEXPORT int xgen_vector_to_scalar_version( void )
{
	return 1;
}

struct xgen_vector_to_scalar
{
	miVector input;
	miInteger selector;
};

extern "C" DLLEXPORT miBoolean xgen_vector_to_scalar( miScalar* result, miState* state, xgen_vector_to_scalar* paras )
{
	miVector  v = *mi_eval_vector( &paras->input );
	miInteger s = *mi_eval_integer( &paras->selector );
	switch( s )
	{
	case 0: *result = v.x; break;
	case 1: *result = v.y; break;
	case 2: *result = v.z; break;
	default: *result = 0.f; break;
	}
	return miTRUE;
}

extern "C" DLLEXPORT int xgen_boolean_to_vector_version( void ) 
{
	return 1;
}

extern "C" DLLEXPORT miBoolean xgen_boolean_to_vector( miVector* result, miState* state, miBoolean* input )
{
	result->x = result->y = result->z = *mi_eval_boolean( input ) ? 1.f : 0.f;

	return miTRUE;
}

extern "C" DLLEXPORT int xgen_boolean_switch_version( void ) 
{
	return 1;
}

struct xgen_boolean_switch
{
    miBoolean input;
    miColor colorOn;
    miColor colorOff;
};

extern "C" DLLEXPORT miBoolean xgen_boolean_switch( miColor* result, miState* state, xgen_boolean_switch* paras )
{
	*result = *mi_eval_boolean( &paras->input ) ? *mi_eval_color(&paras->colorOn) : *mi_eval_color(&paras->colorOff);

	return miTRUE;
}

extern "C" DLLEXPORT int xgen_tube_normals_version( void ) 
{
	return 1;
}

void compute_tube_normal( miVector& tubeNormal, miState* state, bool inverted )
{
	miVector nn = state->normal;
	mi_vector_normalize( &nn );
	if( inverted )
	{
		mi_vector_neg( &nn );
	}

	miVector nt = state->derivs[0];
	mi_vector_normalize( &nt );

	miVector nxt;
	mi_vector_prod( &nxt, &nn, &nt );

	miVector txn = nxt;
	mi_vector_neg( &txn );
	

	const miScalar u = state->bary[0]*M_PI;
	const miScalar cosu = cos(u);
	const miScalar sinu = sin(u);

	miVector w = { cosu, 1.f-cosu, sinu };
	mi_vector_normalize(&w);

	mi_vector_mul( &nxt, w.x );
	mi_vector_mul( &txn, w.y );
	mi_vector_mul( &nn,  w.z );
	
	tubeNormal.x = nxt.x + txn.x + nn.x;
	tubeNormal.y = nxt.y + txn.y + nn.y;
	tubeNormal.z = nxt.z + txn.z + nn.z;
	mi_vector_normalize(&tubeNormal);
}

struct xgen_tube_normals_struct
{
	miColor input;
	miBoolean enabled;
	miScalar tube_blend;
	miScalar flat_blend;
};

struct xgen_tube_normals_params
{
	xgen_tube_normals_struct inputs[2];
};

miBoolean eval_xgen_tube_normals( miColor* result, miState* state, xgen_tube_normals_struct* paras )
{
	miBoolean enabled = *mi_eval_boolean( &paras->enabled );

	miVector oldNormal={0.f,0.f,0.f};
	miVector oldGeomNormal={0.f,0.f,0.f};
	if( enabled == miTRUE )
	{
		oldNormal = state->normal;
		oldGeomNormal = state->normal_geom;

		miVector tubeNormal;
		miScalar tube_blend = *mi_eval_scalar(&paras->tube_blend);
		compute_tube_normal( tubeNormal, state, tube_blend<0.0f );
		mi_vector_mul( &tubeNormal, fabs(tube_blend) );

		miScalar flat_blend = *mi_eval_scalar(&paras->flat_blend);
		if( flat_blend<0.f )
		{
			mi_vector_neg( &state->normal );
		}
		mi_vector_mul( &state->normal, fabs(flat_blend) );

		mi_vector_add( &state->normal, &state->normal, &tubeNormal );
		mi_vector_normalize(&state->normal);
	}

	*result = *mi_eval_color( &paras->input );

	if( enabled == miTRUE )
	{
		state->normal = oldNormal;
		state->normal_geom = oldGeomNormal;
	}

	return miTRUE;
}

extern "C" DLLEXPORT miBoolean xgen_tube_normals( miColor* result, miState* state, xgen_tube_normals_params* paras )
{

	miColor result0={0.f,0.f,0.f,0.f};
	eval_xgen_tube_normals( &result0, state, &paras->inputs[0] );

	miColor result1={0.f,0.f,0.f,0.f};
	eval_xgen_tube_normals( &result1, state, &paras->inputs[1] );

	result->r = result0.r + result1.r*result1.a;
	result->g = result0.g + result1.g*result1.a;
	result->b = result0.b + result1.b*result1.a;
	result->a = result0.a;

	return miTRUE;
}
