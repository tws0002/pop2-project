// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.


#include "XgOFFRenderer.h"

#include <XGen/SgVec3T.h>
#include <XGen/SgXform3T.h>

#include <XGen/XgCreator.h>
#include <XGen/XgUtil.h>
#include <XGen/XgDescription.h>
#include <XGen/XgPatch.h>
#include <XGen/XgPrimitive.h>
#include <XGen/XgArchivePrimitive.h>
#include <XGen/XgCardPrimitive.h>
#include <XGen/XgSpherePrimitive.h>
#include <XGen/XgSplinePrimitive.h>

#include <string.h> // strerror
#include <errno.h>  // errno

using namespace std;
using namespace xgutil;

XgRegisterRenderer(OFF);


/**
 * Constructor for the OFF renderer.
 */
XgOFFRenderer::XgOFFRenderer( XgDescription *descr )
    : XgRenderer( descr, typeName() )
    , _outputDir("")
    , _isBadPrimitive(false)
{
    setAttr( "outputDir", "/tmp" );
}


/**
 *  Nothing to do.
 */
XgOFFRenderer::~XgOFFRenderer()
{
}


/**
 * Emit a single primitive (no motion blur for OFF).
 *
 * @param sample   the index of the sample being emitted.
 * @param u        the u value of the primitive being emitted.
 * @param v        the v value of the primitive being emitted.
 * @param faceId   the face containing the primitive being emitted.
 * @param patches  the patch containing the primitive being emitted.
 */
void
XgOFFRenderer::emitPrimitive( int sample, double u, double v, int faceId,
                              const safevector<XgPatch*> &patches )
{
    // Handle common operations
    const XgPrimitive *prim = _description->activePrimitive();

    if ( prim->typeName() == "ArchivePrimitive" ) {
        handleArchive   (static_cast<const XgArchivePrimitive*>(prim));
    }
    else if ( prim->typeName() == "CardPrimitive" ) {
        handleCard      (static_cast<const XgCardPrimitive*>(prim));
    }
    else if ( prim->typeName() == "SpherePrimitive" ) {
        handleSphere    (static_cast<const XgSpherePrimitive*>(prim));
    }
    else if ( prim->typeName() == "SplinePrimitive" ) {
        handleSpline    (static_cast<const XgSplinePrimitive*>(prim));
    }
    else {
        if (!_isBadPrimitive) {
            XGError("Unsupported primitive type: "+prim->typeName());
            _isBadPrimitive = true;
        }
    }
}


/** Finish a description. */
void
XgOFFRenderer::finishDescription()
{
    // Open the file.
    std::string filename = _outputDir + "/" + _description->name() + ".off";
    FILE *f = fopen(filename.c_str(), "w");
    if (!f) {
        XGError("Failed to write " + filename + ": " + strerror(errno));
        return;
    }

    size_t nverts = _coordinates.size();
    size_t nfaces = _facesizes.size();

    // header.  There's no printf format for size_t; switch to unsigned.
    fprintf(f, "OFF\n");
    fprintf(f, "%u %u 0\n", unsigned(nverts), unsigned(nfaces));

    // vertices
    for(size_t i = 0; i < nverts; ++i) {
        fprintf(f, "%g %g %g\n", _coordinates[i][0],
                _coordinates[i][1], _coordinates[i][2]);
    }

    // faces
    for(size_t i = 0, j = 0; i < nfaces; ++i) {
        fprintf(f, "%u", unsigned(_facesizes[i]));
        for(size_t end = j + _facesizes[i]; j < end; ++j) {
            fprintf(f, " %u", unsigned(_indices[j]));
        }
        fputc('\n', f);
    }

    fclose(f);

    XgRenderer::finishDescription();
}


/**
 * Store an archive as a mesh.  Just a mesh of its oriented bounding box.
 */
void
XgOFFRenderer::handleArchive(const XgArchivePrimitive *prim)
{
    handleBBox(prim->transformation());
}


/**
 * Store the card as a 4x4 patch of squares.
 */
