// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

// We include windows.h somewhere, which defines macros named max and min
// We #define NOMINMAX before including windows.h to prevent it from defining those macros
#ifdef OSWin_
#define NOMINMAX
#endif 

#include "XgCrossGenerator.h"

#include <XGen/XgCreator.h>
#include <XGen/XgDescription.h>
#include <XGen/XgPalette.h>
#include <XGen/XgPatch.h>
#include <XGen/XgRenderer.h>
#include <XGen/XgSamples.h>

XgRegisterGenerator(Cross);


/**
 * Constructor for the base generator.
 */
XgCrossGenerator::XgCrossGenerator( XgDescription *descr ) :
    XgGenerator( descr, typeName() )
{
    setAttr("density","1.0","float");
}


/**
 * Generate primitives randomly.
 */
void
XgCrossGenerator::genPrimitives(
        int faceId,
        const safevector<XgPatch *> &patches,
        double startPercent,
        double percent /*ignored*/ )
{
    double u, v;

    // We get an array of patches along motion samples, but we only generate
    // based on the first one.
    XgPatch * patch = patches[0];
    std::string patchName = patch->name();
    double area = patch->area(faceId);
    unsigned int numPrims = unsigned(_density * area);

    // If given a tiny face, bail.  Handling tiny faces exactly right is
    // impossible in the XGen architecture -- we'll get strange behaviour no
    // matter what -- so we should have the artists provide sparser meshes.
    if (numPrims == 0) return;

    // Check if render has specified any regions to generate primitives
    bool regionCheck = renderRegionCheck();

    // If we are doing a draft render, we'll have a startPercent (which is
    // actually not percentage but [0,1]).  We have to generate all the point
    // positions, but then we toss the first several -- this ensures the IDs
    // and positions are consistent.
    unsigned int start = (unsigned int)( numPrims * startPercent );
    unsigned int last  = numPrims;

    // The sampling function needs a "group" which is roughly speaking a random
    // seed, then we walk through the values of the group one by one.
    // We want the "random" seed to actually be deterministic so it's
    // repeatable across time, so we hash some relevant data.  This is the
    // one_at_a_time hash function by Bob Jenkins, which isn't optimal but will
    // do for now:
    //      http://www.burtleburtle.net/bob/hash/doobs.html
    unsigned int group = 0;
    for(unsigned int i = 0; i < patchName.size(); ++i) {
        group += patchName[i];
        group += group << 10;
        group ^= group >> 6;
    }
    group ^= _description->descriptionId();
    group += group << 10;
    group ^= group >> 6;

    group ^= faceId;
    group += group << 10;
    group ^= group >> 6;

    group += group << 3;
    group ^= group >> 11;
    group += group << 15;

    for ( unsigned int i = 0; i < last; i++) {
        // Get a "random" sample.  This gives us u and v, normally meant to be
        // in patch space but I'm twisting it to mean u on one bar of the X and
        // v on the other bar of the X.
        getSample( i, _description->descriptionId(), group, u, v );

        if ( i > 622592 ) {
            // We can only generate this many samples before we start
            // generating duplicates, so bail out.
            break;
        }

        // Increment the Id in the primitive -- twice since we emit two points.
        _activePrim->incrId();
        _activePrim->incrId();

        // Skip if we haven't gotten to the start percentage yet.
        if ( i<start ) continue;

        // Emit the primitives if the renderer says it is ok to do so.
        double x[2] = { u, v };
        double y[2] = { u, 1.0 - v };
        for(int j = 0; j < 2; ++j) {
            if ( regionCheck && 
                    !validRenderRegion(x[j], y[j], faceId, patchName) ) {
                continue;
            }
            emitIfOk( x[j], y[j], faceId, patches );
        }
    }

    // Set the id to the largest possible id for the face. This gets us ready
    // for the extra points generation so all ids generated there will not
    // only follow the random ones, they will be consistent (ignore percent).
    _activePrim->setId( numPrims );
}


/**
 * Set an attribute value. Base class handles creation.
 *
 * @param name name of attribute to set
 * @param value value to set into the attribute
 */
bool
XgCrossGenerator::setAttr( const std::string &name,
                            const std::string &value,
                            const std::string &type,
                            const std::string &uiHint )
{
    if ( XgGenerator::setAttr(name,value,type,uiHint) ) return true;

    if ( name == "density" ) {
        bool res = floatAttr(name,value,_density);
        _density = std::max(0.000001,_density);
        return res;
    }

    return false;
}
