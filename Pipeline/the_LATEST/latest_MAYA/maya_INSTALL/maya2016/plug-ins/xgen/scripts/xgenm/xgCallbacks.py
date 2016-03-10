##
# @file xgCallbacks.py
# @brief Contains functions for getting callbacks for XGen events.
#
# <b>CONFIDENTIAL INFORMATION: This software is the confidential and
# proprietary information of Walt Disney Animation Studios ("WDAS").
# This software may not be used, disclosed, reproduced or distributed
# for any purpose without prior written authorization and license
# from WDAS. Reproduction of any section of this software must include
# this legend and all copyright notices.
# Copyright Disney Enterprises, Inc. All rights reserved.</b>
#
# @author Thomas V Thompson II
#
# @version Created 06/26/09
#

import string
import xgGlobal as xgg


def registerCallback( name, function ):
    """Register a function to be called if the named XGen event occurs.
    """
    index = -1
    try:
        index = xgg.CallbackIndex[name]
    except:
        print "Invalid callback event name given:",name
        return
    if function=="":
        print "No function name given to registerCallback."
        return
    func = ':'+str(function)+':'
    if xgg.CallbackEvents[index] == ':':
        xgg.CallbackEvents[index] = func
    else:
        if xgg.CallbackEvents[index].count(func) == 0:
            xgg.CallbackEvents[index] += func

    
def deregisterCallback( name, function ):
    """Deregister a function from being called if the named XGen event occurs.
    """
    index = -1
    try:
        index = xgg.CallbackIndex[name]
    except:
        print "Invalid callback event name given:",name
        return
    func = ':'+str(function)+':'
    if func == '::':
        xgg.CallbackEvents[index] = ':'
    else:
        xgg.CallbackEvents[index] = xgg.CallbackEvents[index].replace(func,'')
        if xgg.CallbackEvents[index] == '':
            xgg.CallbackEvents[index] = ':'


def getFuncFromName(funcName):
    """Given a string representing a function name, attempt to import it
    and return the function symbol.
    """
    try:
        # Import the module (this might have submodules)
        funcModuleName = string.join(funcName.split('.')[:-1],'.')
        funcModule = __import__(funcModuleName)
        func = funcModule
        # We've got the main module, now dive through the submodules
        # and get the final function
        for subItem in funcName.split('.')[1:]:
            func = getattr(func, subItem)
    except:
        print "ERROR: Failed to find module and function %s" % funcName
        return None
    return func

    
def invokeCallbacks( name, args ):
    """Invoke the registered functions for the named event. The args list
    will be passed to the callback and contains the names of one or more
    objects depending on the callback. It will be coverted to a comma
    separated string.
    """
    index = -1
    try:
        index = xgg.CallbackIndex[name]
    except:
        print "Invalid callback event name given:",name
        return
    argStr = ''
    for i in range(len(args)):
        if i>0:
            argStr += ','
        argStr += args[i]
    # Invoke each callback one at a time
    callbacks = xgg.CallbackEvents[index].split(':')
    for function in callbacks:
        if function == '':
            continue
        funcPtr = getFuncFromName(function)
        if funcPtr==None:
            # Failed to find this callback function so remove from list
            deregisterCallback( name, function )
        else:
            funcPtr(argStr)
