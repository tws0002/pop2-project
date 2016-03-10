// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgExpression.h
 * @brief Contains the declaration of the class XgExpression.
 *
 * <b>CONFIDENTIAL INFORMATION: This software is the confidential and
 * proprietary information of Walt Disney Animation Studios ("WDAS").
 * This software may not be used, disclosed, reproduced or distributed
 * for any purpose without prior written authorization and license
 * from WDAS. Reproduction of any section of this software must include
 * this legend and all copyright notices.
 * Copyright Disney Enterprises, Inc. All rights reserved.</b>
 *
 * @author Thomas V Thompson II
 * @author Ernie Petti
 *
 * @version Created 05/23/02
 */

#ifndef XGEXPRESSION_H
#define XGEXPRESSION_H

#include <iostream>
#include <string>
#include "XgPorting/safevector.h"
#include <set>

#include <tbb/mutex.h>
#include <tbb/concurrent_unordered_set.h>
#include <tbb/enumerable_thread_specific.h>

#include "XgExprContext.h"
#include "XGen/SgVec3T.h"
#include "XGen/XgDict.h"
#include "XgWinExport.h"
#include "XGen/XgSeExpr.h"	// Turbo: for XgSeExpr::multithreading()
#include "XGen/XgObject.h"  // For define of XgExternalContentInfoTable

class PtexTexture;
class PtexCache;
class XgDescription;
class XgPalette;
class XgPatch;
class SeExpression;

typedef tbb::enumerable_thread_specific< XgExprContext > XgExprContextTLS;
extern XgExprContextTLS xgExprContext;

/**
 * @brief A base expression class for attributes.
 *
 * This class stores and evaluates attribute expressions. The expressions
 * held in the class can have several predefined function calls, shadow
 * pass specific properties, as well as the usual operations. Any portions
 * of an expression that are environment specific (for instance mel commands
 * within the Maya environment) must be evaluated and replaced prior to this
 * class receiving the expression.
 *
 * Predefined variables: $g, $frame ...
 * Predefined functions: map, clamp, rand, shadow, ...
 * Valid expression types: float, color, point, vector, normal. 
 */
class XGEN_EXPORT XgExpression
{
public:

    /* Attribute expression constructors. */
    XgExpression( const std::string &name,
                  const std::string &objectType,
                  XgDescription *descr,
                  const std::string &e = "0.0",
                  const std::string &type = "float" );

    /* Destructor. */
    ~XgExpression();

    /** Assignment operator from string. */
    XgExpression &operator =( const std::string &e )
        { setExpression( e ); return *this; }

    /** Initialize the thread local data when a thread start up. */
    static void initTLS(XgPrimitiveContext* primContext = NULL);
    /** release the variables of TLS. */
    static void clearTLS() { 
        xgExprContext.clear();
        SeExpression::clearTLS();
    }

    /* Find palette expression for a given attribute name and description. */
    static XgExpression *paletteAttr( const std::string &name,
                                      const XgDescription *descr );

    /* Clear the texture map cache. */
    static void clearPtexs();

    /* Get an image from the map cache. Load and cache if not loaded yet. */
    static PtexTexture* getPtex(const std::string &filename);

    /* Check the syntax of an expression. */
    bool syntaxOK(std::string* errorMessage=0) const;

    /* Check the validity (syntax and variables) of an expression. */
    bool isValid(std::string* errorMessage=0) const;

    /* Shadow pass accessors. */
    static void setShadowPass( bool flag ) { _shadowPass = flag; }
    static bool shadowPass() { return _shadowPass; }
    
    /* Evaluate the expression. */
	void setPatchAndFaceId( const XgPatch* patch, int faceId );
    SgVec3d eval( double u = 0, double v = 0, int faceId = 0,
                  const std::string *patchName = 0 ) const;

    /* Bake attribute map for the given attribute, filename,.. */
    unsigned char * faceMap( const std::string &patchName,
                             unsigned short xRes, 
                             unsigned short yRes,
                             double minVal, 
                             double maxVal ) const;
        
    /** @name Parse Info */
    //@{
    bool isConstant() const;
    bool usesFunc( const std::string &func ) const;
    bool usesVar( const std::string &var ) const;
    //@}
    
    /** @name Custom variables. */
    //@{
    static void setCustomVariable( const std::string &name, const SgVec3d &val )
    { 
        XgExprContextTLS::reference exprContext = xgExprContext.local();
        exprContext._customVariables[name.c_str()] = val; 
    }

    static void setCustomVariable( const std::string &name, const double val )
    { 
        XgExprContextTLS::reference exprContext = xgExprContext.local();
        exprContext._customVariables[name.c_str()] = SgVec3d(val); 
    }
    static bool getCustomVariable( const std::string &name, SgVec3d &val );
    static void removeCustomVariable( const std::string &name )
    { 
        XgExprContextTLS::reference exprContext = xgExprContext.local();
        exprContext._customVariables.erase( name.c_str() ); 
    }
    static void removeAllCustomVariables()
    { 
        XgExprContextTLS::reference exprContext = xgExprContext.local();
        exprContext._customVariables.clear(); 
    }

