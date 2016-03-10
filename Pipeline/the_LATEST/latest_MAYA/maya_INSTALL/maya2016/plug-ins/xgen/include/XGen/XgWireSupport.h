// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgWireSupport.h
 * @brief Contains the declaration of the class XgWireSupport.
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
 *
 * @version Created 11/27/07
 */

#ifndef XGWIRESUPPORT_H
#define XGWIRESUPPORT_H

#include "XgPorting/safevector.h"
#include <string>

#include "XGen/SgVec3T.h"
#include "XGen/SgKdTreeNT.h"
#include "xpd/XpdFileCachedReader.h"
#include "XgWinExport.h"

class XgPrimitive;
class XgPrimitiveContext;
class XgWireSupportContext;

/**
 * @brief A support class for dealing with wires/clumps in fx modules.
 */
class XGEN_EXPORT XgWireSupport
{
public:

    /* Constructor. */
    XgWireSupport();

    /* Destructor. */
    virtual ~XgWireSupport();
  
    /** Get aniWire from clump guide in primitive cv attributes. */
    bool getClumpGuides( XgPrimitive *prim, SgVec3d &fuv,
                         std::string &guidePatchName );
    bool getClumpGuidesInParallel(  XgPrimitiveContext &context,
                         XgWireSupportContext & wireContext,
                         SgVec3d &fuv,
                         std::string &guidePatchName );

    /* Bind a prim CV to an animWire CV */
    int bindCV( const SgVec3d &cv,
                SgVec3d &coord,
                unsigned int &quadrant );
    int bindCVInParallel( XgPrimitiveContext &context,
                XgWireSupportContext & wireContext,
                const SgVec3d &cv,
                SgVec3d &coord,
                unsigned int &quadrant );

    /* Compute the goal point from a single wire and CV. */
    SgVec3d computeGoalPt( const unsigned int index,
                           const SgVec3d &coord,
                           const unsigned int quadrant );  
    SgVec3d computeGoalPtInParallel( XgPrimitiveContext &context,
                           XgWireSupportContext & wireContext,
                           const unsigned int index,
                           const SgVec3d &coord,
                           const unsigned int quadrant );

    /* Construct the wire frame vectors */
    void buildFrameVectors( const SgVec3d &r_N, const SgVec3d &r_dPdu,
                            const SgVec3d &a_N, const SgVec3d &a_dPdu ); 
    void buildFrameVectorsInParallel(  XgPrimitiveContext &context,
                            XgWireSupportContext & wireContext,
                            const SgVec3d &r_N, const SgVec3d &r_dPdu,
                            const SgVec3d &a_N, const SgVec3d &a_dPdu ); 


protected:

    /** No definition by design so accidental copying is prevented. */
    XgWireSupport( const XgWireSupport &object );

    /** No definition by design so accidental assignment is prevented. */
    XgWireSupport &operator=( const XgWireSupport &object );
    
    /** The reference wires as coord system curves */	// Turbo: Used in single-threaded mode. Clone to a context class for multi-threaded mode.
    safevector<SgVec3d> *_xPosRef;
    safevector<SgVec3d> *_xNegRef;
    safevector<SgVec3d> *_yPosRef;
    safevector<SgVec3d> *_yNegRef;
    safevector<SgVec3d> *_axisRef;
    
    /** The animation wires as coord system curves */	// Turbo: Used in single-threaded mode. Clone to a context class for multi-threaded mode.
    safevector<SgVec3d> *_xPosAni;
    safevector<SgVec3d> *_xNegAni;
    safevector<SgVec3d> *_yPosAni;
    safevector<SgVec3d> *_yNegAni;
    safevector<SgVec3d> *_axisAni;
    
    /** Points from the reference wire in searchable form */
    SgKdTree3d *_kdtree;	// Turbo: Used in single-threaded mode. Clone to a context class for multi-threaded mode.
};


class XgFXModule;
class XgSplinePrimitive;
class XpdReader;

/**
 * @brief 
 */
class XGEN_EXPORT XgClumpGuides
{
public:

    /* Constructor. */
    XgClumpGuides(){}

    /* Destructor. */
    virtual ~XgClumpGuides(){ clearGuides(); }
  
    /** Method to read clump guides on a patch. */
    virtual bool readClumpGuides( XgSplinePrimitive *prim, XgFXModule *module, XgDescription *description, XpdReader *xpdFile, XgPatch *patch, bool firstClump);
    virtual bool readClumpGuidesInParallel( XgSplinePrimitive *prim, XgFXModule *module, XgDescription *description, XpdFileCachedReader* xpdFile, XgPatch *patch, bool firstClump);

    /** Method to export clump curves to a file. */
    virtual void exportClumpCurves() = 0;

	/** The Clumping guides. */
	struct clumpGuide {
		clumpGuide(): curlMutex(NULL) {}
		bool valid;
		double u;
		double v;
		unsigned int faceId;
		std::string patch;
		SgVec3d nVec, uVec, vVec, P;
		int best;
		double len;
		double polyLen;
		safevector<double> segLen;
		safevector<double> curl;
		volatile bool curlFilled;
		tbb::mutex* curlMutex;
		safevector<SgVec3d> axis;
	};

protected:

	void clearGuides();

    // Only readClumpGuides() writes it.
    safevector<clumpGuide> _cGuides;

    /** File name. */
    std::string _fileName;

	XpdFileCachedReader _xpdfileCache;
};

#endif
