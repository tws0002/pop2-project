/*
 SEEXPR SOFTWARE
 Copyright 2011 Disney Enterprises, Inc. All rights reserved
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are
 met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in
 the documentation and/or other materials provided with the
 distribution.
 
 * The names "Disney", "Walt Disney Pictures", "Walt Disney Animation
 Studios" or the names of its contributors may NOT be used to
 endorse or promote products derived from this software without
 specific prior written permission from Walt Disney Pictures.
 
 Disclaimer: THIS SOFTWARE IS PROVIDED BY WALT DISNEY PICTURES AND
 CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
 BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE, NONINFRINGEMENT AND TITLE ARE DISCLAIMED.
 IN NO EVENT SHALL WALT DISNEY PICTURES, THE COPYRIGHT HOLDER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND BASED ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
*/
#ifndef SeExpression_h
#define SeExpression_h

#include <string>
#include <map>
#include <set>
#include <vector>

#include <tbb/enumerable_thread_specific.h>

#include "XgWinExport.h"
#include "SeExpr/SeVec3d.h"
#include "SeExpr/SeMutex.h"

class SeExprNode;
class SeExprVarNode;
class SeExprLocalVarRef;
class SeExprFunc;
class SeExpression;

//
// The value of local variable is thread-local.
// Each value local variable is a vector (3 double values). When parse
// an expression, number all local variables, then know the total number
// of local variable in the expression.
// When evaluate the expression, alloc space for this array to store the
// temporary values for all local variables.
// The variable stores all local var when evaluate nested expression
//
typedef tbb::enumerable_thread_specific< std::vector<SeVec3d> > LocalVarValueStack; 
extern LocalVarValueStack localVarValueStack;

class XGEN_SEEXPR_EXPORT SeExpressionFlags
{
public:
	static void setMultithreading( bool enable ) { _multithreading = enable; }
	static bool multithreading() { return _multithreading; }
private:
	static bool _multithreading;
};

//! abstract class for implementing variable references
class XGEN_SEEXPR_EXPORT SeExprVarRef
{
 public:
    virtual ~SeExprVarRef() {}

    //! returns true for a vector type, false for a scalar type
    virtual bool isVec() = 0;

    //! returns this variable's value by setting result, node refers to 
    //! where in the parse tree the evaluation is occurring
    virtual void eval(const SeExprVarNode* node, SeVec3d& result) = 0;
};

/// simple vector variable reference reference base class
class XGEN_SEEXPR_EXPORT SeExprVectorVarRef : public SeExprVarRef
{
 public:
    virtual bool isVec() { return 1; }
};


/// simple scalar variable reference reference base class
class XGEN_SEEXPR_EXPORT SeExprScalarVarRef : public SeExprVarRef
{
 public:
    virtual bool isVec() { return 0; }
};

/// uses internally to represent local variables
class XGEN_SEEXPR_EXPORT SeExprLocalVarRef : public SeExprVarRef
{
 public:
    SeVec3d val; // remove this val after parallized
	int id;	// id in the scope of one expression
	
    SeExprLocalVarRef() : _isVec(false) {}
    void setIsVec() { _isVec = true; }
    virtual void eval(const SeExprVarNode*, SeVec3d& result) 
    { 
		if (SeExpressionFlags::multithreading()) {
            LocalVarValueStack::reference myStack = localVarValueStack.local();
            result = myStack.at(myStack.size() - id - 1);
        }
		else
			result = val; 
	}
    virtual bool isVec() { return _isVec; }
	SeVec3d getVal()
	{
		if (SeExpressionFlags::multithreading()) {
            LocalVarValueStack::reference myStack = localVarValueStack.local();
            return myStack[myStack.size() - id - 1];
        }
		else
			return val;
	}
	
	void setVal(SeVec3d v)
	{
		if (SeExpressionFlags::multithreading()) {
            LocalVarValueStack::reference myStack = localVarValueStack.local();
            myStack[myStack.size() - id - 1] = v;
        }
		else
			val = v;
	}
	
 private:
    bool _isVec;
};


/// main expression class
class XGEN_SEEXPR_EXPORT SeExpression
{
 public:
    typedef std::map<std::string, SeExprLocalVarRef> LocalVarTable;

    //! Represents a parse or type checking error in an expression
    struct XGEN_SEEXPR_EXPORT Error
    {
        //! Text of error
        std::string error;

        //! Error start offset in expression string
        int startPos;

        //! Error end offset in expression string
        int endPos;

        Error(const std::string& errorIn,const int startPosIn,const int endPosIn)
            :error(errorIn),startPos(startPosIn),endPos(endPosIn)
        {}
    };

    SeExpression( );
    SeExpression( const std::string &e, bool wantVec=true );
    virtual ~SeExpression();

    /** Sets the expression to desire a vector or a scalar.
        This will allow the evaluation to potentially be optimized if 
        only a scalar is desired. */
    void setWantVec(bool wantVec);

    /** Set expression string to e.  
        This invalidates all parsed state. */
    virtual void setExpr(const std::string& e);

    //! Get the string that this expression is currently set to evaluate
    const std::string& getExpr() const { return _expression; }

