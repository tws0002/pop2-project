// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file xpdcmp.cpp
 * @brief Compares two FileRenders for frame to frame coherance
 *
 * <b>CONFIDENTIAL INFORMATION: This software is the confidential and
 * proprietary information of Walt Disney Animation Studios ("WDAS").
 * This software may not be used, disclosed, reproduced or distributed
 * for any purpose without prior written authorization and license
 * from WDAS. Reproduction of any section of this software must include
 * this legend and all copyright notices.
 * Copyright Disney Enterprises, Inc. All rights reserved.</b>
 *
 * @author Stephen Bowline
 *
 * @version sbowline  12/02/03  Initial Version
 * @version lgramlin  09/28/06  Update for xgen5 version of xpd
 * @version tthompso  10/06/08  Update for xgen6 version of xpd
 */

#include <iostream>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <xpd/Xpd.h>

using namespace std;

extern int optind, opterr;

int 
main( int argc, char *argv[] ) {

    XpdReader *xpd1,*xpd2;
    unsigned int i, j;
    int c;
    bool error=false,verbosity=false;

    char *filename1, *filename2;

    opterr=0;
    while ( (c=getopt( argc, argv, "v")) != -1 ) {
        switch (c) {
            case 'v': verbosity=true;
                break;
            default:  error = true;
                break;
        }
    }

    if ( (argc - optind) != 2 || error ) {
        cerr << "Usage: " << argv[0] << " [-v] file1 file2" << endl;
        exit(1);
    }

    filename1 = strdup( argv[optind] );
    filename2 = strdup( argv[optind+1] );
    xpd1 = XpdReader::open( filename1 );
    if ( !xpd1 ) exit(1);
    xpd2 = XpdReader::open( filename2 );
    if ( !xpd2 ) exit(1);

    // Verify primType
    if ( xpd1->primType() != xpd2->primType() ) {
        cerr << "ERROR: Files have different primTypes." << endl;
        xpd1->close();
        xpd2->close();
        exit(1);
    }

    // Verify primVersion
    if ( xpd1->primVersion() != xpd2->primVersion() ) {
        cerr << "ERROR: Files have different primVersions." << endl;
        xpd1->close();
        xpd2->close();
        exit(1);
    }
    
    // Verify coordSpace
    if ( xpd1->coordSpace() != xpd2->coordSpace() ) {
        cerr << "ERROR: Files have different coordSpaces." << endl;
        xpd1->close();
        xpd2->close();
        exit(1);
    }
    
    // Verify number of faces
    if ( xpd1->numFaces() != xpd2->numFaces() ) {
        cerr << "ERROR: Files have a different number of faces." << endl;
        cerr << "File: " << filename1 << " has " << xpd1->numFaces() << endl;
        cerr << "File: " << filename2 << " has " << xpd2->numFaces() << endl;
        xpd1->close();
        xpd2->close();
        exit(1);
    }

    // Verify number of CVs
    if ( xpd1->numCVs() != xpd2->numCVs() ) {
        cerr << "ERROR: Files have a different number of CVs." << endl;
        cerr << "File: " << filename1 << " has " << xpd1->numCVs() << endl;
        cerr << "File: " << filename2 << " has " << xpd2->numCVs() << endl;
        xpd1->close();
        xpd2->close();
        exit(1);
    }

    // Verify the blocks
    if ( xpd1->blocks() != xpd2->blocks() ) {
        cerr << "ERROR: Files contain different blocks." << endl;
        cerr << "File: " << filename1 << " has ";
        for ( i = 0; i < xpd1->blocks().size(); i++ )
            cerr << "\"" << xpd1->blocks()[i] << "\" ";
        cerr << endl;
        cerr << "File: " << filename2 << " has ";
        for ( i = 0; i < xpd2->blocks().size(); i++ )
            cerr << "\"" << xpd2->blocks()[i] << "\" ";
        cerr << endl;
        xpd1->close();
        xpd2->close();
        exit(1);
    }
    unsigned int numBlocks = xpd1->blocks().size();
        
    // Verify the keys
    if ( xpd1->keys() != xpd2->keys() ) {
        cerr << "ERROR: Files contain different keys." << endl;
        cerr << "File: " << filename1 << " has ";
        for ( i = 0; i < xpd1->keys().size(); i++ )
            cerr << "\"" << xpd1->keys()[i] << "\" ";
        cerr << endl;
        cerr << "File: " << filename2 << " has ";
        for ( i = 0; i < xpd2->keys().size(); i++ )
            cerr << "\"" << xpd2->keys()[i] << "\" ";
        cerr << endl;
        xpd1->close();
        xpd2->close();
        exit(1);
    }
        
    // Begin comparing each face
    safevector<float> data1;
    safevector<float> data2;
    while( xpd1->nextFace() ){
        int faceid = xpd1->faceid();
        if(!xpd2->findFace(faceid)){
            cerr << "ERROR: Cannot find faceid: "<< faceid << " for file: " 
                 << filename2 << endl;
            xpd1->close();
            xpd2->close();
            exit(1);
        }

        // Verify the num primitives
        if (xpd1->numPrims() != xpd2->numPrims()) {
            cerr << "ERROR: Files have different number of primitives on "
                 << "face " << faceid << endl;
            cerr << "File: " << filename1 << " has " << xpd1->numPrims()<<endl;
            cerr << "File: " << filename2 << " has " << xpd2->numPrims()<<endl;
            xpd1->close();
            xpd2->close();
            exit(1);
        }

        if (verbosity) {
            cout << "faceId: " << faceid << " has " << xpd1->numPrims()
                 << " total primitives" << endl;
        }

        // Traverse the blocks
        for ( j = 0; j < numBlocks; j++ ) {

            if ( !xpd1->nextBlock() ) {
                cerr << "ERROR: Unable to start block # " << j << " in "
                     << filename1 << endl;
                xpd1->close();
                xpd2->close();
                exit(1);
            }
            if ( !xpd2->nextBlock() ) {
                cerr << "ERROR: Unable to start block # " << j << " in "
                     << filename2 << endl;
                xpd1->close();
                xpd2->close();
                exit(1);
            }
            
            // Traverse the primitives
            for ( i = 0; i < xpd1->numPrims(); i++ ) {

                if ( !xpd1->readPrim( data1 ) ) {
                    cerr << "ERROR: Unable to read prim # " << i << " from "
                         << filename1 << endl;
                    xpd1->close();
                    xpd2->close();
                    exit(1);
                }
                if ( !xpd2->readPrim( data2 ) ) {
                    cerr << "ERROR: Unable to read prim # " << i << " from "
                         << filename2 << endl;
                    xpd1->close();
                    xpd2->close();
                    exit(1);
                }
            }
        }
    }
    xpd1->close();
    xpd2->close();

    if (verbosity)  cout << "Content is the same (values may differ)" << endl;
    exit(0);
}
