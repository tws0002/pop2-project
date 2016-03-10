// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

#include "xgTex2DFunc.h"

// SeExpr Entry Point, we must call define3 function pointer to register each SeExpr
extern "C" DLL_EXPORT void SeExprPluginInitV2( SeExprFunc::Define3 define3 )
{
	XgTex2DFunc::define( define3 );
}
