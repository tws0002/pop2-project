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
# @file xgParticleFXModuleTab.py
# @brief Contains the Particle FX Module UI.
#
# <b>CONFIDENTIAL INFORMATION: This software is the confidential and
# proprietary information of Walt Disney Animation Studios ("WDAS").
# This software may not be used, disclosed, reproduced or distributed
# for any purpose without prior written authorization and license
# from WDAS. Reproduction of any section of this software must include
# this legend and all copyright notices.
# Copyright Disney Enterprises, Inc. All rights reserved.</b>
#
# @author Lawrence Chai
# @author Thomas V Thompson II
#
# @version Created 02/28/11
#

import string
from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
if xgg.Maya:
    import maya.mel as mel
from xgenm.ui.widgets import *
from xgenm.ui.fxmodules.xgFXModuleTab import *
from xgenm.ui.util.xgProgressBar import setProgressInfo


class ParticleFXModuleTabUI(FXModuleTabUI):
    def __init__(self,name):
        FXModuleTabUI.__init__(self,name,maya.stringTable[ 'y_xgParticleFXModuleTab.kParticleModifier'  ])
        # Widgets
        self.baseTopUI()

        self.particleFile = BrowseUI("particleFile",
             maya.stringTable[ 'y_xgParticleFXModuleTab.kParticleFileAnn'  ],
             self.name,"*.pda *.pdb *.bgeo","in",
             maya.stringTable[ 'y_xgParticleFXModuleTab.kParticleFile'  ])
        self.layout().addWidget(self.particleFile)

        if ( xgg.Maya ):
            self.layout().addSpacing(10)
            buttonBox = QtGui.QWidget()
            buttonLayout = QtGui.QHBoxLayout()
            buttonLayout.setAlignment(QtCore.Qt.AlignRight)
            buttonLayout.setSpacing(3)
            buttonLayout.setContentsMargins(1,1,1,1)
            buttonBox.setLayout(buttonLayout)
            self.bakeButton = QtGui.QPushButton(maya.stringTable[ 'y_xgParticleFXModuleTab.kBakeParticles'  ])
            buttonLayout.addWidget(self.bakeButton)
            self.layout().addWidget(buttonBox)
            self.connect(self.bakeButton, QtCore.SIGNAL("clicked()"),
                         self.bakeSlot)

    def bakeSlot(self):
        de = xgg.DescriptionEditor
        pal = de.currentPalette()
        desc = de.currentDescription()
        # Turn off this and trailing fx modules, but store their state
        modules = xg.fxModules(pal,desc)
        state = []
        found=False
        for m in modules:
            if m==self.name:
                found=True
            if found:
                state.append(xg.getAttr("active",pal,desc,m))
                xg.setAttr("active","False",pal,desc,m)
        # Grab current renderer type and switch to Particle
        c_rend = xg.getActive(pal,desc,"Renderer")
        xg.setActive(pal,desc,"ParticleRenderer")
        # Grab its attributes and replace them
        c_perc = xg.getAttr("percent",pal,desc,"ParticleRenderer")
        c_mask = xg.getAttr("mask",pal,desc,"ParticleRenderer")
        c_file = xg.getAttr("particleFile",pal,desc,"ParticleRenderer")
        xg.setAttr("percent","100",pal,desc,"ParticleRenderer")
        xg.setAttr("mask",self.maskExpr.value(),pal,desc,"ParticleRenderer")
        val = self.particleFile.value().replace("${FXMODULE}",self.name)
        xg.setAttr("particleFile",val,pal,desc,"ParticleRenderer")
        # Render out the particles
        setProgressInfo(maya.stringTable['y_xgParticleFXModuleTab.kParticleFXRenderingProgress' ])
        cmd = 'xgmParticleRender -pb {"'+desc+'"}'
        mel.eval(cmd)
        # Restore everything
        xg.setAttr("percent",c_perc,pal,desc,"ParticleRenderer")
        xg.setAttr("mask",c_mask,pal,desc,"ParticleRenderer")
        xg.setAttr("particleFile",c_file,pal,desc,"ParticleRenderer")
        xg.setActive(pal,desc,c_rend)
        found=False
        i=0
        for m in modules:
            if m==self.name:
                found=True
            if found:
                xg.setAttr("active",state[i],pal,desc,m)
                i+=1
        
        
    def refresh(self):
        FXModuleTabUI.refresh(self)
        self.particleFile.refresh()
