// Copyright 2014 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgExprContext.h
 * @brief Contains the per thread state when evaluate a expression.
 *
 * @author Nian Wu
 *
 * @version Created 03/18/2013
 */

#ifndef XGEXPRCONTEXT_H
#define XGEXPRCONTEXT_H

#include "XGen/XgDict.h"
#include "XGen/SgVec3T.h"

class XgExpression;
class XgDescription;
class XgPrimitiveContext;

#define MAX_EXPR_EVAL_LEVEL 1000

/**
 * @brief per thread state when evaluate a expression.
 *
 * Expression belongs to description. The state inside description should be 
 * thread local when parallelize the evaluation.
 */
class XgExprContext
{
public:
	XgExprContext() :
        _evalLevel(0),
        _patchName(NULL),
        _lastFaceId(-1),
        _lastDescriptionId(-1),
        _faceSeed(0),
        _curDescription(NULL),
        _primContext(NULL)
	{
	}

	~XgExprContext() { }

    void reset( XgPrimitiveContext* primContext )
    {
        _evalLevel = 0;
        _lastPatchName = "";
        _patchName = NULL;
        _lastFaceId = -1;
        _lastDescriptionId = -1;
        _faceSeed = 0;
        _curDescription = NULL;
        _primContext = primContext;
    }

	// Is evaluating a nested expression
	bool inNestedExpr()
	{
		return _evalLevel > 1;
	}

	// Is evaluating an expression
	bool isEvaluatingExpr()
	{
		return _evalLevel > 0;
	}

	// Is evaluating an expression recursively
	bool isRecursiveEval()
	{
		return _evalLevel > MAX_EXPR_EVAL_LEVEL;
	}

	void intoEval() { _evalLevel++; }
	void outEval()  { _evalLevel--; }


	/** Nested expression level. */
	int _evalLevel;

	/** The name of the patch being evaluated (may be null) */
	const std::string *_patchName;

	/** 'u' value being evaluated. */
	double _u;

	/** 'v' value being evaluated. */
	double _v;

	/** face id being evaluated. */
	int _faceId;

	/** The description owning this expression. 
	 *
	 *  For normal object attribute expression, its description is determined.
	 *  For palette attribute expression, it can be called by expression in
	 *  different description (refer to XgSeExpr::XgPalFunc). So the description
	 *  member should be TLS.
	 */
	XgDescription *_curDescription;

	/** face id being evaluated. */
	int _lastFaceId;

	/** Last description ID being evaluated. */
	int _lastDescriptionId;

	/** The name of the last patch being evaluated (may be empty) */
	std::string _lastPatchName;

	/** Random number face seed. */
	double _faceSeed;

    XgPrimitiveContext* _primContext;

    /** Custom variables. */
    XgDict<SgVec3d> _customVariables;
};

#endif
