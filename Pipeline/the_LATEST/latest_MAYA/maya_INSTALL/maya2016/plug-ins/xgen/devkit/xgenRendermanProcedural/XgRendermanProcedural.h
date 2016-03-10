// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

#ifndef XGRENDERAPIRENDERMANPROCEDURAL_H
#define XGRENDERAPIRENDERMANPROCEDURAL_H

#include <iostream>
#include <map>
#include <vector>

#include <XGen/XgRenderAPI.h>
using namespace XGenRenderAPI;

/* Define the functions that interface the dso. */
#ifdef __cplusplus
extern "C" RtPointer ConvertParameters(RtString paramstr);
extern "C" RtVoid Subdivide(RtPointer data, RtFloat detail);
extern "C" RtVoid Free(RtPointer data);
#endif

// class RendermanUserData
class RendermanCallbacks : public ProceduralCallbacks
{
public:
	RendermanCallbacks(){}
	~RendermanCallbacks(){}

	virtual void flush(  const char* in_geom, PrimitiveCache* in_cache );
	virtual void log( const char* in_str );

	virtual bool get( EBoolAttribute ) const;
	virtual const char* get( EStringAttribute ) const;
	virtual float get( EFloatAttribute ) const;
	virtual const float* get( EFloatArrayAttribute ) const;
	virtual unsigned int getSize( EFloatArrayAttribute ) const;

	virtual const char* getOverride( const char* in_name ) const;

	virtual bool getArchiveBoundingBox( const char* in_filename, bbox& out_bbox ) const;

	virtual void getTransform( float in_time, mat44& out_mat ) const;
private:

	void flushSplines( const char *geomName, PrimitiveCache* pc );
	void flushCards( const char *geomName, PrimitiveCache* pc );
	void flushSpheres( const char *geomName, PrimitiveCache* pc );
	void flushArchives( const char *geomName, PrimitiveCache* pc );


	/* Output the shader parameters. */
	void pushParams(  std::vector<std::string>& stringdata, std::vector<RtString>& stringhandles, int i, const char *geomName, PrimitiveCache* pc );

	#define PUSHPARAM_DECL( t ) pushParam( std::vector<std::string>& stringdata, int i, PrimitiveCache* pc, PrimitiveCache::EBoolAttribute in_add, PrimitiveCache:: t in_attr, const char* in_shader_parameter, const char* in_message )
	void PUSHPARAM_DECL( EIntArrayAttribute );
	void PUSHPARAM_DECL( EFloatArrayAttribute );
	void PUSHPARAM_DECL( EVec3ArrayAttribute );

	/* Output the custom shader parameters. */
	void pushCustomParams( int i, PrimitiveCache* pc );

	/** The vector of tokens. */
	static std::vector<RtToken> _tokens;

	/** The vector of parameters. */
	static std::vector<RtPointer> _params;

};

// class RendermanUserData
// Wraps PatchRenderer or FaceRenderer in the user data depending on the context
// That way, the same RiProcedural can be invoked in 2 different manners.
class RendermanUserData
{
public:
	RendermanUserData( PatchRenderer* p, FaceRenderer* f )
	{
		m_patch = p;
		m_face = f;
	}
	~RendermanUserData()
	{
		if( m_patch )
			delete m_patch;

		if( m_face )
			delete m_face;
	}

	PatchRenderer* m_patch;
	FaceRenderer* m_face;
};

#endif
