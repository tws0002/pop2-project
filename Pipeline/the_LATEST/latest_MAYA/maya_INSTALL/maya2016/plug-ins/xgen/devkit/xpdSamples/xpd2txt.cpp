// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file xpd2txt.cpp
 * @brief Convert the XPD file into a text format
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
 * @version tthompso  08/29/08  Initial Version
 */

#include <iostream>
#include <XgPorting/safevector.h>

#include <xpd/Xpd.h>

using namespace std;


/**
 * Print out proper command usage.
 */
int usage() {  
    cerr << "USAGE: xpd2txt <FILE>\n";
    return 1;
}


int 
main( int argc, char *argv[] )
{
    XpdReader *xpd;

    if ( argc < 2 ) return usage();
    char *filename = argv[1];

    xpd = XpdReader::open( filename );
    if ( !xpd ) {
        cerr << "Failed to open xuv file: " << filename << endl;
        return 2;
    }
 
    // Put out the file header
    xpd->print(cout);

    while( xpd->nextFace() ) {

        // Put out the face header
        xpd->print(cout);

        while ( xpd->nextBlock() ) {

            // Put out the block name
            xpd->print(cout);

            safevector<float> data;
            while( xpd->readPrim(data) ) {

                // Dump out the data
                cout << "        ";
                for ( unsigned int i=0; i<data.size(); i++ ) {
                    cout << data[i] << " ";
                }
                cout << endl;
            }
        }
    }

    xpd->close();
    cout << endl << "Success." << endl;
    return 0;
}
