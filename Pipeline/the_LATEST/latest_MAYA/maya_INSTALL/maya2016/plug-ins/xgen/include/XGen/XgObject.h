// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgObject.h
 * @brief Contains the declaration of the base class for XGen objects.
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
 * @author Ying Liu
 * @author Lawrence Chai
 *
 * @version Created 10/11/04
 */

#ifndef XGOBJECT_H
#define XGOBJECT_H

#include <iostream>
#include <string>
#include "XgPorting/safevector.h"
#include <set>
#include <list>

#include "XGen/XgDict.h"
#include "XGen/XgUtil.h"
#include "XgWinExport.h"

class XgExpression;
class XgDescription;

typedef safevector<std::pair<std::string, std::string> > XgExternalContentInfoTable;

/**
 * @brief A base object for all XGen object types.
 *
 * This class is the base class for all XGen objects. Those being the
 * primitives, generators, and renderers (including previewers). It
 * provides common methods used for interfacing with these objects.
 */
class XGEN_EXPORT XgObject
{
public:

    /* Constructor. */
    XgObject( XgDescription *descr );

    /* Destructor. */
    virtual ~XgObject();

    virtual const std::string &name() const { return _name; }
    
    /** @name Custom attributes. */
    //@{
    virtual bool setAttr( const std::string &name, 
                          const std::string &value, 
                          const std::string &type="float",
			  const std::string &uiHint="" );
	bool setTexture( const std::string &name, const std::string &texture );
	bool getTexture( const std::string &name, std::string &texture );
    bool getAttr( const std::string &name, std::string &value ) const;
    bool getAttr( const std::string &name, 
                  std::string &value, 
                  std::string &type ) const;
    bool hasAttr( const std::string &name ) const;
    std::list<std::string> getEnumStrings( const std::string &name ) const;
    bool remAttr( const std::string &name );
    bool remAttrs( std::set<std::string> &names );
    const std::string &attr( unsigned int index ) const;
    unsigned int numAttrs() const { return (unsigned int)_attrNames.size(); }
    bool enabledCustomAttr( const std::string &attrName ) const;
    //@}

    /** @name Attribute validation. */
    //@{
    bool boolAttr( const std::string &name,
                   const std::string &value,
                   bool &result );
    bool floatAttr( const std::string &name,
                    const std::string &value,
                    double &result );
    bool intAttr( const std::string &name,
                  const std::string &value,
                  int &result );
    bool uintAttr( const std::string &name,
                   const std::string &value,
                   unsigned int &result );
    //@}
    
    /** Access to this objects description. */
    XgDescription *description() { return _description; }
    
    /** Return the name of this type of object. */
    virtual std::string typeName() const = 0;

    /** @name IO functions. */
    //@{
    bool exportObj( std::ostream &os ) const;
    bool importObj( std::istream &is, const std::string& ns="" );

    virtual bool exportObjAsPreset( std::ostream &os ) const;

    /** Return if the given attribute is forced to be included in exporting the object as preset*/
    virtual bool attrIsForcedInPreset( const std::string& attrName ) const { return false; }

    void getTexMap( safevector<std::string> &textures ) const;
    void setTexMap( const std::string& attr, const std::string& texFile );

    virtual bool exportExtraAttr(std::ostream &os ) const;
    virtual bool isExtraAttr(const std::string& attr) const;
    //@}
    
protected:

    /** No definition by design to prevent accidental default construction. */
    XgObject();
    
    /** No definition by design so accidental copying is prevented. */
    XgObject( const XgObject &object );

    /** No definition by design so accidental assignment is prevented. */
    XgObject &operator=( const XgObject &object );

    /* Set the name of the object. Only caller should be setAttr. */
    virtual void setName( const std::string &name )
        { _name = xgutil::sgObjName(name); }

    /* Remove the named attribute from the customAttrs map. */
    bool removeCustomAttr( const std::string &name );

    /** Name of the object. */
    std::string _name;

    /** Description back pointer. */
    XgDescription *_description;

    /**
     * Attributes. All subclass data should be stored in this map
     * as name/value (as string) pairs. This will allow the data to
     * be imported/exported without any subclass work, as well as have
     * everything synced up automatically with wrapper classes.
     */

    class XgAttrData {
    public:
	XgAttrData() {};
	XgAttrData(const std::string &value, const std::string &type="",
		   const std::string &uiHint="") : _value(value),
						   _type(type),
						   _uiHint(uiHint),
						   _isMap(false),
						   _textures(""){}
	~XgAttrData() {};

	inline std::string getValue() const { return _value; }
	inline void setValue(const std::string &value) { _value = value; _isMap = false; }
	inline void setTexture(const std::string &texture) { _textures = texture; _isMap = true; }
	inline std::string getTexture() const { if (_isMap) return _textures; else return ""; }
	inline std::string getType() const { return _type; }
	inline bool isMap() const { return _isMap; }
	inline void setType(const std::string &type) { _type = type; }
	inline std::string getUIHint() const { return _uiHint; }
	inline void setUIHint(const std::string &uiHint) { _uiHint = uiHint; }

    private:
	std::string _value;
	std::string _type;
	std::string _uiHint;
	bool        _isMap;
	std::string _textures;
    };

    XgDict<XgAttrData> _attrData;
    safevector<std::string> _attrNames;
    XgDict<XgExpression*> _customAttrs;
};


#endif
