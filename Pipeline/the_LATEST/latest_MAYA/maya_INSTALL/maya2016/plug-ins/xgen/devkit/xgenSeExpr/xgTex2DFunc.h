// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

#ifndef __XGTEX2DEXPRFUNC_H__
#define __XGTEX2DEXPRFUNC_H__

#include <OpenImageIO/texture.h>
#include <OpenImageIO/imageio.h>

#include <SeExprFunc.h>
#include <SeExprNode.h>

// Easier namespace for the eyes
namespace oiio
{
typedef OIIO_NAMESPACE::OIIO_VERSION_NS::TextureSystem 						TextureSystem;
typedef OIIO_NAMESPACE::OIIO_VERSION_NS::TextureSystem::TextureHandle  		TextureHandle;
typedef OIIO_NAMESPACE::OIIO_VERSION_NS::TextureSystem::Perthread  			Perthread;
typedef OIIO_NAMESPACE::OIIO_VERSION_NS::ImageSpec 							ImageSpec;
typedef OIIO_NAMESPACE::OIIO_VERSION_NS::TextureOpt  						TextureOpt;
typedef OIIO_NAMESPACE::OIIO_VERSION_NS::ustring 							ustring;

}

/**
 * Implement texture function based on OpenImageIO: tex2d(path, [u, v,] [chan])
 */
class XgTex2DFunc : public SeExprFuncX
{
public:
	XgTex2DFunc():SeExprFuncX(false){}

	virtual bool prep( SeExprFuncNode* node, bool wantVec );
	virtual void eval( const SeExprFuncNode* node, SeVec3d& result ) const;

	static void define( SeExprFunc::Define3 define3 );
	static oiio::TextureSystem* texSys();

protected:

	// Data for our expression.
	struct Data : public SeExprFuncNode::Data
	{
		Data()
		: txh(NULL)
		, pti(NULL)
		, flip(false)
		, pal(false)
		, channel( 0 )
		, nchannels( 0 )
		, u( 0.f )
		, v( 0.f )
		, dudx( 0.f )
		, dvdx( 0.f )
		, dudy( 0.f )
		, dvdy( 0.f )
		{}
		oiio::TextureHandle *txh;
		oiio::Perthread *pti;
		oiio::TextureOpt opt;
		std::string path;
		int channel;
		int nchannels;
		float u, v, dudx, dvdx, dudy, dvdy;
		bool flip;
		std::string dataPath;
		std::string patchName;
		std::string fileName;
		bool pal;
	};

	bool setup( Data* data, const SeExprFuncNode* node ) const;
};

#endif
