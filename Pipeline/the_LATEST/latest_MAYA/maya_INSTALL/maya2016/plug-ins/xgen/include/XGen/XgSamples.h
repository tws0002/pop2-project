// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file XgSamples.h
 * @brief Contains a collection of random sample points.
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
 * @version Created 05/24/02
 */

#ifndef XGSAMPLES_H
#define XGSAMPLES_H

#include "XgWinExport.h"


/* Function to get random coordinates. */
extern XGEN_EXPORT void
getSample( unsigned int count, unsigned int id,
           unsigned int group, double &u, double &v );


#endif
