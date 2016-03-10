// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgFXModule.h
 * @brief Contains the declaration of the class XgFXModule.
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
 * @author Stephen D. Bowline
 * @author Ying Liu
 *
 * @version Created 05/30/03
 */

#ifndef XGFXMODULE_H
#define XGFXMODULE_H

#include <string>

#include "XGen/XgDict.h"
#include "XGen/XgObject.h"
#include "XGen/XgExpression.h"
#include "XgWinExport.h"

class XgDescription;
class XgPatch;
class XgPrimitiveContext;
class XgFXModuleContext;
class XgPrimitive;


/**
 * @brief A base class for FX processing primitive geometry.
 *
 * This class is the base class for all FX modules. Each module is
 * allowed to process the primitives cached geometry in any way it
 * choses, as long as the original assumptions about that geometry are
 * still met. For example, the curve primitive produces cubic curves
 * of a fixed number of control points. So, a module can change the
 * position of the control points, but cannot change the number of them.
 */
class XGEN_EXPORT XgFXModule : public XgObject
{
public:

    /* Constructor. */
    XgFXModule( XgDescription *descr, const std::string &objectType );

    /* Destructor. */
    virtual ~XgFXModule();
  
    /** True when the modules works for the given primtive type. */
    virtual bool worksOn( const std::string &primType ) const = 0;

    /** @name Render methods. */
    //@{
    /**
     * Any module initialization per frame should be done in this
     * method. This includes gathering the values of any attributes
     * that do not change on a per primitive basis.
     */
    virtual void initDescription() { declareCVAttrs(); }
    virtual void initDescriptionInParallel( XgPrimitiveContext& context ) { declareCVAttrsInParallel( context ); }

    /**
     * This method should only be used in the case of a bake
     * operation. That is the only time it can be guaranteed to be
     * called. It is not, in general, called during a render.
     */
    virtual void finishDescription() {;}
    virtual void finishDescriptionInParallel( XgPrimitiveContext& context ) {;}
    
    /** Method called just prior to starting a patch face. */
    virtual void beginPatchFace() {;}
    virtual void beginPatchFaceInParallel( XgPrimitiveContext& context ) {;}
    
    /** Method called just after a patch face has completed rendering. */
    virtual void endPatchFace() {;}
    virtual void endPatchFaceInParallel( XgPrimitiveContext& context ) {;}
    //@}

    /** @name Control when module is active. */
    //@{
    bool active() const { return _active; }
    virtual void setActive( bool status );
    void deactivate() { setActive( false ); }
    //@}

    /**
     * Compute the FX for this module.
     */
	virtual bool compute() = 0;
	virtual bool computeParallel( XgPrimitiveContext& context ){return false;};
	virtual bool isThreadSafe(){return false;}

    /** @name FX Pipeline data. */
    //@{
    static bool getPipeData( const std::string &name,
                             safevector<SgVec3d> &val );
    static void setPipeData( const std::string &name, 
                             const safevector<SgVec3d> &val )
        { _pipeData[name.c_str()] = val; }
    static void removePipeData( const std::string &name )
        { _pipeData.erase( name.c_str() ); }
    static void removeAllPipeData()
        { _pipeData.clear(); }
    //@}

    /** Declare any cvAttrs created. */
    virtual void declareCVAttrs() {;}
    virtual void declareCVAttrsInParallel( XgPrimitiveContext& context ) {;}

    /* Set class attributes. */
    virtual bool setAttr( const std::string &name, 
                          const std::string &value, 
                          const std::string &type="float",
			  const std::string &uiHint="" );

    /** Return the name of this type of FX module. */
    virtual std::string typeName() const = 0;

    virtual XgFXModuleContext* createModuleContext() const { return NULL; }
    
    virtual void initModule( const XgPrimitive &prim ) {}
    virtual void finishModule( const XgPrimitive &prim ) {}

    size_t moduleIndex() const { return _moduleIndex; }
    void setModuleIndex( size_t index ) { _moduleIndex = index; }

    /** Returns true the FX module is included in exporting a description as preset.  */
    virtual bool includedInPreset() { return true; }

    /** Get external file paths used in the FX module. */
    virtual void getExternalContext(XgExternalContentInfoTable& table, const std::string& prefix) const;

protected:

    /** No definition by design to prevent accidental default construction. */
    XgFXModule();
    
    /** No definition by design so accidental copying is prevented. */
    XgFXModule( const XgFXModule &module );

    /** No definition by design so accidental assignment is prevented. */
    XgFXModule &operator=( const XgFXModule &module );

    /* Flag set when module is active. */
    bool _active;

    /* Attributes. */
    XgExpression _mask;

    /**
     * FX pipeline data. This can be used to store data that can be created
     * in one module and then used in another. It is the responsibility
     * of the FX modules to not step on each other when creating entries.
     */
    static XgDict< safevector<SgVec3d> > _pipeData;	// Turbo: Used in single-threaded mode. Clone to a context class for multi-threaded mode.
    
    size_t _moduleIndex;
};

#endif
