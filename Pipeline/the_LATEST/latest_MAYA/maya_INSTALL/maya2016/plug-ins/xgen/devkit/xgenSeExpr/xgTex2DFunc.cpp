// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

// SeExpr includes
#include <SeExprFunc.h>
#include <SeExprNode.h>

// Xgenincludes
#include <XGen/XgDescription.h>
#include <XGen/XgExpression.h>
#include <XGen/XgPalette.h>
#include <XGen/XgPatch.h>
#include <XGen/XgSeExpr.h>
#include <XGen/XgUtil.h>

#include "xgTex2DFunc.h"

// Cast the base SeExpr to XgExpression.
// It means our SeExpr is only going to work within Xgen.
inline XgExpression* getXgExpr(const SeExprNode* node)
{
	return static_cast<const XgSeExpr*>(node->expr())->xgexpr();
}

// Clear Callback
void clearOpenImageIO()
{
	XgTex2DFunc::texSys()->clear();
}

// Entry Point, we must call define3 to register each SeExpr
void XgTex2DFunc::define( SeExprFunc::Define3 define3 )
{
	// Register our Tex2D SeExpr
	{
		static XgTex2DFunc func;
		static const char* d="color tex2d( path, [u, v,] [chan]\n2D texture lookup using OpenImageIO";
		define3( "tex2d", SeExprFunc(func, 1, 4), d );
	}

	// Register a callback to get called when Xgen flush it's image caches.
	static bool s_bInit = true; // Just in case this gets called multiple times.
	if( s_bInit )
	{
		s_bInit = false;
		XgExpression::registerClearCache( clearOpenImageIO );
	}
}

// Keep a single static instance of TextureSystem
oiio::TextureSystem* XgTex2DFunc::texSys()
{
	static oiio::TextureSystem* s_texSys = oiio::TextureSystem::create( false );
	return s_texSys;
}

bool XgTex2DFunc::prep(SeExprFuncNode* node, bool wantVec)
{
	// first, check string arg if present
	if (node->nargs() >= 1 && !node->isStrArg(0))
	{
		node->child(0)->addError(std::string("First arg must be a string for function ") + node->name());
		return 0;
	}

	/* prep remaining children.  By default, these functions want
	   scalar args and return a scalar result. */
	for (int i = 1; i < node->nargs(); i++)
	{
		SeExprNode* child = node->child(i);
		if (!child->prep(0))
			return 0;
	}

	node->setIsVec(wantVec);
	Data* data = new Data;
	node->setData(data);
	data->path = xgutil::stripNameSpace(node->getStrArg(0));

	// If the expression is not using the PAL macro we can gain
	// some efficiency by not expanding on each call.
	std::string::size_type pos = (data->path).find("${PAL,");
	if ( pos != std::string::npos )
	{
		data->pal = true;
	}

	return 1;
}

void XgTex2DFunc::eval(const SeExprFuncNode* node, SeVec3d& result) const
{
	Data* data = static_cast<Data*>(node->getData());
	if ( !setup(data, node) ) { result = 0.001; return; }

	oiio::TextureHandle*& txh = data->txh;

	// Get the pixel value as a float
	float pix[4];
	texSys()->texture( txh, data->pti, data->opt, data->u, data->v, data->dudx, data->dvdx, data->dudy, data->dvdy, pix );

	if ( data->channel >= 0 )
	{
		// User specified a particular channel
		int channel = std::min(data->channel,data->nchannels-1);
		result[0] = pix[channel];
		if ( node->isVec() ) {
			result[1] = result[2] = result[0];
		}
	}
	else
	{
		// Get each channel in the corresponding vector component.
		switch(data->nchannels)
		{
			case 1:
				result[0] = pix[0];
				if ( node->isVec() )
				{
					result[1] = result[2] = result[0];
				}
				break;
			case 2:
				result[0] = pix[0];
				if ( node->isVec() )
				{
					result[1] = result[2] = pix[1];
				}
				break;
			default:
				result[0] = pix[0];
				if ( node->isVec() )
				{
					result[1] = pix[1];
					result[2] = pix[2];
				}
		}
	}
	data->txh = NULL;
	data->pti = NULL;
}


bool XgTex2DFunc::setup(Data* data, const SeExprFuncNode* node) const
{
	XgExpression* expr = getXgExpr(node);
		if (!expr) return false;

	int nargs = node->nargs();
    SeExprFuncArgData args(nargs);
    node->evalArgs(args);

	XgDescription* desc = expr->description();
	const std::string* patchName = expr->patchName();
	if (!desc || !patchName || !desc->palette())
	{
		return false;
	}

	if ( ( data->patchName != *patchName ) ||
		 ( data->dataPath != desc->palette()->xgDataPathStr() ) ||
		 ( data->pal ) )
	{

		// Find the file in the xgPath.
		if ( !xgutil::findFileInXgDataPath( data->fileName, data->path, *patchName, desc ) )
		{
			return false;
		}

		// See if we need to flip
		XgPatch *patch = desc->patch( *patchName );
		if ( patch && patch->typeName() == "NurbsPatch" )
		{
			data->flip = true;
		}
		else
		{
			data->flip = false;
		}
		data->patchName = *patchName;
		data->dataPath = desc->palette()->xgDataPathStr();
	}

	oiio::ustring ustrFilename( data->fileName.c_str() );

	// Get new texture maps
	data->pti = texSys()->get_perthread_info();
	data->txh = texSys()->get_texture_handle( ustrFilename, data->pti );
	if ( !data->txh )
		return false;

	// Get the number of channels
	{
		const oiio::ImageSpec* txSpec = texSys()->imagespec( ustrFilename );
		if ( !txSpec )
			return false;
		data->nchannels =  txSpec->nchannels;

		// Clamp it
		if( data->nchannels>3 )
			data->nchannels = 3;
	}

	// Set texture options. All default except the number of channels.
	{
		data->opt.nchannels = data->nchannels;
	}

	// Eval args, check for the u,v override and channel number
	if ( nargs >= 3 )
	{
		data->u = (float)args[1][0];
		data->v = (float)args[2][0];
	}
	else
	{
		data->u = (float)expr->u();
		data->v = (float)expr->v();
	}

	data->channel = (nargs == 2 || nargs == 4) ?
			int(args[nargs-1][0]) : -1;

	// Do the flip math
	if ( !data->flip )
		data->v = 1.0 - data->v;

	return true;
}

