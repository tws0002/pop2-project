// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgPalette.h
 * @brief Contains the declaration of the class XgPalette.
 *
 * <b>CONFIDENTIAL INFORMATION: This software is the confidential and
 * proprietary information of Walt Disney Animation Studios ("WDAS").
 * This software may not be used, disclosed, reproduced or distributed
 * for any purpose without prior written authorization and license
 * from WDAS. Reproduction of any section of this software must include
 * this legend and all copyright notices.
 * Copyright Disney Enterprises, Inc. All rights reserved.</b>
 *
 * @author Ernie Petti
 * @author Thomas V Thompson II
 * @author Ying Liu
 * @author Lee Gramling
 *
 * @version Created 06/23/03
 */

#ifndef XGPALETTE_H
#define XGPALETTE_H

#include <iostream>
#include <string>

#include "XGen/XgDict.h"
#include "XGen/XgUtil.h"
#include "XGen/XgObject.h"
#include "XGen/SgXform3T.h"
#include "XgWinExport.h"

class XgDescription;
class XgExpression;

/**
 * @brief A class describing a collection of descriptions.
 *
 * This class contains a palette which is a collection of descriptions and
 * expressions.  This collection acts as a namespace for "global" expressions
 * as well as a single file for export and import and maintaining separation
 * between other descriptions from different elements in a single shot.
 */
class XGEN_EXPORT XgPalette : public XgObject
{
public:

    /* Constructor. */
    XgPalette();

    /* Destructor. */
    virtual ~XgPalette();

    /* Map of all palettes. */
    static XgPalette *palette( const std::string &name );
    static safevector<std::string> palettes();
    
    /** @name Accessors. */
    //@{
    const safevector<std::string> &xgDataPath() const { return _xgDataPath; }
    const std::string &xgDataPathStr() const { return _xgDataPathStr; }
    XgExpression *namedAttr( const std::string &name );
    double frame() const { return _frame; }
    void setFrame( double f ) { _frame = f; }
    double framesPerSecond() const { return _rate; }
    void setFramesPerSecond( double r ) { _rate = r; }
    
    std::string interpolation() const { return _interpolation; }
    void setInterpolation( const std::string &interp )
        { _interpolation = interp; }
    void setWorld( const SgXform &xform )
        { _palToWorld = xform; _worldToPal.inverse( _palToWorld ); }
    void setWorldInverse( const SgXform &xform )
        { _worldToPal = xform; _palToWorld.inverse( _worldToPal ); }
    void setWorldInverse( const double coeffs[4][4] )
        { _worldToPal = SgXform( coeffs );
          _palToWorld.inverse( _worldToPal ); }
    const SgXform &worldInverse() const { return _worldToPal; }
    const SgXform &world() const { return _palToWorld; }
    XgPalette *snapshot() { return _snapshot; }
    void setSnapshot( XgPalette *copy ) { _snapshot=copy; }
    unsigned int maxGuideId() const { return _maxGuideId; }
    void resetMaxGuideId() { _maxGuideId = 0; }
    void setMaxGuideId( unsigned int id ) { _maxGuideId = id; }

    void updateLocalDataPath( );

    //@}

    /** @name Description map access. */
    //@{
    XgDescription *description( const std::string &descName ) const;
    XgDescription *description( unsigned int i ) const
        { return (_descriptions.size()>i ? _descriptions[i] : 0); }
    unsigned int numDescriptions() const { return (unsigned int)_descriptions.size(); }
    bool addDescription( XgDescription *desc );
    bool removeDescription( const std::string &descName);
    //@}
    
    /* Set class attributes. */
    virtual bool setAttr( const std::string &name, 
                          const std::string &value, 
                          const std::string &type="float",
                          const std::string &uiHint="" );

    /** Return the name of this type of renderer. */
    virtual std::string typeName() const { return "Palette"; }
    
    /** @name IO functions. */
    //@{
    bool exportDescriptions( std::ostream &os ) const;
    //@}

    /** @name Motion blur control. */
    //@{
    unsigned int numSamples() const { return (unsigned int)_samplePalettes.size()+1; }
    void addSample( XgPalette *pal ) { _samplePalettes.push_back(pal); }
    XgPalette *sample( unsigned int i )
    { return (i==0 ? this : (_samplePalettes.size()>=i ? _samplePalettes[i-1] : 0)); }
    //@}
    
protected:

    /* Copy constructor.  Not defined so it is not accidentally called. */
    XgPalette(const XgPalette &palette);

    /* Assignment operator.  Not defined so it is not accidentally called. */
    XgPalette &operator=(const XgPalette &palette);

    /* Override for setting the name of palette. */
    void setName( const std::string &name );

    /** Vector of description. */
    safevector<XgDescription*> _descriptions;

    /** Map and data directories. */
    safevector<std::string> _xgDataPath;
    std::string _xgDataPathStr;

    /** Dictionary of all palettes. */
    static XgDict<XgPalette*> _palettes;

    /** Motion samples. */
    safevector<XgPalette*> _samplePalettes;

    /** Snapshot of palette for delta saving. */
    XgPalette *_snapshot;
    
    /** Current frame value. */
    double _frame;

    /** Current  value. */	
	double _rate;

    /** Maximum id for all guides in the palette. */
    unsigned int _maxGuideId;
    
    /** Geometry interpolation method. */
    std::string _interpolation;
    
    /** World Inverse and world Transforms */
    SgXform _worldToPal;
    SgXform _palToWorld;
};

#endif
