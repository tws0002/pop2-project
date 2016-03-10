# Copyright (C) 1997-2013 Autodesk, Inc., and/or its licensors.
# All rights reserved.
#
# The coded instructions, statements, computer programs, and/or related
# material (collectively the "Data") in these files contain unpublished
# information proprietary to Autodesk, Inc. ("Autodesk") and/or its licensors,
# which is protected by U.S. and Canadian federal copyright law and by
# international treaties.
#
# The Data is provided for use exclusively by You. You have the right to use,
# modify, and incorporate this Data into other products for purposes authorized 
# by the Autodesk software license agreement, without fee.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND. AUTODESK
# DOES NOT MAKE AND HEREBY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTIES
# INCLUDING, BUT NOT LIMITED TO, THE WARRANTIES OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, OR ARISING FROM A COURSE 
# OF DEALING, USAGE, OR TRADE PRACTICE. IN NO EVENT WILL AUTODESK AND/OR ITS
# LICENSORS BE LIABLE FOR ANY LOST REVENUES, DATA, OR PROFITS, OR SPECIAL,
# DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES, EVEN IF AUTODESK AND/OR ITS
# LICENSORS HAS BEEN ADVISED OF THE POSSIBILITY OR PROBABILITY OF SUCH DAMAGES.
import maya
maya.utils.loadStringResourcesForModule(__name__)


##
# @file xgmCaps2GuidesTool.mel
# @brief Contains code to wrap the poly2guide process when using points
#
# <b>CONFIDENTIAL INFORMATION: This software is the confidential and
# proprietary information of Walt Disney Animation Studios ("WDAS").
# This software may not be used, disclosed, reproduced or distributed
# for any purpose without prior written authorization and license
# from WDAS. Reproduction of any section of this software must include
# this legend and all copyright notices.
# Copyright Disney Enterprises, Inc. All rights reserved.</b>
#
# @author Yun-chen Sung
# @author Thomas V Thompson II
#
# @version Created 11/19/10
#

import xgenm as xg
import xgenm.ui as xgui
import xgenm.xgGlobal as xgg
import maya.mel as mel
import maya.cmds as cmds
import string
import os
import tempfile

# Substitute a string.  Return a string
def subst(str, dict):
    template = string.Template(str)
    return template.substitute(dict)

# Python callback for a description change
def descChangedCB( desc ):
    # Call the mell callback that updates the ui
    mel.eval('xgmCaps2GuidesToolDescChangedCB()')

