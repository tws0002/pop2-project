#ifndef XGRENDERERCONTEXT_H
#define XGRENDERERCONTEXT_H

#include "XGen/XgUtil.h"

class XGEN_EXPORT XgRendererContext
{
	friend class XgRenderer;
	friend class XgGLRenderer;
	friend class XgFileRenderer;
    friend class XgNullRenderer;
    friend class XgGuideRenderer;

public:
    XgRendererContext() : _emitCount(0), _totalEmitCount(0) {}
    virtual ~XgRendererContext() {}

	int totalEmitCount() { return _totalEmitCount; }
	void incrEmitCount() { _emitCount++; }

protected:

	/** Counter for number of primitives actually rendered. */ 	  	 
	unsigned int _emitCount; 	  	 
	unsigned int _totalEmitCount;

	/** Timer variables. */
	xgutil::TimerVal _timePatch;

	/** Maximum computed "primBound" across a whole description */
	double _maxBound;

	/** The computed bounding box for a face's prims */
	SgBox3d _faceBBox;

	/** Necessary because previewers are renderers too. */
	bool _isRendering;
};

#endif

// ==================================================================
// Copyright 2014 Autodesk, Inc.  All rights reserved.
// 
// This computer source code  and related  instructions and comments are
// the unpublished confidential and proprietary information of Autodesk,
// Inc. and are  protected  under applicable  copyright and trade secret
// law. They may not  be disclosed to, copied or used by any third party
// without the prior written consent of Autodesk, Inc.
// ==================================================================
