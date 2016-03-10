// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file SgRampUIComp.h
 * @brief Contains the declaration of the class SgRampUIComp.
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
 * @author Lawrence Chai
 *
 * @version Created 05/14/10
 */

#ifndef SGRAMPUICOMP_H
#define SGRAMPUICOMP_H

#include <map>
#include <string>

#include "XgPorting/safevector.h"


/**
 * Class for evaluating rampUI curves
 */
class SgRampUIComp
{
public:
    SgRampUIComp() {}
    virtual ~SgRampUIComp() {}

    enum InterpType { kNone, kLinear, kSmooth, kSpline, kUnknown };

    bool init(const std::string &params);

    float getValue(const float param) const;

    void sample(safevector<double> &scale, const int numCVs);

    /**  Default values for rampUI parameters. */
    static const char *RampUIDefault;

private:
    typedef std::map<float, std::pair<float, int> > cvDataMap;
    cvDataMap _cvData;
};

#endif

