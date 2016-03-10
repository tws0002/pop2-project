// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgRenderer.h
 * @brief Contains the declaration of the class XgRenderer.
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
 * @author Stephen D. Bowline
 * @author Lee Gramling
 *
 * @version Created 05/23/02
 */

#ifndef XGRENDERER_H
#define XGRENDERER_H

#include <string>
#include <map>
#include <time.h>

#include "XGen/SgVec3T.h"
#include "XGen/SgXform3T.h"
#include "XGen/SgBox3T.h"

#include "XGen/XgUtil.h"
#include "XGen/XgObject.h"
#include "XGen/XgExpression.h"
#include "XGen/XgRendererContext.h"
#include "XgWinExport.h"

#include "tbb/atomic.h"

class XgDescription;
class XgPatch;
class XgGenerator;
class XgPrimitive;
class XgPrimitiveContext;
class XgRendererContext;

/**
 * @brief A base renderer class for populating patches with primitives.
 *
 * This class is the base class for all primitive renderers. The basic
 * flow of the generate algorithm is encoded here, as well as general
 * renderer variables. Sub-classes define the specifics for the method
 * of primitive placement.
 */
class XGEN_EXPORT XgRenderer : public XgObject
{
public:

    /* Constructor. */
    XgRenderer( XgDescription *descr, const std::string &objectType );

    /* Destructor. */
    virtual ~XgRenderer();

    /* Color indices for drawing primitives. */
    enum PrimHighlight { PRIM_IDS       =  0,
                         PRIM_SELECTED  =  1,
                         PRIM_CULLED    =  2,
                         PRIM_SELCULLED =  3,
                         PRIM_CVS       =  3,
                         PRIM_NORMAL    = 16,
                         PRIM_NORMAL1   = 17,
                         PRIM_NORMAL2   = 18};

    /* Indicates why a prim is being marked. */
    static const unsigned int SELECTED          = 0x00000001;
    static const unsigned int MANUALLY_CULLED   = 0x00000002;
    static const unsigned int CAMERA_CULLED     = 0x00000004;
    static const unsigned int EXPRESSION_CULLED = 0x00000008;
    static const unsigned int ANY_CULLED        = 0x0000000E;
    static const unsigned int SELECTEDi         = 0xFFFFFFFE;
    static const unsigned int MANUALLY_CULLEDi  = 0xFFFFFFFD;

    /* Render a patch. */
    void render( const int faceId, const std::string &patchName );
    void renderInParallel( XgPrimitiveContext& context, const int faceId, const std::string &patchName );

    /** Determine if it is ok to emit a primitive for the given sample. */
    virtual bool okToEmit( int sample, double u, double v ) { return true; }

    /** Should the renderer emit a culled primitive? */
    virtual bool handleCulledPrimitive( const unsigned int flag,
                                        const int faceId,
                                        const unsigned int pid,
                                        XgPatch *patch ) { return false; }

    virtual bool handleCulledPrimitiveInParallel( XgPrimitiveContext& context,
                                        const unsigned int flag,
                                        const int faceId,
                                        const unsigned int pid,
                                        XgPatch *patch ) { assert(0); return false; }

    /* Emit a primitive. */
    virtual void emitPrimitive( int sample, double u, double v, int faceId,
                                const safevector<XgPatch*> &patches ) = 0;
    virtual void emitPrimitiveInParallel( XgPrimitiveContext& context, int sample, double u, double v, int faceId,
                                const safevector<XgPatch*> &patches )
    { assert(0); }

    /* Initialize and finish a description. */
    virtual void initDescription();
    virtual void initDescriptionInParallel( XgPrimitiveContext& context );
    virtual void finishDescription();
    virtual void finishDescriptionInParallel( XgPrimitiveContext& context );

    /* Initialize and complete a face. */
    virtual bool beginPatchFace( const safevector<XgPatch*> &patches,
                                 int faceId );
    virtual bool beginPatchFaceInParallel( XgPrimitiveContext& context, const safevector<XgPatch*> &patches,
                                 int faceId );
    virtual void endPatchFace( const safevector<XgPatch*> &patches,
                               int faceId );
    virtual void endPatchFaceInParallel( XgPrimitiveContext& context, const safevector<XgPatch*> &patches,
                               int faceId );

    /** Renderer can refresh from cache. */
    virtual bool canRefresh() { return false; }

    /** Refresh a display. */
    virtual void refresh( bool filled, bool drawTexture ) {;}
    virtual void cleanRefresh() {;}
    
    /** @name Accessors. */
    //@{
    int numSamples() const { return _numSamples; }
    double percent() const { return _percent; }
    double startPercent() const { return _startPercent; }
    double maxBound() const { return _maxBound; }
    bool isRendering() const { return _isRendering; }
    void setRendering( const bool flag ) { _isRendering = flag; }
    bool inCameraOnly() const { return _inCameraOnly; }
    void setInCameraOnly( const bool ico ) { _inCameraOnly = ico; }
    double inCameraMargin() const { return _inCameraMargin; }
    int emitCount() { return _emitCount; }
	void accumlateTotalEmitCount( unsigned int v ) { 
		if ( incTotalCountAfterPatchEnd() )
			_totalEmitCount += v; 
	}
    int totalEmitCount() { return _totalEmitCount; }
    virtual void overrideColor( const std::string &c ) {;}
    virtual void restoreColor() {;}
    const SgVec3d &localCamDir() { return _localCamDir; }
    void setLocalCamDir( const SgVec3d &vec ) { _localCamDir = vec; }
    //@}

