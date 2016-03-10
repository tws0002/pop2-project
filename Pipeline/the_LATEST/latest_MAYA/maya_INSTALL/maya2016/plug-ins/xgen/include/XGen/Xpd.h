// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file Xpd.h
 * @brief Contains the declarations of the public Xpd classes.
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
 * @version tthompso  08/15/08  Initial Version
 */

#ifndef XPD_H
#define XPD_H

#include <string>
#include <XgPorting/safevector.h>
#include <map>
#include <XgWinExport.h>


struct Xpd {
    enum PrimType     { Point=0, Spline, Card, Sphere, Archive, CustomPT=99 };
    enum CoordSpace   { World=0, Object, Local, Micro, CustomCS=99 };
};


class XGEN_XPDFILE_EXPORT XpdWriter
{
public:
    /* Open an XPD file for writing. */
    static XpdWriter *open( const std::string &filename, unsigned int nfaces,
                            Xpd::PrimType pt, unsigned char pversion,
                            Xpd::CoordSpace cs, 
                            const safevector<std::string> &blocks,
                            float t, unsigned int ncvs,
                            const safevector<std::string> *keys=0 );

    /* Start a new face within the file opened for writing. */
    virtual bool startFace( unsigned int faceid ) = 0;
    /* Start a new block within the current face. */
    virtual bool startBlock() = 0;
    /* Write a primitive within the current block. */
    virtual bool writePrim( const safevector<float> &data ) = 0;
    /* Map for converting the keys into ids. */
    virtual const std::map<std::string,int> &keyToId() = 0;
    /* Close the XPD file and delete the writer. */
    virtual bool close() = 0;
    
protected:
    virtual ~XpdWriter() {}
};

class XGEN_XPDFILE_EXPORT XpdReader
{
public:
    /* Open an XPD file for reading. */
    static XpdReader *open( const std::string &filename );

    /* Find a particular face in the file. */
    virtual bool findFace( unsigned int faceid ) = 0;
    /* Find a particular block by index. */
    virtual bool findBlock( unsigned int index ) = 0;
    /* Move forward to the next face within the file. */
    virtual bool nextFace() = 0;
    /* Move forward to the next face within the file. */
    virtual bool nextBlock() = 0;
    /* Read a primitive from the current block. */
    virtual bool readPrim( safevector<float> &data ) = 0;
    /* Close the XPD file and delete the reader. */
    virtual bool close() = 0;
    /* Print out the current state of file. */
    virtual void print(std::ostream &out) const = 0;
    
    virtual unsigned int numFaces() const = 0;
    virtual int faceid() const = 0;
    virtual const safevector<std::string> &blocks() const = 0;
    virtual int blockIndex( const char *name="" ) const = 0;
    virtual Xpd::PrimType primType() const = 0;
    virtual unsigned char primVersion() const = 0;
    virtual unsigned int numPrims() const = 0;
    virtual float time() const = 0;
    virtual unsigned int numCVs() const = 0;
    virtual Xpd::CoordSpace coordSpace() const = 0;
    virtual const safevector<std::string> &keys() const = 0;

protected:
    virtual ~XpdReader() {}
};

class XpdReaderHandle
{
public:
	XpdReaderHandle( const std::string &fileName )
	{
		_xpdReaderPtr = NULL; 
		_xpdReaderPtr = XpdReader::open(fileName); 
	}
	~XpdReaderHandle()
	{
		if(_xpdReaderPtr)
			_xpdReaderPtr->close(); 
	}
	XpdReader* getXpdReader(){ return _xpdReaderPtr; }
	bool isValid(){ return _xpdReaderPtr != NULL; }
private:
	XpdReaderHandle(); 
	XpdReader* _xpdReaderPtr;
};

#endif
