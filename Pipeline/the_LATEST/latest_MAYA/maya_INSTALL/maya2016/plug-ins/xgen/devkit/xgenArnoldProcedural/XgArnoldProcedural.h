// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

#ifndef __XGENARNOLDPROCEDURAL_H__
#define __XGENARNOLDPROCEDURAL_H__

#include <vector>

#include <XGen/XgRenderAPI.h>
using namespace XGenRenderAPI;

// Forward Decl
class AtNode;
struct AtArray;

namespace XGenArnold
{
	class Procedural : public ProceduralCallbacks
	{
	public:
		Procedural();
		virtual ~Procedural();

		// Arnold Entry points.
		int Init(AtNode* node);
		int Cleanup();
		int NumNodes();
		AtNode* GetNode(int i);

		// XGenRenderAPI::ProceduralCallbacks
		virtual void flush(  const char* in_geom, PrimitiveCache* in_cache );
		virtual void log( const char* in_str ){}

		virtual bool get( EBoolAttribute ) const;
		virtual const char* get( EStringAttribute ) const;
		virtual float get( EFloatAttribute ) const;
		virtual const float* get( EFloatArrayAttribute ) const;
		virtual unsigned int getSize( EFloatArrayAttribute ) const;

		virtual const char* getOverride( const char* in_name ) const;
		virtual bool getArchiveBoundingBox( const char* in_filename, bbox& out_bbox ) const;
		virtual void getTransform( float in_time, mat44& out_mat ) const;

	private:
		// These 4 methods are protected by the global mutex.
		bool nextFace( bbox& b, unsigned int& f );
		bool initPatchRenderer( const char* in_params );
		bool initFaceRenderer( Procedural* pProc, unsigned int f );
		bool render();

		void flushSplines( const char *geomName, PrimitiveCache* pc );
		void flushCards( const char *geomName, PrimitiveCache* pc );
		void flushSpheres( const char *geomName, PrimitiveCache* pc );
		void flushArchives( const char *geomName, PrimitiveCache* pc );

		bool getString( AtNode* in_node, const char* in_name, const char*& out_value, bool in_user=false ) const;
		bool getFloat( AtNode* in_node, const char* in_name, float& out_value, bool in_user=false  ) const;

		unsigned int getArraySize( AtNode* in_node, const char* in_name, int in_eType, bool in_user=false  ) const;
		bool getFloatArray( AtNode* in_node, const char* in_name, const float*& out_value, bool in_user=false  ) const;
		bool getMatrixArray( AtNode* in_node, const char* in_name, const AtMatrix*& out_value, bool in_user=false  ) const;

		static void pushCustomParams( AtNode* in_node, PrimitiveCache* pc );

		static void convertMatrix( const AtMatrix in_mat, mat44& out_mat );

		const char* getUniqueName( char* buf, const char* basename );

		AtNode* getArchiveProceduralNode( const char* file_name, const char* instance_name, const bbox& arcbox, double frame );

		AtNode* m_node;
		AtNode* m_node_face;
		AtNode* m_options;
		AtNode* m_camera;
		AtNode* m_sphere;
		AtArray* m_shaders;

		PatchRenderer* m_patch;
		FaceRenderer* m_face;

		std::vector<AtNode*> m_nodes;
	};

	class ProceduralWrapper
	{
	public:
		ProceduralWrapper( Procedural* p, bool cleanup=true )
		{
			m_proc = p;
			m_cleanup = cleanup;
		}
		~ProceduralWrapper()
		{
			if( m_proc && m_cleanup )
				delete m_proc;

			m_proc = NULL;
		}

		int Init(AtNode* node) { return m_proc->Init(node); }
		int Cleanup() { return m_proc->Cleanup(); }
		int NumNodes() { return m_cleanup ? 0 : m_proc->NumNodes(); }
		AtNode* GetNode(int i) { return m_cleanup ? NULL : m_proc->GetNode(i); }



	private:
		Procedural* m_proc;
		bool m_cleanup;
	};
};

#endif

