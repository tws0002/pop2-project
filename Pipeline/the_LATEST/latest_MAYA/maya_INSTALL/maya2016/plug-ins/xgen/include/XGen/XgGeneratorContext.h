#ifndef XGGENERATORCONTEXT_H
#define XGGENERATORCONTEXT_H

class XGEN_EXPORT XgGeneratorContext
{
    friend class XgGenerator;
    friend class XgFileGenerator;

public:
    XgGeneratorContext() : _lodWidth(0.0) {}
    virtual ~XgGeneratorContext() {}

private:
    double _lodWidth;
};

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
