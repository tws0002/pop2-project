// Copyright 2015 Autodesk, Inc.  All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgSeExpr.h
 * @brief Contains the declaration of the class XgSeExpr.
 *
 * <b>CONFIDENTIAL INFORMATION: This software is the confidential and
 * proprietary information of Walt Disney Animation Studios ("WDAS").
 * This software may not be used, disclosed, reproduced or distributed
 * for any purpose without prior written authorization and license
 * from WDAS. Reproduction of any section of this software must include
 * this legend and all copyright notices.
 * Copyright Disney Enterprises, Inc. All rights reserved.</b>
 *
 * @author Brent Burley
 * @author Thomas V Thompson II
 * @author Ying Liu
 * @author Lee Gramling
 * @author Lawrence Chai
 *
 * @version Created 01/01/05
 */

#ifndef XgSeExpr_h
#define XgSeExpr_h

#include <set>
#include <SeExpr/SeExpression.h>
#include <SeExpr/SeExprFunc.h>

class XgExpression;

/**
 * XgSeExpr adds the xgen-specific variable and function bindings to
 * the base SeExpression class (the Shared Expression library used by
 * xgen as well as other products).  It also serves to insulate users
 * of the XgExpression class from the SeExpression implementation
 * details.
 */
class XgSeExpr : public SeExpression
{
 public:
    XgSeExpr(XgExpression* xgexpr) : _xgexpr(xgexpr) { initSymbols(); }
    XgExpression* xgexpr() const { return _xgexpr; }

    virtual void setExpr(const std::string& e);

    /** add function that use external file. node is the expression node of the function. */
    void addPathFunc(SeExprFuncX* func, SeExprFuncNode* node) { 
        _pathFuncList.push_back(func); 
        _pathFuncNodes.push_back(node);
    }
    void getExternalPath(std::vector<std::string> &paths) const;

	static void setMultithreading( bool enable );
	static bool multithreading() { return _multithreading; }

    /** one-time initialization of function and variable defs
	(called automatically by XgSeExpr ctor)
    */
    static void initSymbols();

 protected:
    virtual SeExprVarRef* resolveVar(const std::string& name) const;
    virtual SeExprFunc* resolveFunc(const std::string& name) const;

 private:
    XgExpression* _xgexpr;
    std::vector<SeExprFuncX*> _pathFuncList;
    std::vector<SeExprFuncNode*> _pathFuncNodes;
	static bool _multithreading;
};
#endif
