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

# UI definitions for the sample xgen modules.
#
# A module named X needs to have a UI definition named XTabUI.
#
# That UI definition has to be in a .py file in the ~/xgen/plugins/ directory,
# alongside the shared object(s) that define the modules.  We don't care which
# .py file.
#
# The UI for a module must be a PySide QtGui.QWidget subclass.  We strongly
# recommend using the GeneratorTabUI, FXModuleTabUI, and so on as your base
# classes rather than rolling your own of everything.  If you have no
# attributes, use the GeneratorTabBlankUI convenience function to define your
# UI class.
#

import xgenm as xgen
import maya
from PySide import QtGui, QtCore

# The cross generator randomy places primitives on an X pattern: u=v and u=1-v.
class CrossGeneratorTabUI(xgen.ui.tabs.GeneratorTabUI):
    def __init__(self):
        xgen.ui.tabs.GeneratorTabUI.__init__(self,'Cross')

        # Always start generator UIs with the top UI
        self.baseTopUI()

        self.density = xgen.ui.widgets.FloatUI("density",
             "Density of emission.", "CrossGenerator")
        self.layout().addWidget(self.density)

        # Always end with the bottom UI
        self.baseBottomUI()

    def refresh(self):
        xgen.ui.tabs.GeneratorTabUI.refresh(self)
        self.density.refresh()


# The gravity FX module is a poor approximation of the effect of gravity on
# splines.
class GravityFXModuleTabUI(xgen.ui.fxmodules.FXModuleTabUI):
    def __init__(self,name):
        xgen.ui.fxmodules.FXModuleTabUI.__init__(self,name)

        # Always start fxmodule UIs with the top UI.
        # There's no corresponding bottom UI.
        self.baseTopUI()

        self.gravity = xgen.ui.widgets.ExpressionUI("gravity",
            "Strength of gravity.  Strength 1 will flatten an upward spline " +
            "and double the length of a downward spline.",
            self.name)
        self.layout().addWidget(self.gravity)

        self.downVector = xgen.ui.widgets.ExpressionUI("down",
            "Direction of gravity, normally [0,-1,0].",
            self.name)
        self.layout().addWidget(self.downVector)

    def refresh(self):
        xgen.ui.fxmodules.FXModuleTabUI.refresh(self)
        self.gravity.refresh()
        self.downVector.refresh()


# The OFF renderer outputs meshes to OFF format, which can be read by geomview
# (yum install geomview).  Each description goes into its own file.
class OFFRendererTabUI(xgen.ui.tabs.RendererTabUI):
    def __init__(self):
        xgen.ui.tabs.RendererTabUI.__init__(self,'OFF')
        # Widgets
        self.baseTopUI()
        self.outputDir = xgen.ui.widgets.BrowseUI("outputDir",
             "Directory for output ${DESC}.off file.",
             "OFFRenderer","","out")
        self.layout().addWidget(self.outputDir)

        self.layout().addSpacing(10)
        row = QtGui.QWidget()
        hbox = QtGui.QHBoxLayout()
        hbox.setAlignment(QtCore.Qt.AlignLeft)
        hbox.setSpacing(3)
        hbox.setContentsMargins(0,0,0,0)
        hbox.addSpacing(xgen.ui.util.xgUtil.labelWidth()+3)
        self.goButton = QtGui.QPushButton('Export to files')
        self.goButton.setFixedWidth(145)
        self.goButton.setAutoRepeat(False)
        self.goButton.setToolTip("Export each description into an OFF file.")
        hbox.addWidget(self.goButton)
        row.setLayout(hbox)
        self.layout().addWidget(row)
        self.goButton.clicked.connect(self.outputToOFF)

    def outputToOFF(self):
        de = xgen.xgGlobal.DescriptionEditor
        progress = xgen.ui.util.xgProgressBar
        progress.setProgressInfo("Exporting primitives...")
        quoted = []
        for pal in xgen.palettes():
            quoted += [ '"' + desc + '"' for desc in xgen.descriptions(pal) ]
        cmd = 'xgmExport -x OFFRenderer -pb ' + (" ".join(quoted))
        maya.mel.eval(cmd)

    def refresh(self):
        xgen.ui.tabs.RendererTabUI.refresh(self)
        self.outputDir.refresh()
