// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XpdFile.h
 * @brief Contains the declarations of the class XpdFile.
 *
 * <b>CONFIDENTIAL INFORMATION: This software is the confidential and
 * proprietary information of Walt Disney Animation Studios ("WDAS").
 * This software may not be used, disclosed, reproduced or distributed
 * for any purpose without prior written authorization and license
 * from WDAS. Reproduction of any section of this software must include
 * this legend and all copyright notices.
 * Copyright Disney Enterprises, Inc. All rights reserved.</b>
 *
 * @author Sean Jenkins
 * @author Stephen Bowline
 * @author Thomas V Thompson II
 *
 * @version sjenkins  11/20/03  Initial Version
 * @version sbowline  12/02/03  Added FileRender class
 * @version sbowline  08/24/04  Added coordinate system tag
 * @version lchai     04/28/06  Added num tag
 * @version tthompso  08/30/06  XGen5 conversion to per face - v2.0
 * @version bachorn   04/05/07  Fixed int/unsigned warning
 * @version tthompso  03/12/08  Add method to read whole face into string
 * @version tthompso  08/29/08  XGen6 upgrade - lighter, faster, private...
 */

#ifndef XPDFILE_H
#define XPDFILE_H

#include <iostream>
#include <fstream>
#include <string>

#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include <xpd/Xpd.h>
#include <XgWinExport.h>

#ifdef XGEN_XPD_READ_OLD_WINDOWS_FILES
typedef uint32_t XpdBlockUInt; // 32bits indices to read old windows files created during first XGen Betas.
#else
typedef uint64_t XpdBlockUInt; // 64bits indices as it awlays has been on Linux.
#endif

/**
 * @brief A class for describing the XPD file header.
 *
 * The XPD file header is always 39 bytes of constant data and then
 * variable size allotment to hold the list of block tags, keys, and
 * face index table.
 */
struct XGEN_XPDFILE_EXPORT FileHeader
{
public:

    /** Constructor */
    FileHeader() : primSize(0), faceid(0), numPrims(0), blockPosition(0) {}

    /* Desctructor */
    ~FileHeader();
        
    /* Initialize the current instance */
    unsigned int init( unsigned int nfaces,
                       Xpd::PrimType pt, unsigned char pversion,
                       Xpd::CoordSpace cs, 
                       const safevector<std::string> &blocks,
                       float t, unsigned int ncvs,
                       const safevector<std::string> *keys );

    /* I/O functions for dealing with an XPD header. */
    bool read( std::fstream & s );
    bool write( std::fstream & s ) const; 
  
    /** Dump header info to an output stream. */
    friend std::ostream & operator<< ( std::ostream &out,
                                       const FileHeader &h ) {
        unsigned int i,j;
        out << "    fileVersion:  " << (unsigned int)h.fileVersion <<std::endl;
        out << "    primType:     " << h.primType << std::endl;
        out << "    primVersion:  " << (unsigned int)h.primVersion <<std::endl;
        out << "    time:         " << h.time << std::endl;
        out << "    numCVs:       " << h.numCVs << std::endl;
        out << "    coordSpace:   " << h.coordSpace << std::endl;
        out << "    numFaces:     " << h.numFaces << std::endl;
        out << "    blocks:       ";
        unsigned int hbs = h.block.size();
        for ( i = 0; i < hbs; i++ )
            out << "(" << h.block[i] << " " << h.primSize[i] << ") ";
        out << std::endl;
        out << "    keys:         ";
        for ( i = 0; i < h.key.size(); i++ )
            out << "(" << h.key[i] << ") ";
        out << std::endl;
        out << "    faceTable:    ";
        for ( i = 0; i < h.numFaces; i++ ) {
            if ( h.faceid[i] < 0 ) break;
            out << "(" << h.faceid[i] << " : ";
            out << h.numPrims[i] << " :";
            for ( j = 0; j < hbs; j++ )
                out << " " << h.blockPosition[j+(i*hbs)];
            out << ") ";
        }
        out << std::endl;

        return out;
    }

public:

    // First 4 bytes of file contain magic number. Any change to this block
    // of data must result in a bump of the file version and an update to
    // the XPDFILE_FILEHEAD_SIZE
    unsigned char             fileVersion;  // version for xpd headers
    Xpd::PrimType             primType;     // primitive type
    unsigned char             primVersion;  // version for primitive data
    float                     time;         // time for data
    unsigned int              numCVs;       // number of CVs per primitive
    Xpd::CoordSpace           coordSpace;   // coordinate space        
    unsigned int              numFaces;     // number of faces in file