# Procedure to generate guides from a set of polymesh caps
def caps2guides (density, xuv):

    melDir =  str(tempfile.gettempdir()) 
    errTitle = maya.stringTable['y_xgmCaps2GuidesTool.kCaps2GuidesErrTitle' ]
    # either xuv or density must be set
    if not xuv and density==0.0:
        errText = maya.stringTable['y_xgmCaps2GuidesTool.kCaps2GuidesErrSpecifyDensity' ]
        cmd = 'confirmDialog -title "%s" -m "%s" -messageAlign "left" -button "Ok"' % (errTitle, errText)
        mel.eval(cmd)
        return

    # need editor open to get and set various values
    if xgg.DescriptionEditor == None:
        errText = maya.stringTable['y_xgmCaps2GuidesTool.kCaps2GuidesErrNeedDescEditorOpen' ]
        cmd = 'confirmDialog -title "%s" -m "%s" -messageAlign "left" -button "Ok"' % (errTitle, errText)
        mel.eval(cmd)
        return

    desc = xgui.currentDescription()
    palette = xgui.currentPalette()

    # delete all the guides in the current description
    for g in xg.descriptionGuides(desc):
        cmds.delete(g)

    # create a temp description to work in that is a copy of the original
    cmd = 'xgmCopyDescription -deo false -n C2GT_work_123 -p "'+palette+\
        '" "'+desc+'"'
    tempDesc = mel.eval(cmd)
    if not tempDesc:
        errText = maya.stringTable['y_xgmCaps2GuidesTool.kCaps2GuidesErrCreateWorkingAreaFailed' ]
        cmd = 'confirmDialog -title "%s" -m "%s" -messageAlign "left" -button "Ok"' % (errTitle, errText)
        mel.eval(cmd)
        return
    tempDesc = str(tempDesc[0])

    print maya.stringTable['y_xgmCaps2GuidesTool.kXgmCaps2GuidesToolCreateWorkingArea' ],tempDesc
    curveGroup = tempDesc + "Dump"

    # delete all the current guides in the temp description
    xgg.DescriptionEditor.setCurrentDescription(tempDesc)
    for g in xg.descriptionGuides(tempDesc):
        cmds.delete(g)

    # deactivate all of the fx modules
    modules = xg.fxModules(palette,tempDesc)
    for module in modules:
        xg.setAttr("active","false",palette,tempDesc,module);

    # substitute the base description for ${DESC} in the temp desc
    objects = xg.objects(palette,tempDesc)
    for obj in objects:
        attrs = xg.allAttrs(palette,tempDesc,obj)
        for attr in attrs:
            val = xg.getAttr(attr,palette,tempDesc,obj)
            newval = val.replace("${DESC}",desc)
            xg.setAttr(attr,newval,palette,tempDesc,obj)            

    print maya.stringTable['y_xgmCaps2GuidesTool.kXgmCaps2GuidesToolCreateFirstPass' ]
    if not mel.eval('xgmC2GTGeneratesGuidesAndMaps'):
        cmds.delete(tempDesc)
        return

    # prepare our temp description to render.
    xg.setAttr("length","1.0",palette,tempDesc,"SplinePrimitive")
    if density > 0.0:
        # use the random generator to create the curves of provided density
        # and note we will be using the original description mask as well
        xg.setActive(palette, tempDesc, 'RandomGenerator')
        xg.setAttr("density",str(density),palette,tempDesc,"RandomGenerator")
        if xuv:
            xg.setAttr("usePoints","true",palette,tempDesc,"RandomGenerator")
            xg.setAttr("inputDir",xuv,palette,tempDesc,"RandomGenerator")
        else:
            xg.setAttr("usePoints","false",palette,tempDesc,"RandomGenerator")
    else:
        # a density of zero means we should use the point generator
        xg.setActive(palette, tempDesc, 'PointGenerator')
        xg.setAttr("inputDir", xuv, palette, tempDesc, "PointGenerator")

    # render temp description
    xg.setActive(palette, tempDesc, "MelRenderer")
    xg.setAttr("outputDir", melDir, palette, tempDesc, "MelRenderer")
    print maya.stringTable['y_xgmCaps2GuidesTool.kXgmCaps2GuidesToolInitAndRender' ]
    xg.initInterpolation(palette, tempDesc)
    mel.eval('xgmMelRender {"%s"}' % tempDesc)

    # source mel
    if cmds.objExists(curveGroup):
        cmds.delete(curveGroup)

    mel.eval('source "%s/%s.mel"' % (melDir, tempDesc))

    print "sourced %s/%s.mel"% (melDir, tempDesc)

    # Copy region mask from tempDesc to desc
    tempMask = xg.getAttr("regionMask", palette, tempDesc, "SplinePrimitive")
    xg.setAttr("regionMask", tempMask, palette, desc, "SplinePrimitive")

    # Copy region map from tempDesc to desc
    tempDescDir = xg.getAttr("regionMap", palette, tempDesc, "SplinePrimitive")
    xg.setAttr("regionMap", tempDescDir, palette, desc, "SplinePrimitive")
    descDir = tempDescDir.replace("${DESC}",desc)
    tempDescDir = tempDescDir.replace("${DESC}",tempDesc)

    try:
        cmd = ("cp xgen/%s/*.ptx xgen/%s" % (tempDescDir, descDir))
        print "os.system:", cmd
        os.system(cmd)
    except:
        pass

    # run curve-to-guides
    for g in xg.descriptionGuides(desc):
        cmds.delete(g)
    print "select(%s|*)" % curveGroup
    cmds.select(curveGroup+"|*")

    cmd = ('xgmCurveToGuide -d %s' % desc)
    print "calling (%s)" % cmd

    mel.eval(cmd)
    xg.initInterpolation(palette, desc)
    
    xgg.DescriptionEditor.setCurrentDescription(desc)

    # cleanup
    cmds.delete(tempDesc)
    cmds.delete(curveGroup)

    # report results
    guides = xg.descriptionGuides(desc)

    confirmTitle = maya.stringTable['y_xgmCaps2GuidesTool.kCapsToGuidesComplete' ]
    confirmText = maya.stringTable['y_xgmCaps2GuidesTool.kCapsToGuidesFinishCreating' ] % len(guides)
    cmd = 'confirmDialog -title "%s" -m "%s" -messageAlign "left" -button "Ok"' % (confirmTitle, confirmText)
    mel.eval(cmd)