    /** @name Shared attributes. */
    //@{
    static bool shadowPass() { return _shadowPass; }
    static void setShadowPass( bool sp )
        { _shadowPass = sp; XgExpression::setShadowPass( sp ); }
    static bool motionBlurShadows() { return _motionBlurShadows; }
    static void setMotionBlurShadows( bool mb ) { _motionBlurShadows = mb; }
    static bool camIsOrtho() { return _camIsOrtho; }
    static void setCamIsOrtho( bool flag ) { _camIsOrtho = flag; }
    static bool realCamIsOrtho() { return _realCamIsOrtho; }
    static void setRealCamIsOrtho( bool flag ) { _realCamIsOrtho = flag; }
    static const SgVec3d &camDir() { return _camDir; }
    static void setCamDir( const SgVec3d &vec ) { _camDir = vec; }
    static const SgVec3d &realCamDir() { return _realCamDir; }
    static void setRealCamDir( const SgVec3d &vec ) { _realCamDir = vec; }
    static const SgXform &camInverseXform() { return _camInverseXform; }
    static void setCamInverseXform( const SgXform &matrix )
        { _camInverseXform = matrix; }
    static const double *camFOV() { return _camFOV; }
    static void setCamFOV( const double fov )
        { _camFOV[0] = _camFOV[1] = fov; }
    static void setCamFOV( const double h, const double v )
        { _camFOV[0] = h; _camFOV[1] = v; }
    static double camRatio() { return _camRatio; }
    static void setCamRatio( double ratio ) { _camRatio = ratio; }
    //@}
    
    /* Set class attributes. */
    virtual bool setAttr( const std::string &name, 
                          const std::string &value, 
                          const std::string &type="float",
                          const std::string &uiHint="" );
    
    /** Return the name of this type of renderer. */
    virtual std::string typeName() const = 0;
    
    /* Return true if the bounding box is within the camera FOV. */
    bool faceInCam( const SgBox3d &bbox, const XgPatch *patch );

    /* Return true if the face's bounding box is within the camera FOV. */
    bool faceInCam( const int faceId, const XgPatch *patch );

    /* create a bound box and normals for a camera*/
    void createCameraInfo( safevector<SgVec3d> &camInfo );

    /* Return true if the if the pbounds intersects the view frustrum. */
    bool viewIntersect( safevector<SgVec3d> &pBounds,
                        safevector<SgVec3d> &camInfo );

    /* Return true if the point, in world coordinates, is in camera */
    bool pointInCam( const SgVec3d &ptWorld );

    /* Whether buffers are changed and this previewer needs to be updated. */
    bool mDirty;
    void setDirty(bool dirty) {mDirty = dirty;}
    bool dirty() {return mDirty;}

    virtual bool canRunInParallel() { return false; }

    virtual XgRendererContext* newRendererContext() { return new XgRendererContext(); }
    void reduceContext( XgRendererContext& context, const std::string& primType, bool isMainThread );
	tbb::mutex& reduceMutex() { return _reduceMutex; }

    virtual void getExternalContext(XgExternalContentInfoTable& table, const std::string& prefix) const {};

    /** Regions to be rendered. */
    static safevector<unsigned int> _regionIds;
    static XgExpression _clumpRegionExprInternal;

protected:

    /** No definition by design to prevent accidental default construction. */
    XgRenderer();
    
    /** No definition by design so accidental copying is prevented. */
    XgRenderer( const XgRenderer &renderer );

    /** No definition by design so accidental assignment is prevented. */
    XgRenderer &operator=( const XgRenderer &renderer );

    virtual void reduceResult( XgRendererContext& context, const std::string& primType, bool isMainThread ) {}

	virtual bool incTotalCountAfterPatchEnd() { return true; }

    /** Number of samples to generate/render. */
    int _numSamples;
    
    /** Percent of primitives to render. */
    double _percent;

    /** Percentage at which to start rendering. */
    double _startPercent;

    /** Is the camera orthographic. */
    static bool _camIsOrtho;

    /** Is the non-shadow camera orthographic. */
    static bool _realCamIsOrtho;

    /** Direction or position of the camera depending on whether it's orthographic. */
    static SgVec3d _camDir;
    SgVec3d _localCamDir;

    /** Direction or position of the non-shadow camera depending on whether it's orthographic. */
    static SgVec3d _realCamDir;

    /** Tranformation matrix for world to camera space */
    static SgXform _camInverseXform;

    /** Field of view for the camera. */
    static double _camFOV[2];

    /** Camera ratio. */
    static double _camRatio;

    /** Counter for number of primitives actually rendered. */
    unsigned int _emitCount;	// Turbo: Used in single-threaded mode. Clone to a context class for multi-threaded mode.
    tbb::atomic<unsigned int> _totalEmitCount;

    /** Timer variables. */
    xgutil::TimerVal _timePatch;	// Turbo: Used in single-threaded mode. Clone to a context class for multi-threaded mode.
    
    /** Flag set if we are in the shadow pass. */
    static bool _shadowPass;

    /** Allow for motion blurred shadows. */
    static bool _motionBlurShadows;
 
    /** Maximum computed "primBound" across a whole description */
    tbb::atomic<double> _maxBound;

    /** The computed bounding box for a face's prims */
    SgBox3d _faceBBox;	// Turbo: Used in single-threaded mode. Clone to a context class for multi-threaded mode.

    /** Necessary because previewers are renderers too. */
    bool _isRendering;	// Turbo: Used in single-threaded mode. Clone to a context class for multi-threaded mode.

    /** Generate on patches in the camera view only */
    bool _inCameraOnly;

    /** Margin to add to camera frustrum for patch visbility */
    double _inCameraMargin;

	/** Mutex to protect primitive buffers */
	tbb::mutex _reduceMutex;
};


#endif
