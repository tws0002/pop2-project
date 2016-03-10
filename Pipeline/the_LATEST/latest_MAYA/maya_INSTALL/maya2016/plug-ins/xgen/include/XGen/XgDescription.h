// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgDescription.h
 * @brief Contains the declaration of the class XgDescription.
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
 * @author Stephen D. Bowline
 * @author Ying Liu
 *
 * @version Created 05/22/02
 */

#ifndef XGDESCRIPTION_H
#define XGDESCRIPTION_H

#include <iostream>
#include <string>
#include <map>

#include "XGen/XgDict.h"
#include "XGen/XgUtil.h"
#include "XGen/XgObject.h"
#include "XGen/SgBox3T.h"
#include "XGen/XgExpression.h"
#include "XgWinExport.h"

class XgPalette;
class XgPatch;
class XgObject;
class XgPrimitive;
class XgPrimitiveContext;
class XgGenerator;
class XgRenderer;

class XgProfilingScope
{
public:

    XgProfilingScope(int colorIndex, const char* eventName, const char* description = NULL)
    {
        if(xgutil::XgProfiler::eventBeginFunc)
        {
            fEventId = xgutil::XgProfiler::eventBeginFunc( xgutil::XgProfiler::sXGenCategory, colorIndex, eventName, description);
        }
    }
    ~XgProfilingScope()
    {
        if(xgutil::XgProfiler::eventEndFunc && fEventId != -1)
        {
            xgutil::XgProfiler::eventEndFunc(fEventId);
        }
    }

private:
    int fEventId;
};

/**
 * @brief The main class describing population of a set of patches.
 *
 * This class controls all of the elements necessary to populate a set of
 * patches.  It contains a map of the patches to be populated, and pointers
 * to a list of primitives, gardeners, and renderers which act on the patches.
 */
class XGEN_EXPORT XgDescription : public XgObject
{
public:

    /* Constructor. */
    XgDescription();

    /* Destructor. */
    virtual ~XgDescription();

    /* Return the bounding box of all underlying XgPatches. */
    SgBox3d boundingBox() const;
    
    /** @name Accessors. */
    //@{
    bool flipNormals() const { return _flipNormals; }
    bool isStray( double u, double v, int faceId, 
                  const std::string *patchName ) const;
    const XgExpression* strayInternal() const { return &_strayInternal; }
    unsigned int descriptionId() const { return _descriptionId; }
    void setLodScreenSizeFactor();

    bool lodFlag() const { return _lodFlag; }
    const XgExpression &lodScreenSizeFactor() const
        { return _lodScreenSizeFactor; }
    const XgExpression &lodWidthCoefficient() const
        { return _lodWidthCoefficient; }
    double lodMinDensity() const
        { return _lodMinDensity; }
    double lodFadeOutRange() const
        { return _lodFadeOutRange; }
    double lodCullWidthRatio() const
        { return _lodCullWidthRatio; }
    double lodPixelFadeSize() const
        { return _lodPixelFadeSize; }
    double lodPixelCullSize() const
        { return _lodPixelCullSize; }
    double lodMaxWidthRatio() const
        { return _lodMaxWidthRatio; }
    double lodAdjustment() const
        { return _lodAdjustment; }
    void setLodAdjustment( double val )
        { _lodAdjustment = val; }

    unsigned int index() const { return _index; }
    void setIndex( unsigned int i ) { _index = i; }
    //@}
    
    /** @name Motion blur control. */
    //@{
    unsigned int numSamples() const { return (unsigned int)_samples.size()+1; }
    void addSample( XgDescription *descr ) { _samples.push_back(descr); }
    XgDescription *sample( unsigned int i )
        { return (i==0 ? this : (_samples.size()>=i ? _samples[i-1] : 0)); }
    //@}

    /**
     * typedef for a map with patchName strings as the key and XgPatches
     * as the values.
     */
    typedef std::map<const char *,XgPatch *,xgutil::ltstr> PatchMap;
    
    /** @name Patch map access. */
    //@{
    XgPatch *patch( const std::string &patchName ) const;
    bool addPatch( XgPatch *patch );
    bool removePatch( const std::string &patchName);
    bool changePatchName( const std::string &oldName,
                          const std::string &newName );
    void clearPatches();
    double maxPatchMidLength();
    const PatchMap &patches() const { return _patches; }
    unsigned int numPatches() const { return (unsigned int)_patches.size(); }
    //@}

    /** @name Palette accessors. */
    //@{
    XgPalette *palette() const { return _palette; }
    void setPalette( XgPalette *palette ) { _palette = palette; }
    //@}
    
