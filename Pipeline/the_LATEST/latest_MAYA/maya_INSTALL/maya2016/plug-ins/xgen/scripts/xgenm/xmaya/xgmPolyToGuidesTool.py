##
# @file xgmPolyToGuidesTool.py
# @brief Contains the python wrapper for mel callback function.
#
# <b>CONFIDENTIAL INFORMATION: This software is the confidential and
# proprietary information of Walt Disney Animation Studios ("WDAS").
# This software may not be used, disclosed, reproduced or distributed
# for any purpose without prior written authorization and license
# from WDAS. Reproduction of any section of this software must include
# this legend and all copyright notices.
# Copyright Disney Enterprises, Inc. All rights reserved.</b>
#
# @author Ying Liu
#
# @version Created 07/27/09
#

import maya.mel as mel

def xgmPolyToGuideToolDescChangedCB( desc ):
    mel.eval('xgmPolyToGuideToolDescChangedCB()')
