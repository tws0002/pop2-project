#ifndef XPDFILECACHEDREADER_H
#define XPDFILECACHEDREADER_H

#include <fstream>

#include <string>
#include <set>

#include <tbb/mutex.h>

#include <xpd/Xpd.h>
#include <xpd/XpdFile.h>

class XpdFileCachedReaderContext
{
    friend class XpdFileCachedReader;

public:
    XpdFileCachedReaderContext()
        : _current(0)
        , _faceIndex(-1)
        , _blockIndex(-1)
        , _primIndex(-1)
    {;}

	const safevector<float> &      data() { return _data; }

private:
    XpdBlockUInt             _current;       //  Location of face 
    int                      _faceIndex;     //  Index into arrays
    int                      _blockIndex;    //  Index into blocks
    int                      _primIndex;     //  Index into primitives
    safevector<float>        _data;          //  Cached data for current context
};

class XGEN_XPDFILE_EXPORT XpdFileCachedReader
{ 
public:
    typedef std::set<XpdFileCachedReader*> CachedReaderSet;

    /** Constructor */
    XpdFileCachedReader() 
        : _fileHeader()
        , _fileHeaderEnd(0)
        , _fileTime(0)
        , _fileSize(0)
    {
        _cacheReaders.insert(this);
    }

    /* Destructor */
    ~XpdFileCachedReader() 
    { 
         finish();
         clearCache();

         _cacheReaders.erase(this);
    }

    /** @name Read Functions */
    //@{
    bool openRead( const std::string &filename ) ;
    bool findFace( XpdFileCachedReaderContext &cachedContext, unsigned int faceid );
    bool nextFace( XpdFileCachedReaderContext &cachedContext );
    bool findBlock( XpdFileCachedReaderContext &cachedContext ,unsigned int index );
    bool nextBlock( XpdFileCachedReaderContext &cachedContext );
    bool readPrim( XpdFileCachedReaderContext &cachedContext );
    //@}
    
    /** @name Cache Management */
    //@{
    static void setCacheSize( size_t newBytes );
    void clearCache();
    //@}

    /** @name Accessors */
    //@{
    unsigned int numFaces() const
    { return _fileHeader.numFaces; }

    int faceid( XpdFileCachedReaderContext &cachedContext ) const
    { return (cachedContext._faceIndex < 0 ? -1 : _fileHeader.faceid[cachedContext._faceIndex]); }

    const safevector<std::string> &blocks() const
    { return _fileHeader.block; }

    int blockIndex( XpdFileCachedReaderContext &cachedContext, const char *name ) const; // keep the original from XpdFile

    Xpd::PrimType primType() const
    { return _fileHeader.primType; }

    unsigned char primVersion() const
    { return _fileHeader.primVersion; }

    unsigned int numPrims( XpdFileCachedReaderContext &cachedContext ) const
    { return (cachedContext._faceIndex < 0 ? 0 : _fileHeader.numPrims[cachedContext._faceIndex]);}

    float time() const
    { return _fileHeader.time; }

    unsigned int numCVs() const
    { return _fileHeader.numCVs; }

    Xpd::CoordSpace coordSpace() const
    { return _fileHeader.coordSpace; }

    const safevector<std::string> &keys() const
    { return _fileHeader.key; }
    //@}

    void finish()
    { 
        if (_stream.is_open()) {
            _stream.close();
            _stream.clear();
        }
    }
protected:

    /** @name Protected I/O Functions */
    //@{
    bool readMagic( std::fstream &stream );

    bool readFileHeader( std::fstream &stream )
    { return _fileHeader.read( stream ); }

    XpdBlockUInt cachedBytes() const { return sizeof(float) * _cacheData.size(); }

protected:
    FileHeader               _fileHeader;    //  Our file header
    XpdBlockUInt             _fileHeaderEnd;
    safevector<float>        _cacheData;     //  Data buffer

    static size_t            _cacheSize;
    static size_t            _availableBytes;
    std::fstream             _stream;
    tbb::mutex               _readMutex;

    time_t		             _fileTime;
    size_t		             _fileSize;
    std::string              _filePath;

    static CachedReaderSet                 _cacheReaders;
    static XpdFileCachedReader*            _halfCachedReader; // Reader with half data cached.

}; // XpdFileCachedReader

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
