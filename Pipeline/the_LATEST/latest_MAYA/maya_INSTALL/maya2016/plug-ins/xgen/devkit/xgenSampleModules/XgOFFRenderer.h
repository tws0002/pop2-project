// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

#ifndef XgOFFRenderer_h
#define XgOFFRenderer_h

#include <string>
#include <XGen/XgRenderer.h>
#include <stdio.h>

class XgDescription;
class XgPatch;

class XgArchivePrimitive;
class XgCardPrimitive;
class XgSpherePrimitive;
class XgSplinePrimitive;

/**
 * @brief Renderer for exporting an OFF file for the emitted meshes.
 *
 * OFF is the geomview format used in computational geometry.  This renderer
 * creates the mesh for each description and outputs it to file.  Spheres are
 * left as an exercise to the reader -- we output boxes instead.
 */
class XgOFFRenderer : public XgRenderer
{
public:

    /* Constructor. */
    XgOFFRenderer( XgDescription *descr );

    /* Destructor. */
    virtual ~XgOFFRenderer();

    /** No motion blur, so emit only for base sample */
    virtual bool okToEmit( int sample, double u, double v )
        { return (sample == 0); }

    /* Emit a primitive. */
    virtual void emitPrimitive( int sample, double u, double v, int faceId,
                                const safevector<XgPatch*> &patches );

    /* No initialization to do in this renderer. */
    // virtual void initDescription();

    /* Finish a description.  Each one goes into its own file. */
    virtual void finishDescription();

    /* Set class attributes. */
    virtual bool setAttr(
            const std::string &name,
            const std::string &value,
            const std::string &type="float",
            const std::string &uiHint="" );

    /** Return the name of this type of renderer. */
    virtual std::string typeName() const { return "OFFRenderer"; }

private:
    /** @name Specialized primitive helpers. */
    //@{
    void handleArchive(const XgArchivePrimitive*);
    void handleCard   (const XgCardPrimitive*);
    void handleSphere (const XgSpherePrimitive*);
    void handleSpline (const XgSplinePrimitive*);
    //@}

    // The archive and sphere we just output their bounding box, but in
    // object space so it's oriented correctly.  This function does that.
    void handleBBox   (const SgXform3d&);

    // Output directory for the mesh for each description.
    std::string _outputDir;

    // Have we raised an error yet?  If so, don't repeat ourselves for the next
    // 300,000 primitives that have the same error.
    bool _isBadPrimitive;

    // The vertices and faces of each description.
    // Flushed to file and emptied in finishDescription.
    safevector<SgVec3d> _coordinates;
    safevector<size_t>  _facesizes;
    safevector<size_t>  _indices;
};

#endif