    // Tags for the data blocks
    unsigned int              numBlocks;    // number of blocks
    safevector<std::string>  block;        // block names
    unsigned int             *primSize;     // prim size per block
        
    // Keyed strings for index reference within data
    safevector<std::string>  key;
    std::map<std::string,int> keyToId;
        
    // The face table is not a fixed size
    int                      *faceid;        // array of faceids
    unsigned int             *numPrims;      // number of prims in face
    XpdBlockUInt             *blockPosition; // array of block pointers
        
}; // FileHeader


/**
 * @brief  A class for reading/writing primitive geometry.
 *
 * This class describes a file for reading and writing cached XgPrimitive
 * geometry. These files are used to cache a baked groom, point locations
 * for generators, clump locations, and so forth. Any per face packed
 * data can be placed within an XPD file.
 */
class XGEN_XPDFILE_EXPORT XpdFile : public XpdWriter, public XpdReader
{ 
public:

    /** @name Constants */
    //@{
    static char    magic[5];            // Magic number
    //@}

    /** @name IO Enumeration */
    enum IOType { IO_UNDEF =0x00,       //  File is unopened
                  IO_WRITE =0x01,       //  File has been opened for write
                  IO_READ  =0x02 };     //  File has been opened for reading

    //@}


    /** Constructor */
    XpdFile() : _iotype( IO_UNDEF ), _stream(), _fileHeader(),
                _facePtr(0), _faceIndex(-1), _blockIndex(-1),
                _cache(0), _cacheLen(0) {;}

    /* Destructor */
    ~XpdFile();

    /** @name Read Functions */
    //@{
    virtual bool openRead( const std::string &filename ) ;
    virtual bool findFace( unsigned int faceid );
    virtual bool nextFace();
    virtual bool findBlock( unsigned int index );
    virtual bool nextBlock();
    virtual bool readPrim( safevector<float> &data );
    //@}

    /** @name Write Functions */
    //@{
    virtual bool openWrite( const std::string &filename, unsigned int nfaces,
                            Xpd::PrimType pt, unsigned char pversion,
                            Xpd::CoordSpace cs, 
                            const safevector<std::string> &blocks,
                            float t, unsigned int ncvs,
                            const safevector<std::string> *keys=0 );
    virtual bool startFace( unsigned int faceid );
    virtual bool startBlock();
    virtual bool writePrim( const safevector<float> &data );
    virtual const std::map<std::string,int> &keyToId();
    bool writeCache( const float *cache, unsigned int &len );
    //@}
    
    /* Close the XPD file. */
    virtual bool close();

    /** @name Accessors */
    //@{
    virtual unsigned int numFaces() const
        { return _fileHeader.numFaces; }
    virtual int faceid() const
        { return (_faceIndex < 0 ? -1 : _fileHeader.faceid[_faceIndex]);}
    virtual const safevector<std::string> &blocks() const
        { return _fileHeader.block; }
    virtual int blockIndex( const char *name ) const;
    virtual Xpd::PrimType primType() const
        { return _fileHeader.primType; }
    virtual unsigned char primVersion() const
        { return _fileHeader.primVersion; }
    virtual unsigned int numPrims() const
        { return (_faceIndex < 0 ? 0 : _fileHeader.numPrims[_faceIndex]);}
    virtual float time() const
        { return _fileHeader.time; }
    virtual unsigned int numCVs() const
        { return _fileHeader.numCVs; }
    virtual Xpd::CoordSpace coordSpace() const
        { return _fileHeader.coordSpace; }
    virtual const safevector<std::string> &keys() const
        { return _fileHeader.key; }
    //@}

    /* Print out current state of file. */
    virtual void print(std::ostream &out) const;

protected:

    /** @name Protected I/O Functions */
    //@{
    bool readMagic();

    bool readFileHeader()
        { return _fileHeader.read( _stream ); }

    bool writeFileHeader()
        { if ( _stream.seekp( 0, std::ios::beg ).fail()) { return false; }
          if ( _stream.write( magic, 4 ).fail()) { return false; }
          return _fileHeader.write( _stream ); }
    //@}


protected:

    std::string              _filename;      //  Filename in use
    IOType                   _iotype;        //  Read or write
    std::fstream             _stream;        //  Unix file stream
    FileHeader               _fileHeader;    //  Our file header
    unsigned int             _facePtr;       //  Location of face 
    int                      _faceIndex;     //  Index into arrays
    int                      _blockIndex;    //  Index into blocks
    int                      _primIndex;     //  Index into primitives
    unsigned int             _fileHeadSize;  //  Size of the file header
    float                   *_cache;         //  Cache of data to be written
    unsigned int             _cacheLen;      //  Length of the cache
}; // XpdFile

#endif
