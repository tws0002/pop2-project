// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file wxuv.cpp
 * @brief Simple program to illustrate writing out xuv files.
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

// Data that would usually be part of some class that is doing the writing
XpdWriter *_xFile = 0;
bool _errOccurred = false;
string _fileName = "";


/**
 * Begin processing on a piece of geometry. This process requires you
 * process the faces of one geometry before moving on to the next
 * geometry. The order of the faces is not important, but you must
 * complete them all before starting another piece of geometry.
 */
bool
beginGeom( const string &geomName, int geomFaces )
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
    
    // Open the new file (this assumes writing happens in geometry order
    // and not bouncing back and forth. If this isn't the case then this
    // will destroy previous cached results).
    safevector<string> blocks(1,"Location");
    _xFile = XpdWriter::open( _fileName, geomFaces, Xpd::Point, 1,
                              Xpd::World, blocks, 0.0, 1 );    
    if ( !_xFile ) {
        cerr << "Failed to open xuv file: " << _fileName << endl;
        _errOccurred = true;
        return false;
    }

    return true;
}


/**
 * Process a face by writing new points into the xuv file. The xuv data
 * should go into the Location block and that block should be first. Other
 * data can go into subsequent blocks.
 */
void
processFace( int faceId, int points )
{
    // Make sure an error did not occur when creating the xuv file
    if ( _errOccurred ) return;
    
    // Start the face
    if ( !_xFile->startFace( faceId ) ) {
        cerr << "Failed to start a new face in xuv file: " << _fileName <<endl;
        _errOccurred = true;
        return;
    }
    // Start the Location block
    if ( !_xFile->startBlock() ) {
        cerr << "Failed to start block in xuv file: " << _fileName<<endl;
        _errOccurred = true;
        return;
    }

    // Number of points painted on face
    srand48( faceId );
    int numPoints = (int)(drand48()*points*0.1)+points;

    cout << "Face " << faceId << endl;
    
    // Get a handle to the current chunks data
    safevector<float> data(3);
    for ( unsigned int i=0; i<numPoints; i++ ) {
        
        // Put out the location
        data[0] = i;          // unique id for the point
        data[1] = drand48();  // u coordinate
        data[2] = drand48();  // v coordinate
        cout << "   " << data[0] << " " << data[1] << " " << data[2] << endl;
        _xFile->writePrim(data);
    }
}


/**
 * Finish writing the files. This will catch closing out the last file
 * opened and currently being written into.
 */
void
finishWriting()
{
    if ( _xFile ) {
        _xFile->close();
        _xFile = 0;
    }
    if ( _errOccurred ) {
        unlink( _fileName.c_str() );
    }
}


int
main (int argc, char *argv[])
{
    if ( argc < 4 ) {
        cerr << endl << "usage: wxuv <geomName> <numFaces> <points>"
             << endl << endl;
        exit(1);
    }
    
    // Get the geometry name and the number of faces
    string geomName(argv[1]);
    int nfaces = atoi(argv[2]);
    int points = atoi(argv[3]);
    
    // Process each face in turn for one piece of geometry
    beginGeom( geomName, nfaces );
    for ( int i=0; i<nfaces; i++ ) {
        processFace( i, points );
    }
    finishWriting();
}
