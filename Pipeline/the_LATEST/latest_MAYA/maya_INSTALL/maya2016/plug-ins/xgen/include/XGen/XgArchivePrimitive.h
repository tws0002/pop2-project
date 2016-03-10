// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgArchivePrimitive.h
 * @brief Contains the declaration of the class XgArchivePrimitive.
 *
 * <b>CONFIDENTIAL INFORMATION: This software is the confidential and
 * proprietary information of Walt Disney Animation Studios ("WDAS").
 * This software may not be used, disclosed, reproduced or distributed
 * for any purpose without prior written authorization and license
 * from WDAS. Reproduction of any section of this software must include
 * this legend and all copyright notices.
 * Copyright Disney Enterprises, Inc. All rights reserved.</b>
 *
 * @author Ernie Petti
 * @author Thomas V Thompson II
 * @author Stephen D. Bowline
 * @author Lawrence Chai
 *
 * @version Created 05/16/03
 */

#ifndef XGARCHIVEPRIMITIVE_H
#define XGARCHIVEPRIMITIVE_H

#include <iostream>
#include <string>
#include <map>

#include <tbb/concurrent_unordered_set.h>

#include "XGen/XgUtil.h"
#include "XGen/XgPrimitive.h"
#include "XGen/SgVec3T.h"
#include "XgWinExport.h"
#include "XGen/XgArchivePrimitiveContext.h"


class XgDescription;
class XgPatch;


/**
 * @brief A primitive of a archive primitive.
 *
 * This class represents a archive primitive. It contains all of the attributes
 * that are needed to completely describe the archive primitive.
 */
class XGEN_EXPORT XgArchivePrimitive : public XgPrimitive
{
public:

	typedef enum {
		LOW = 0, 
		MED = 1,
		HI  = 2,

		PROXY = 3,
		LOD_COUNT = 3,
		INDEX_COUNT = 4
	} INDEX;

    /* Constructor. */
    XgArchivePrimitive( XgDescription *descr );

    /* Destructor. */
    virtual ~XgArchivePrimitive();

    void createContext();
    virtual XgPrimitiveContext* cloneContextImp();
    const XgArchivePrimitiveContext* context() const { return (XgArchivePrimitiveContext*)_context; }
    XgArchivePrimitiveContext* context() { return (XgArchivePrimitiveContext*)_context; }

    /* Initialize / Finalize description. */
    virtual void initDescription();
    virtual void initDescriptionInParallel( XgPrimitiveContext& context);
	virtual void finishDescription();
    
    /* Process files attribute. */
    void processFiles();
    
    /** @name Accessors */
    //@{
    const XgExpression &twist() const { return _twist; }

    unsigned int size( unsigned int lod, XgArchivePrimitiveContext* context = NULL)
	{
        int idx;
        if (context)
            idx = context->index(lod);
        else
            idx = index(lod);
		FileDescListMap::const_iterator it = _fileDescs.find( idx );
		if( it!=_fileDescs.end() )
			return (unsigned int)it->second.size();
		return 0; 
	}
    const std::string &fileName(unsigned int lod,unsigned int itemIndex, bool full) const
    { 
        FileDescListMap::const_iterator it = _fileDescs.find( index(lod) );
        if( it!=_fileDescs.end() )
        {
            const FileDescList& curList = it->second;
            if( itemIndex < curList.size() )
            {
                const FileDesc& cur = curList[itemIndex];
                return full ? cur._fileName.first : cur._fileName.second;
            }
        }
        static std::string s_emptyString;
        return s_emptyString;
    }
    const safevector< std::string > &objectNames(unsigned int lod,unsigned int itemIndex) const
    {
        FileDescListMap::const_iterator it = _fileDescs.find( index(lod) );
        if( it!=_fileDescs.end() )
        {
            const FileDescList& curList = it->second;
            if( itemIndex < curList.size() )
            {
                const FileDesc& cur = curList[itemIndex];
                return cur._polymeshNames;
            }
        }
        static safevector< std::string > s_emptyList;
        return s_emptyList;
    }
    bool useBBox(unsigned int lod,unsigned int itemIndex) const
    { 
        FileDescListMap::const_iterator it = _fileDescs.find( index(lod) );
        if( it!=_fileDescs.end() )
        {
            const FileDescList& curList = it->second;
            if( itemIndex < curList.size() )
            {
                const FileDesc& cur = curList[itemIndex]; // increment the index
                return cur._useArchiveBBox;
            }
        }
        return false;
    }

