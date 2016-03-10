#ifndef XPDFILECACHEDWRITER_H
#define XPDFILECACHEDWRITER_H

#include <fstream>

#include <string>

#include <xpd/Xpd.h>
#include <xpd/XpdFile.h>

class XpdFileCachedWriterContext
{
    friend class XpdFileCachedWriter;

public:
    XpdFileCachedWriterContext()
        : _currentBlock(-1)
        , _faceIndex(-1)
        , _blockIndex(-1)
        , _bufferSize(0)
        , _data(NULL)
    {;}

    safevector<float> &      data() { return *_data; }

private:
    int                      _currentBlock;  //  Location of block 
    int                      _faceIndex;     //  Index into arrays
    int                      _blockIndex;    //  Index into blocks
    int                      _bufferSize;    //  Buffer size of the block before increased

    safevector<float>*       _data;          //  Point to the cached data for the current block

};

class XGEN_XPDFILE_EXPORT XpdFileCachedWriter
{ 
public:

    /** Constructor */
    XpdFileCachedWriter() 
        : _fileHeadSize(0)
        , _fileName("")
        , _isOpen(false)
    {}

    /* Destructor */
    ~XpdFileCachedWriter(){};

    /** @name Write Functions */
    //@{
    bool openWrite( const std::string &filename, safevector<int> &faceIds,
        Xpd::PrimType pt, unsigned char pversion,
        Xpd::CoordSpace cs, 
        const safevector<std::string> &blocks,
        float t, unsigned int ncvs,
        const safevector<std::string> *keys=0 );
    bool startFace( XpdFileCachedWriterContext &cachedContext, unsigned int faceid );
    bool startBlock( XpdFileCachedWriterContext &cachedContext );
    bool writePrim( XpdFileCachedWriterContext &cachedContext );
    const std::map<std::string,int> &keyToId();
    //@}

    bool isOpen() { return _isOpen; }

    /** Commit and close the XPD file. */
    bool commitAndClose();

    /** Close the XPD file only */
    void close();

protected:

    bool writeFileHeader( std::fstream &stream )
    {
        if ( stream.seekp( 0, std::ios::beg ).fail()) { return false; }
        if ( stream.write( XpdFile::magic, 4 ).fail()) { return false; }
        return _fileHeader.write( stream ); 
    }

    typedef safevector<float> CachedDataPerBlock;
    safevector<CachedDataPerBlock> _cacheData;     //  Data buffer

    FileHeader               _fileHeader;    //  Our file header
    unsigned int             _fileHeadSize;
    std::string              _fileName;      //  Filename in use
    bool _isOpen;

}; // XpdFileCachedWriter

#endif

// ==================================================================
// Copyright 2014 Autodesk, Inc.  All rights reserved.
// 
// This computer source code  and related  instructions and comments are
// the unpublished confidential and proprietary information of Autodesk,
// Inc. and are  protected  under applicable  copyright and trade secret
// law. They may not  be disclosed to, copied or used by any third party
// without the prior written consent of Autodesk, Inc.
// ==================================================================