    //@}    
    
    /** @name Accessors. */
    //@{
    const std::string &expression() const;
    void setExpression( const std::string &e );
    XgDescription *description() const { 
		if (XgSeExpr::multithreading()) {
            XgExprContextTLS::reference exprContext = xgExprContext.local();
			if (exprContext.inNestedExpr())
				return exprContext._curDescription;
		}

		return _description; 
	}
    void setDescription( XgDescription *d ) {
		if (XgSeExpr::multithreading()) {
            XgExprContextTLS::reference exprContext = xgExprContext.local();
			if (exprContext.isEvaluatingExpr())
				exprContext._curDescription = d;
		}

		_description = d; 
	}
    const std::string &name() const { return _name; }
    const std::string &type() const { return _type; }
    bool isVec() const { return _type != "float"; }
    void setType( const std::string &type );
    const std::string *patchName() const { 
		if (XgSeExpr::multithreading()) {
		    XgExprContextTLS::reference exprContext = xgExprContext.local();
            return  exprContext._patchName;
        }
		else
			return _patchName; 
	}
    double u() const { 
		if (XgSeExpr::multithreading()) {
            XgExprContextTLS::reference exprContext = xgExprContext.local();
			return  exprContext._u;
        }
		else 
			return _u; 
	}
    double v() const { 
		if (XgSeExpr::multithreading()) {
            XgExprContextTLS::reference exprContext = xgExprContext.local();
			return  exprContext._v;
        }
		else 
			return _v; 
	}
    int faceId() const {
		if (XgSeExpr::multithreading()) {
		    XgExprContextTLS::reference exprContext = xgExprContext.local();
            return  exprContext._faceId;
        }
		else 
			return _faceId; 
	}
    double exprSeed() const { return _exprSeed; }
    double faceSeed() const { 
		if (XgSeExpr::multithreading()) {
            XgExprContextTLS::reference exprContext = xgExprContext.local();
			return  exprContext._faceSeed;
        }
		else 
			return _faceSeed; 
	}
    int nextRandInstance() const { return _randInstance++; }
    int randInstance() const { return _randInstance; }
    void setRandInstance( int randInstance ) const 
            { _randInstance = randInstance; }

    SeExpression* seExpr()
    {
        return (SeExpression*)_expr;
    }

    //@} 
   
    /** @name Clear Cache Callbacks. */
    //@{
    typedef void (*clearCacheFunc)();
    static void registerClearCache( clearCacheFunc f) 
	{ 
		_clearCacheCallbacks.insert(f); 
	}
    //@}

    //@} 
   
    /** @name Recursivity handling. */
    //@{
    static bool recursing()
    {
        return _recursing;
    }

    static void setRecursivityFlag(bool flag)
    {
        _recursing = flag;
    }
    //@}

    void getExternalContext(XgExternalContentInfoTable& table, const std::string& prefix) const;

protected:

    /** No definition by design so accidental default construction. */
    XgExpression();
    
    /** No definition by design so accidental copying is prevented. */
    XgExpression( const XgExpression &e );

    /** No definition by design so accidental assignment is prevented. */
    XgExpression &operator=( const XgExpression &e );
    
    /** Evaluate and set face seed for the expression */
    void evalFaceSeed() const;

    /** Container for all cached ptex files. */
    static std::set<clearCacheFunc> _clearCacheCallbacks;

    /** Set of problematic maps. */
    static tbb::concurrent_unordered_set<std::string> _problemMaps;

    /** Flag set if we are in the shadow pass. */
    static bool _shadowPass;

    static bool _recursing;

    /** The description owning this expression. */
    XgDescription *_description;

    /** Name for the expression. */
    std::string _name;
    
    /** The expression. */
    XgSeExpr* _expr;

    /**
     * The type of the expression: float, color, vector, normal, point.
     * color, normal, vector, and point are treated the same with regards to
     * evaluation.  The only difference is when actually outputting to the
     * renderer.
     */
    std::string _type;

    /** Flag set while expression is being evaluated. */
    mutable bool _evaluating;

    /** FLag set if the expression has some sort of error. */
    mutable bool _badExpr;
    
    /** The name of the patch being evaluated (may be null) */
    mutable const std::string *_patchName;
    mutable std::string  _lastPatchName;

    /** 'u' value being evaluated. */
    mutable double _u;
    
    /** 'v' value being evaluated. */
    mutable double _v;

    /** face id being evaluated. */
    mutable int _faceId;
    mutable int _lastFaceId;

    /** Last description ID being evaluated. */
    mutable int _lastDescriptionId;

    /** Random number expr seed. */
    double _exprSeed;

    /** Random number face seed. */
    mutable double _faceSeed;

    /** Random generator instance counter */
    mutable int _randInstance;
};


/** @name Stream operators. */
//@{
std::ostream& operator<<( std::ostream &s, const XgExpression &expression );
std::istream& operator>>( std::istream &s, XgExpression &expression );
//@}

#endif