    /** @name Active element accessors. */
    //@{
    /* Access to the active objects. */
    XgPrimitive *activePrimitive() const { return _activePrimitive; }
    XgGenerator *activeGenerator() const { return _activeGenerator; }
    XgRenderer *activeRenderer( bool previewerOK=false ) const;
    XgRenderer *activePreviewer() const { return _activePreviewer; }
    bool setActive( const std::string &name );
    bool setPreviewer( const std::string &name );
    XgObject *getObject( const std::string &name ) const;
    XgObject *addObject( const std::string &name );
    bool objectName( int i, std::string &name ) const;
    void cleanObjects( bool forRender=false );
    //@}

    /* Set class attributes. */
    virtual bool setAttr( const std::string &name, 
                          const std::string &value, 
                          const std::string &type="float",
			  const std::string &uiHint="" );

    /** Return the name of this type of renderer. */
    virtual std::string typeName() const { return "Description"; }
    
    /** @name IO functions. */
    //@{
    bool exportObjects( std::ostream &os ) const;
    bool exportPatches( std::ostream &os ) const;
    bool exportPatch( std::ostream &os, std::string& patch ) const;
    bool exportTexMap( std::ostream &os) const;
    bool importPatches( std::istream &is );
    bool importPatch( std::istream &is, std::string& patch );
    bool importTexMap( std::istream &is );

    virtual bool exportExtraAttr(std::ostream &os ) const;
    virtual bool isExtraAttr(const std::string& attr) const;
    //@}

    /** @name Hammer attribute accessors for primitives */
    //@{
    bool useHammer() { return _useHammer; }
    void setUseHammer( bool h ) { _useHammer = h; }

    std::string lengthHammer() { return _lengthHammerExprStr; }
    void setLengthHammer( const std::string &hammer )
        { _lengthHammerExprStr = hammer; }

    std::string widthHammer() { return _widthHammerExprStr; }
    void setWidthHammer( const std::string &hammer )
        { _widthHammerExprStr = hammer; }

    std::string depthHammer() { return _depthHammerExprStr; }
    void setDepthHammer( const std::string &hammer )
        { _depthHammerExprStr = hammer; }

    std::string taperHammer() { return _taperHammerExprStr; }
    void setTaperHammer( const std::string &hammer )
        { _taperHammerExprStr = hammer; }
    //@}

    void getExternalContext(XgExternalContentInfoTable& table, const std::string& prefix) const;

protected:

    /* Copy constructor.  Not defined so it is not accidentally called. */
    XgDescription(const XgDescription &description);

    /* Assignment operator.  Not defined so it is not accidentally called. */
    XgDescription &operator=(const XgDescription &description);

    /* Change the description id. */
    void setDescriptionId( unsigned int id );
    
    /* Convenience functions for removing all elements of the vectors. */
    void clearObjects();

    /* Override for setting the name of description. */
    virtual void setName( const std::string &name );

protected:
    /** Pointer to the palette that contains this description. */
    XgPalette *_palette;
    
    /** Keep a map of all objects for this description. */
    XgDict<XgObject *> _objects;
    
    /** The currently active primitive. */
    XgPrimitive *_activePrimitive;
    
    /** The currently active generator. */
    XgGenerator *_activeGenerator;
    
    /** The currently active renderer. */
    XgRenderer *_activeRenderer;

    /** The currently active previewer. */
    XgRenderer *_activePreviewer;

    /** Flip patch normals. */
    bool _flipNormals;

    /** Map of patch names to XgPatches. */
    PatchMap _patches;

    /** Unique id for each description. */
    unsigned int _descriptionId;

    /** Whether tube workflow is used to set up the description. */
    bool _tubeWorkflow;

    /* Hammer expressions for primitives*/
    bool _useHammer;
    std::string _lengthHammerExprStr;
    std::string _widthHammerExprStr;
    std::string _depthHammerExprStr;
    std::string _taperHammerExprStr;    
    
    /** Expression used to evaluate whether a primitive is stray. 
     *  It is used by stray() function.
     */
    XgExpression _strayInternal;

    /** Motion samples. */
    safevector<XgDescription*> _samples;
    
    /** Static counter for unique description id. */
    static safevector<unsigned int> _descriptionIds;

    /** Level of detail control. */
    bool _lodFlag;
    double _lodMinDensity;
    double _lodFadeOutRange;
    double _lodCullWidthRatio;
    double _lodPixelFadeSize;
    double _lodPixelCullSize;
    double _lodMaxWidthRatio;
    XgExpression _lodScreenSizeFactor;
    XgExpression _lodWidthCoefficient;
    double _lodAdjustment;	// Turbo: Used in single-threaded mode. Clone to a context class for multi-threaded mode.

    /** Index within the palette. */
    unsigned int _index;
};


#endif
