// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file rxuv.cpp
 * @brief Simple program to illustrate reading in xuv files.
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
 * @version tthompso  09/12/08  Initial Version
 * @version tthompso  10/06/08  Update for xgen6 version of xpd
 */

#include <iostream>
#include <cstdlib>

#include <xpd/Xpd.h>

using namespace std;

// Data that would usually be part of some class that is doing the reading
XpdReader *_xFile = 0;
bool _errOccurred = false;
string _fileName = "";
int _blockIndex;


/**
 * Begin reading a particular geometries points. This implies you will be
 * reading all the faces for one geometry before proceeding with the next.
 * If this isn't the case then this code must be called 
 */
bool
beginGeom( const string &geomName )
{
    if ( _errOccurred ) return false;

    // Close the current file if one is open
    if ( _xFile ) {
        bool succeeded = _xFile->close();
        _xFile = 0;
        if ( !succeeded ) {
            cerr << "Failed to close xuv file: " << _fileName << endl;
            _errOccurred = true;
            return false;
        }
    }
    
    // Construct the name of cache file
    _fileName = geomName + ".xuv";
    
    // Open the new file (this assumes reading happens in geometry order
    // and not bouncing back and forth. If this isn't the case then this
    // can be inefficient).
    _xFile = XpdReader::open( _fileName );
    if ( !_xFile ) {
        cerr << "Failed to open xuv file: " << _fileName << endl;
        _errOccurred = true;
        return false;
    }

    // Get the index for the "Location" block.
    _blockIndex = _xFile->blockIndex("Location");
    if ( _blockIndex < 0 ) {
        cerr << "Failed to find the Location block in file: "
             << _fileName << endl;
        _errOccurred = true;
        return false;
    }
    
    // Check that the primitive type is correct.
    if ( _xFile->primType() != Xpd::Point ) {
        cerr << "Incorrect primitive type in XUV file: " << _fileName << endl;
        _errOccurred = true;
        return false;
    }
    return true;
}
                                               

/**
 * Process a specific face. This allows direct access to a particular face
 * regardless of the order they were written into the xuv file. The xuv
 * point data is within the PNTS chunk with other data in other optional
 * chunks following PNTS. If primsPerChunk is used set to anything but zero
 * then the chunks read will be interleaved with PNTS first, custom chunks,
 * and then the next PNTS chunk and so forth.
 *
 * Note: primsPerChunk currently not supported. 
 */
bool
processFace( int faceId )
{
    // Make sure an error did not occur when reading the xuv file
    if ( _errOccurred ) return false;
    
    if ( !_xFile->findFace(faceId) ) {
        cerr << "Face id " << faceId << " not found in xuv file: "
             << _fileName << endl;
        _errOccurred = true;
        return false;
    }
    
    unsigned int numPoints = _xFile->numPrims();
    if ( numPoints == 0 ) return true;

    if ( !_xFile->findBlock(_blockIndex) ) {
        cerr << "Failed to find block in xuv file: " << _fileName << endl;
        _errOccurred = true;
        return false;
    }

    // Get the data from the block
    safevector<float> data;

    cout << "Face: " << faceId << "  (direct access)" << endl;
    for ( unsigned int i=0; i<numPoints; i++ ) {

        // Read in the next position
        _xFile->readPrim(data);
        unsigned int id = (unsigned int)(data[0]);
        double u = double(data[1]);
        double v = double(data[2]);

        // Dump the point out
        cout << "   Point[" << i << "]: id= " << id << "  coordinates=("
             << u << ", " << v << ")" << endl;
    }
    return true;
}


bool
processNextFace()
{
    // Make sure an error did not occur when reading the xuv file
    if ( _errOccurred ) return false;
    
    if ( !_xFile->nextFace() ) {
        return false;
    }
    int faceId = _xFile->faceid();
    
    unsigned int numPoints = _xFile->numPrims();
    if ( numPoints == 0 ) return true;

    if ( !_xFile->findBlock(_blockIndex) ) {
        cerr << "Failed to find block in xuv file: " << _fileName << endl;
        _errOccurred = true;
        return false;
    }

    // Get the data from the block
    safevector<float> data;

    cout << "Face: " << faceId << "  (traversal access)" << endl;
    for ( unsigned int i=0; i<numPoints; i++ ) {

        // Read in the next position
        _xFile->readPrim(data);
        unsigned int id = (unsigned int)(data[0]);
        double u = double(data[1]);
        double v = double(data[2]);

        // Dump the point out
        cout << "   Point[" << i << "]: id= " << id << "  coordinates=("
             << u << ", " << v << ")" << endl;
    }
    return true;
}


/**
 * Finish reading the files. This will catch closing out the last file opened.
 */
void
finishReading()
{
    if ( _xFile ) {
        _xFile->close();
        _xFile = 0;
    }
}


int
main (int argc, char *argv[])
{
    if ( argc < 2 ) {
        cerr << endl << "usage: rxuv <geomName> [faceId]" << endl << endl;
        exit(1);
    }
    string geomName(argv[1]);

    // Open for reading
    if ( !beginGeom( geomName ) ) exit(1);

    if ( argc == 3 ) {

        // Read a particular face
        int faceId = atoi(argv[2]);
        processFace( faceId );
        
    } else {
        
        // Read all faces in order
        while ( processNextFace() );

    }
    
    // Finish reading
    finishReading();
}