    std::string materialName(unsigned int lod,unsigned int itemIndex) const
    { 
        FileDescListMap::const_iterator it = _fileDescs.find( index(lod) );
        if( it!=_fileDescs.end() )
        {
            const FileDescList& curList = it->second;
            if( itemIndex < curList.size() )
            {
                const FileDesc& cur = curList[itemIndex];
                return cur._materialName;
            }
        }
        static std::string s_emptyMat;
        return s_emptyMat;
    }

    void materialNames( std::set< std::string >& materialNames ) const
    {
        materialNames.clear(); 
        for( FileDescListMap::const_iterator it = _fileDescs.begin(); it!=_fileDescs.end(); ++it )
        {
            for( unsigned int i = 0; i < it->second.size(); i++ )
                materialNames.insert( it->second[i]._materialName );
        }
    }

    const std::string &fileNameOfLod(unsigned int lodIndex,unsigned int itemIndex, bool full) const
    {
        FileDescListMap::const_iterator it = _fileDescs.find( lodIndex );
        if( it!=_fileDescs.end() )
        {
            const FileDescList& curList = it->second;
            if( itemIndex < curList.size() )
            {
                const FileDesc& cur = curList[itemIndex];
                return full ? cur._fileName.first : cur._fileName.second;
            }
        }
        static std::string s_emptyString;
        return s_emptyString;
    }
    const safevector< std::string > &objectNamesOfLod(unsigned int lodIndex,unsigned int itemIndex) const
    { 
        FileDescListMap::const_iterator it = _fileDescs.find( lodIndex );
        if( it!=_fileDescs.end() )
        {
            const FileDescList& curList = it->second;
            if( itemIndex < curList.size() )
            {
                const FileDesc& cur = curList[itemIndex];
                return cur._polymeshNames;
            }
        }
        static safevector< std::string > s_emptyList;
        return s_emptyList;
    }
    bool useBBoxOfLod(unsigned int lodIndex,unsigned int itemIndex) const
    {
        FileDescListMap::const_iterator it = _fileDescs.find( lodIndex );
        if( it!=_fileDescs.end() )
        {
            const FileDescList& curList = it->second;
            if( itemIndex < curList.size() )
            {
                const FileDesc& cur = curList[itemIndex]; // increment the index
                return cur._useArchiveBBox;
            }
        }
        return false;
    }

    std::string materialNameOfLod(unsigned int lodIndex,unsigned int itemIndex) const
    {
        FileDescListMap::const_iterator it = _fileDescs.find( lodIndex );
        if( it!=_fileDescs.end() )
        {
            const FileDescList& curList = it->second;
            if( itemIndex < curList.size() )
            {
                const FileDesc& cur = curList[itemIndex];
                return cur._materialName;
            }
        }
        static std::string s_emptyMat;
        return s_emptyMat;
    }
   
    unsigned int lodLo(unsigned int i) const { return _lodLo[i]; }
    unsigned int lodHi(unsigned int i) const { return _lodHi[i]; }
    bool useLevel(unsigned int i) const { return _useLevel[i]; }
    int index(unsigned int i) const { return context()->index(i); }
    //@}
    
    /** Cached attributes */
    //@{
    virtual unsigned int finalCVCount() { return 4; }
    //@}

    /* Set class attributes. */
    virtual bool setAttr( const std::string &name, 
                          const std::string &value, 
                          const std::string &type="float",
			  const std::string &uiHint="" );

    /** Return the name of this type of primitive. */
    virtual std::string typeName() const { return "ArchivePrimitive"; }

    /* Bounding box for the cached guide. */
    virtual SgBox3d guideBoundingBox( unsigned int index ) const;

    /** Minimum number of CVs allowed for a guide of this primitive. */
    virtual unsigned int minGuideCVCount() const { return 4; }
    
    /* Default shape for a new guide. */
    virtual void defaultGuideGeom( XgGuide &guide );
    
    /* Verify the vertices meet the constraints of the archive primitive. */
    virtual void verifyGuideGeom( safevector<SgVec3d> &cpts );

    /* Scaling factor to transform archives into a unit cube */
    double archiveSize() const { return _archiveSize; }

    /* Animation Frame for the archive*/
    double archiveFrame() const { return context()->archiveFrame(); }

    /* Transformation matrix in description space, computed from
     * the cGeom points. */
    SgXform3d transformation() const;
	