    /** Check expression syntax.  Expr will be parsed if needed.  If
	this returns false, the error message can be accessed via
	parseError() */
    bool syntaxOK() const;

    /** Check if expression is valid.  Expr will be parsed if
	needed. Variables and functions will also be bound.  If this
	returns false, the error message can be accessed via
	parseError() */
    bool isValid() const;

    /** Get parse error (if any).  First call syntaxOK or isValid
	to parse (and optionally bind) the expression. */
    const std::string& parseError() const { return _parseError; }

    /** Get a reference to a list of parse errors in the expression.
        The error structure gives location information as well as the errors itself. */
    const std::vector<Error>& getErrors() const
    {return _errors;}

    /** Check if expression is constant.
	Expr will be parsed if needed.  No binding is required. */
    bool isConstant() const;

    /** Determine whether expression uses a particular external variable. 
	Expr will be parsed if needed.  No binding is required. */
    bool usesVar(const std::string& name) const;

    /** Determine whether expression uses a particular function.
	Expr will be parsed if needed.  No binding is required. */
    bool usesFunc(const std::string& name) const;

    /** Returns whether the expression contains and calls to non-threadsafe */
    bool isThreadSafe() const
    {return _threadUnsafeFunctionCalls.size()==0;}

    /** Internal function where parse tree nodes can register violations in
        thread safety with the main class. */
    void setThreadUnsafe(const std::string& functionName) const
    {_threadUnsafeFunctionCalls.push_back(functionName);}

    /** Returns a list of functions that are not threadSafe **/
    const std::vector<std::string>& getThreadUnsafeFunctionCalls() const
    {return _threadUnsafeFunctionCalls;}
    
    /** Get wantVec setting */
    bool wantVec() const { return _wantVec; }

    /** Determine if expression computes a vector (may be false even
	if wantVec is true).  Expr will be parsed and variables and
	functions will be bound if needed. */
    bool isVec() const;

    /** Evaluate the expression.  This will parse and bind if needed */
    SeVec3d evaluate() const;

    /** Reset expr - force reparse/rebind */
    void reset();

    /** override resolveVar to add external variables */
    virtual SeExprVarRef* resolveVar(const std::string& /*name*/) const {return 0;}

    /** override resolveFunc to add external functions */
    virtual SeExprFunc* resolveFunc(const std::string& /*name*/) const {return 0;}

    /** records an error in prep or parse stage */
    void addError(const std::string& error,const int startPos,const int endPos) const
    {_errors.push_back(Error(error,startPos,endPos));}

    /** Returns a read only map of local variables that were set **/
    const LocalVarTable& getLocalVars() const {return _localVars;}

    /** release the variables of TLS. */
    static void clearTLS() { localVarValueStack.clear(); }

 private:
    /** No definition by design. */
    SeExpression( const SeExpression &e );
    SeExpression &operator=( const SeExpression &e );

    /** Parse, and remember parse error if any */
    void parse() const;

    /** Prepare expression (bind vars/functions, etc.) 
	and remember error if any */
    void prep() const;

    /** Parse, but only if not yet parsed */
	void parseIfNeeded() const 
	{ 
		if (_parsed) return;

		SeExprInternal::AutoMutex locker(parseMutex);
		if (!_parsed) parse();
	}

	/** Prepare, but only if not yet prepped */
	void prepIfNeeded() const 
	{
		if (_prepped) return;

		SeExprInternal::AutoMutex locker(perfMutex);
		if (!_prepped) prep(); 
	}

	/** True if the expression wants a vector */
	bool _wantVec;

	/** The expression. */
	std::string _expression;

	mutable SeExprInternal::Mutex perfMutex;
	mutable SeExprInternal::Mutex parseMutex;
    
    /** Parse tree (null if syntax is bad). */
    mutable SeExprNode *_parseTree;

    /** Flag set once expr is parsed/prepped (parsing is automatic and lazy) */
    mutable bool _parsed, _prepped;
    
    /** Cached parse error (returned by isValid) */
    mutable std::string _parseError;

    /** Cached parse error location {startline,startcolumn,endline,endcolumn} */
    mutable std::vector<Error> _errors;

    /** Variables used in this expr */
    mutable std::set<std::string> _vars;

    /** Functions used in this expr */
    mutable std::set<std::string> _funcs;

    /** Local variable table */
    mutable LocalVarTable _localVars;

    /** Whether or not we have unsafe functions */
    mutable std::vector<std::string> _threadUnsafeFunctionCalls;

    /** String tokens allocated by lex */
    mutable std::vector<char*> _stringTokens;

    /* internal */ public:

    //! add local variable (this is for internal use)
    void addVar(const char* n) const { _vars.insert(n); }

    //! add local function (this is for internal use)
    void addFunc(const char* n) const { _funcs.insert(n); }

    //! get local variable reference (this is for internal use)
    SeExprVarRef* resolveLocalVar(const char* n) const {
	LocalVarTable::iterator iter = _localVars.find(n);
	if (iter != _localVars.end()) return &iter->second;
	return 0;
    }

    /** get local variable reference. This is potentially useful for expression debuggers
        and/or uses of expressions where mutable variables are desired */
    SeExprLocalVarRef* getLocalVar(const char* n) const {
	return &_localVars[n]; 
    }
};

#endif