void
XgOFFRenderer::handleCard(const XgCardPrimitive* prim)
{
    // Get the 16 point mesh from the primitive control CVs
    safevector<SgVec3d> mesh;
    XgCardUtil::mkPolyMesh<double>( prim->getGeom(), mesh );
    for(size_t i = 0; i < 4; ++i) {
        _facesizes.push_back(4);
        for(size_t j = 0; j < 4; ++j) {
            _indices.push_back(_coordinates.size());
            _coordinates.push_back(mesh[i]);
        }
    }
}


/**
 * Store the sphere as the six faces of its oriented and scaled bounding box.
 */
void
XgOFFRenderer::handleSphere(const XgSpherePrimitive *prim)
{
    handleBBox(prim->transformation());
}


/**
 * Store the spline as a polyline x width, via the SgCurveUtil functions.
 */
void
XgOFFRenderer::handleSpline(const XgSplinePrimitive *prim)
{
    safevector<SgVec3d> pts;
    SgCurveUtil::mkPolyLine(
            false /*we want points on the curve, not the control poly*/,
            prim->getGeom(),
            pts);

    safevector<SgVec3d> widthVectors;
    SgCurveUtil::calcNormTex(pts, prim->cW(), prim->cWidth(), prim->cTaper(),
            prim->cTaperStart(), &widthVectors);

    _coordinates.push_back(pts[0]);
    _coordinates.push_back(pts[0] + widthVectors[0]);
    for(size_t i = 1, n = pts.size(); i < n; ++i) {
        _coordinates.push_back(pts[i]);
        _coordinates.push_back(pts[i] + widthVectors[i]);

        _facesizes.push_back(4);
        _indices.push_back(_coordinates.size() - 4);
        _indices.push_back(_coordinates.size() - 3);
        _indices.push_back(_coordinates.size() - 1);
        _indices.push_back(_coordinates.size() - 2);
    }
}


/**
 * Add the 6 faces of the unit cube, transformed by X.
 * This is a helper for the sphere and archive primitive.  More complete code
 * would output the full mesh of a sphere, or the full mesh of an archive
 * primitive, and provide flags to select which representation and how much
 * sphere subdivision we want, etc.
 */
void
XgOFFRenderer::handleBBox(const SgXform3d& X)
{
    // 8 corners: 000, 001, 010, 011, 100, 101, 110, 111
    size_t firstIndex = _coordinates.size();
    for (size_t i = 0; i < 8; ++i) {
        SgVec3d boxCorner(
                (i & 1) ? 0.0 : 1.0,
                (i & 2) ? 0.0 : 1.0,
                (i & 4) ? 0.0 : 1.0);
        X.multiply(boxCorner, boxCorner);
        _coordinates.push_back(boxCorner);
    }

    // 6 faces: 0132, 0451, 0264, 1573, 2376, 2576
    // You can verify that they are all the tours of length 4 in which two
    // subsequent vertices differ in exactly one bit.  Or you can draw out a
    // cube, which is what I did.
    size_t faces[][4] = {
        { 0, 1, 3, 2 },
        { 0, 4, 5, 1 },
        { 0, 2, 6, 4 },
        { 1, 5, 7, 3 },
        { 2, 3, 7, 6 },
        { 4, 5, 7, 6 }
    };
    for (size_t i = 0; i < 6; ++i) {
        _facesizes.push_back(4);
        for (size_t j = 0; j < 4; ++j) {
            _indices.push_back(faces[i][j] + firstIndex);
        }
    }
}


/**
 * Set an attributes value. Base class handles creation.
 *
 * @param name name of attribute to set
 * @param value value to set into the attribute
 */
bool
XgOFFRenderer::setAttr( const string &name,
                        const string &value,
                        const string &type,
                        const string &uiHint )
{
    if ( XgRenderer::setAttr(name,value,type,uiHint) ) return true;

    if ( name == "outputDir" ) {
        _outputDir = validPath( value );
        return true;
    }

    return false;
}