	/* Set the scaling factor to transform archives into a unit cube */
	double setArchiveSize();

	/* Get the current archive group id */
	unsigned int archiveGroupId() const
	{
		return context()->_aIndex;
	}

	/* Access the map of archive groups */
	struct ArchiveGroup
	{
		ArchiveGroup()
		: _id(0)
		{
		}
		int _id;
		std::string _name;
		std::string _materials;
		std::string _color;
	};
	const std::map<unsigned int,ArchiveGroup>& archiveGroups() const
	{
		return _archiveGroups;
	}
	
    virtual bool attrIsForcedInPreset( const std::string& attrName ) const { return attrName=="files"; }

    /** Get external file paths used in the primitive. */
    virtual void getExternalContext(XgExternalContentInfoTable& table, const std::string& prefix) const;

protected:
	bool applyPerArchiveExpression( double u, double v, std::string name, double &value );
	void applyPerArchiveCustomExpressions( double u, double v );
	void evalIndex( double u, double v, XgExpression& expr, INDEX index, const std::string& attr );

    bool applyPerArchiveExpressionInParallel( XgArchivePrimitiveContext& context, double u, double v, std::string name, double &value );
    void applyPerArchiveCustomExpressionsInParallel( XgArchivePrimitiveContext& context, double u, double v );
    void evalIndexInParallel( XgArchivePrimitiveContext& context, double u, double v, XgExpression& expr, INDEX index, const std::string& attr );
	
	struct FileDesc
	{
		FileDesc & operator = ( const FileDesc &other )
		{
			_fileName = other._fileName;
			_polymeshNames = other._polymeshNames; 
			_useArchiveBBox = other._useArchiveBBox; 
			_materialName = other._materialName;
			return *this; 
		}
		
		std::pair <std::string,std::string> _fileName; 
		safevector< std::string > _polymeshNames; 
		std::string _materialName;
		bool _useArchiveBBox; 
	};
	
	typedef safevector< FileDesc > FileDescList;
	typedef std::map< int, FileDescList > FileDescListMap;
	
    /** No definition by design to prevent accidental default construction. */
    XgArchivePrimitive();
    
    /** No definition by design so accidental copying is prevented. */
    XgArchivePrimitive( const XgArchivePrimitive &primitive );

    /** No definition by design so accidental assignment is prevented. */
    XgArchivePrimitive &operator=( const XgArchivePrimitive &primitive );

    /* Make the cached geometry for this primitive. */
    virtual void mkGeometry( double u, double v );
    virtual void mkGeometryInParallel( XgPrimitiveContext& context1, double u, double v );

    /* Helper for creating the cached geometry from attributes. */
    void mkGeometryFromAttrs( double u, double v );
    void mkGeometryFromAttrsInParallel( XgArchivePrimitiveContext& context, double u, double v );
    
    /* Helper for creating the cached geometry from guides. */
    void mkGeometryFromGuides( double u, double v );
    void mkGeometryFromGuidesInParallel( XgArchivePrimitiveContext& context, double u, double v );

    /* Archive attributes. */
    XgExpression _twist;
    XgExpression _hiIndex;
    XgExpression _medIndex;
    XgExpression _loIndex;
    XgExpression _frame;
    unsigned int _lodLo[LOD_COUNT];
    unsigned int _lodHi[LOD_COUNT];
	FileDescListMap _fileDescs;
    bool _useLevel[INDEX_COUNT];
	unsigned int _aCount;
    double _archiveSize;

    /* Proxy attributes. */
    XgExpression _proxyIndex;
    XgExpression _aIndexExpr;
    XgExpression _aLODExpr;

	struct PerArchiveExpr
	{
		~PerArchiveExpr();
		PerArchiveExpr & operator = ( const PerArchiveExpr &other )
		{
			_name = other._name;
			_archiveAttrs = other._archiveAttrs; 
			_archiveCustomAttrs = other._archiveCustomAttrs; 
			return *this; 
		}

		std::string _name; 
		XgDict<XgExpression*> _archiveAttrs;
		XgDict<XgExpression*> _archiveCustomAttrs;
	};

	typedef std::map<std::string, PerArchiveExpr> PerArchiveExprMap;
	PerArchiveExprMap _perArchiveExprMap; 

	std::map<unsigned int, ArchiveGroup> _archiveGroups;

	tbb::concurrent_unordered_set<unsigned int> _invalidIndices[INDEX_COUNT]; 
};


#endif
