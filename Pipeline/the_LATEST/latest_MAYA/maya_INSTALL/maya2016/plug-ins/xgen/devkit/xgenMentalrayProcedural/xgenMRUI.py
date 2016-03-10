# This command should be called before doing a mentalray render.
# It creates the necessary geoshader shadow objects under the xgmr namespace.

import sys
import os.path
import maya.api.OpenMaya as om
import maya.OpenMayaAnim as oma
import maya.cmds as cmds
import maya.mel as mel
from xgenm import XgExternalAPI as xgapi
import xgenm as xg
from xgenm.ui.widgets import *
from xgenm.ui.util.xgUtil import *
from xgenm.ui.tabs.xgRendererTab import *
from xgenm.ui.util.xgProgressBar import setProgressInfo
from xgenm.ui.util.xgComboBox import _ComboBoxUI
import ctypes
import types

k_RenderAPIRenderer = "Renderman"
k_RenderAPIRendererObj = k_RenderAPIRenderer + "Renderer"

def castSelf(selfid):
    # Can't pass self as an object.
    # It's cast to id(self) by the caller
    # and we convert it back to a python object here
    if isinstance(selfid,str):
        return ctypes.cast( int(selfid), ctypes.py_object ).value
    else:
        return selfid

def addMethod( self, method ):
    self.__dict__[method.__name__] = types.MethodType( method, self, xg.ui.tabs.RendermanRendererTabUI )
#
# RenderAPI RendererTab UI callbacks

# RenderAPIRendererTabUIInit callback
# Called at the end of RenderAPIRendererTab.__init__()
def xgmrUI(selfid):
    self = castSelf(selfid)

    # Extend the RenderAPIRendererTab instance with some of our methods
    addMethod( self, xgmrRefresh )
    addMethod( self, xgmrSplineDegreeChanged )
    addMethod( self, xgmrRenderModeChanged )
    addMethod( self, xgmrApproxTypeChanged )
    addMethod( self, xgmrAutoGeoshadersChanged )

    expand = ExpandUI(_L10N( kMentalRaySettings, "mental ray Settings" ))
    self.mr_expand_settings = expand
    self.layout().addWidget( expand )

    # Horizontal layout
    row = QtGui.QWidget()
    hbox = QtGui.QHBoxLayout()
    hbox.setSpacing(3)
    hbox.setContentsMargins(1,1,1,1)
    label = QtGui.QLabel(_L10N( kMentalrayGeoshaders, "Setup GeoShaders" ))
    label.setFixedWidth(labelWidth())
    label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
    label.setIndent(10)
    label.setToolTip(_L10N( kMentalrayGeoshadersAnn, "Setup a mental ray geometry shader used to generate the XGen render time geometry.\nBy default, the setup is automatically done when a new description is created.\nYou can perform the setup manually for the current Description by clicking the Setup button." ))
    hbox.addWidget(label)
    self.mr_autocreateGeoshaders = _ComboBoxUI()
    self.mr_autocreateGeoshaders.setFixedWidth(120)
    self.mr_autocreateGeoshaders.addItem(_L10N( kMentalrayGeoshadersAuto, 'Automatically' ) )
    self.mr_autocreateGeoshaders.addItem(_L10N( kMentalrayGeoshadersManual, 'Manually' ) )
    self.mr_autocreateGeoshaders.setToolTip( label.toolTip() )
    self.connect(self.mr_autocreateGeoshaders, QtCore.SIGNAL("activated(int)"), self.xgmrAutoGeoshadersChanged )
    hbox.addWidget(self.mr_autocreateGeoshaders)

    self.mr_setup_geoshaders = QtGui.QPushButton()
    self.mr_setup_geoshaders.setText(_L10N( kSetupGeometryShaders, 'Setup' ))
    self.mr_setup_geoshaders.setFixedWidth(80)
    self.mr_setup_geoshaders.setToolTip( label.toolTip() )
    self.connect(self.mr_setup_geoshaders, QtCore.SIGNAL("clicked()"),
                 lambda: mel.eval("xgmr -setupGeometryShader -description \"%s\" -palette \"%s\"" % (xgg.DescriptionEditor.currentDescription(), xgg.DescriptionEditor.currentPalette() )))
    hbox.addWidget(self.mr_setup_geoshaders)

    hbox.addStretch()
    row.setLayout(hbox)
    expand.addWidget(row)

    # Horizontal layout
    row = QtGui.QWidget()
    hbox = QtGui.QHBoxLayout()
    hbox.setSpacing(3)
    hbox.setContentsMargins(1,1,1,1)
    label = QtGui.QLabel(_L10N( kMentalRayRenderMode, "Render Mode" ))
    label.setFixedWidth(labelWidth())
    label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
    label.setIndent(10)
    label.setToolTip(_L10N( kMentalRayRenderModeAnn, "'Live' allows XGen to query patches and guide animation directly from Maya.\nThis mode doesn't support Motion Blur and will try to reuse information the preview generated.\n\n'Batch Render' mode will always read geometry and animation from files.\n'Batch Render' mode is always on when doing a Batch Render.\nYou must first export the patches and guide animation to caches.\nUse this mode to make sure your caches are properly exported before doing a Batch Render." ))
    hbox.addWidget(label)
    self.mr_rendermode = _ComboBoxUI()
    self.mr_rendermode.setFixedWidth( 120 )
    self.mr_rendermode.addItem(_L10N( kRenderModeLive, 'Live' ), "1" )
    self.mr_rendermode.addItem(_L10N( kRenderModeBatch, 'Batch Render' ), "3" )
    self.mr_rendermode.setToolTip(label.toolTip())
    self.connect(self.mr_rendermode , QtCore.SIGNAL("activated(int)"), self.xgmrRenderModeChanged )
    hbox.addWidget(self.mr_rendermode)
    filler = QtGui.QWidget()
    hbox.addWidget(filler)
    row.setLayout(hbox)
    expand.addWidget(row)

    # Horizontal layout
    row = QtGui.QWidget()
    hbox = QtGui.QHBoxLayout()
    hbox.setSpacing(3)
    hbox.setContentsMargins(1,1,1,1)
    label = QtGui.QLabel(_L10N( kTools, "Tools" ))
    label.setFixedWidth(labelWidth())
    label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
    label.setIndent(10)
    hbox.addWidget(label)
    
    self.mr_apply_hair_shader = QtGui.QPushButton()
    self.mr_apply_hair_shader.setText(_L10N( kMentalRayApplyHair, 'Apply Hair Shader' ))
    self.mr_apply_hair_shader.setToolTip(_L10N( kMentalRayApplyHairAnn, "Apply default mental ray XGen Hair Shader to the current Description.\nThe shader reacts to 'root_color', 'tip_color' and 'back_color' XGen custom shader parameters." ))
    self.connect(self.mr_apply_hair_shader, QtCore.SIGNAL("activated(int)"),
                 lambda: mel.eval("xgmr -applyShader \"hair\" -description \"%s\" -palette \"%s\"" % (xgg.DescriptionEditor.currentDescription(), xgg.DescriptionEditor.currentPalette )))
    hbox.addWidget(self.mr_apply_hair_shader)

    filler = QtGui.QWidget()
    hbox.addWidget(filler)
    row.setLayout(hbox)
    expand.addWidget(row)

    filler = QtGui.QWidget()
    hbox.addWidget(filler)
    row.setLayout(hbox)
    expand.addWidget(row)

    expand = ExpandUI(_L10N( kMentalRayApproxSetttings, "mental ray Approximation Settings" ))
    self.layout().addWidget( expand )
    self.mr_expand_approx_settings = expand

    # Horizontal layout
    row = QtGui.QWidget()
    hbox = QtGui.QHBoxLayout()
    hbox.setSpacing(3)
    hbox.setContentsMargins(1,1,1,1)
    label = QtGui.QLabel(_L10N( kSplineDegree, "Degree" ))
    label.setFixedWidth(labelWidth())
    label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
    label.setIndent(10)
    label.setToolTip(_L10N( kSplineDegreeAnn, "Spline Primitives can be rendered as linear segments or as cubic Bezier curves.\nSet to Cubic for Card Primitives.\nHas no effect on Archives and Sphere Primitives." ))
    hbox.addWidget(label)
    self.mr_splinedegree = _ComboBoxUI()
    self.mr_splinedegree.addItem(_L10N( kSplineDegreeLinear, 'Linear' ), "1" )
    self.mr_splinedegree.addItem(_L10N( kSplineDegreeCubic, 'Cubic' ), "3" )
    self.mr_splinedegree.setToolTip(label.toolTip())
    self.connect(self.mr_splinedegree, QtCore.SIGNAL("activated(int)"), self.xgmrSplineDegreeChanged )
    hbox.addWidget(self.mr_splinedegree)
    filler = QtGui.QWidget()
    hbox.addWidget(filler)
    row.setLayout(hbox)
    expand.addWidget(row)

    # Horizontal layout
    row = QtGui.QWidget()
    hbox = QtGui.QHBoxLayout()
    hbox.setSpacing(3)
    hbox.setContentsMargins(1,1,1,1)
    label = QtGui.QLabel(_L10N( kApproximationMethod, "Type" ))
    label.setFixedWidth(labelWidth())
    label.setAlignment(QtCore.Qt.AlignRight|QtCore.Qt.AlignVCenter)
    label.setIndent(10)
    label.setToolTip(_L10N( kApproximationMethodAnn, "Type of mental ray approximation to use when subdividing render time hair bezier curves or card NURBS patches.\n'No Approximation' won't subdivide the render time geometry.\n'Parametric Approximation' subdivides render time geometry a number of times between control points.\n'Fine Approximation' subdivides until edges hit a given length in pixel size. It's view dependent." ))
    hbox.addWidget(label)
    self.mr_approx_type = _ComboBoxUI()
    self.mr_approx_type.addItem(_L10N( kApproxNo, 'No Approximation' ), "0")
    self.mr_approx_type.addItem(_L10N( kApproxParametric, 'Parametric Approximation' ), "1")
    self.mr_approx_type.addItem(_L10N( kApproxFine, 'Fine Approximation' ), "2")
    self.mr_approx_type.setToolTip(label.toolTip())
    self.connect(self.mr_approx_type, QtCore.SIGNAL("activated(int)"), self.xgmrApproxTypeChanged )
    hbox.addWidget(self.mr_approx_type)
    filler = QtGui.QWidget()
    hbox.addWidget(filler)
    row.setLayout(hbox)
    expand.addWidget(row)
    self.mr_approx_type_row = row

    self.mr_approx_parametric = IntegerUI( "custom__mr_approx_parametric",
                                _L10N( kParametricSubdivisionsAnn, "For Linear, defines the number of segments to use between control points.\nFor Cubic, defines a recursive number of subdivisions between control points." ),
                                k_RenderAPIRendererObj,0,99,_L10N( kParametricSubdivisions, "Subdivisions" ), autoPlayblast=False)
    expand.addWidget(self.mr_approx_parametric)
    self.mr_approx_parametric.xgAttrChanged.connect( self.xgmrRefresh )

    self.mr_approx_fine = FloatUI( "custom__mr_approx_fine",
                                _L10N( kSubPixelSizeAnn, "Subdivides geometry until edges hit a maximal length in pixel size.\nIt is view and resolution dependent.\nValues below 1.0 will split the geometry within the same pixel.\nThis is useful to render very thin hair with tube normals and a high number of samples.\nValues above 1.0 will produce geometry that does not look perfectly smooth.\nThis is useful to optimize render time if the geometry is far away from the camera." ),
                                k_RenderAPIRendererObj, 0.0, 1000.0 , 0.0, 1.0, _L10N( kSubPixelSize, "Sub Pixel Size" ), autoPlayblast=False)
    expand.addWidget(self.mr_approx_fine)
    self.mr_approx_fine.xgAttrChanged.connect( self.xgmrRefresh )

    # Register the mental ray renderer in the method combo box
    self.addRenderer("mental ray")

# RenderAPIRendererTabUIRefresh callback
# Called at the end of RenderAPIRendererTab.refresh()
def xgmrRefresh(selfid):

    self = castSelf(selfid)

    vis = self.renderer.currentText()=="mental ray"
    self.mr_expand_settings.setVisible(vis)
    self.mr_expand_approx_settings.setVisible(vis)

    # Declare the mental ray custom parameters
    self.declareCustomAttr( 'mr_rendermode', "0" )
    self.declareCustomAttr( 'mr_splinedegree', "1" )
    self.declareCustomAttr( 'mr_approx_type', "1" )
    self.declareCustomAttr( 'mr_approx_fine', "0.1" )
    self.declareCustomAttr( 'mr_approx_parametric', "3" )
    
    # Get all the values
    rendermode = int(self.getCustomAttr( "mr_rendermode" ))
    deg = int(self.getCustomAttr( "mr_splinedegree" ))
    typ = int(self.getCustomAttr( "mr_approx_type" ))
    fine = float(self.getCustomAttr( "mr_approx_fine" ))
    subdi = int(self.getCustomAttr( "mr_approx_parametric" ))

    # Update the UI
    de = xgg.DescriptionEditor

    if de.autoCreateMR:
        self.mr_autocreateGeoshaders.setCurrentIndex( 0 )
    else:
        self.mr_autocreateGeoshaders.setCurrentIndex( 1 )

    if deg==3:
        self.mr_splinedegree.setCurrentIndex( 1 )
    else:
        self.mr_splinedegree.setCurrentIndex( 0 )

    self.mr_rendermode.setCurrentIndex( rendermode )
    self.mr_approx_type.setCurrentIndex( typ )
    self.mr_approx_parametric.refresh()
    self.mr_approx_fine.refresh()

    if deg>1:
        self.mr_approx_parametric.setVisible( typ==1 )
        self.mr_approx_fine.setVisible( typ==2 )
        self.mr_approx_type_row.setVisible( True )
    else:
        self.mr_approx_parametric.setVisible( True )
        self.mr_approx_fine.setVisible( False )
        self.mr_approx_type_row.setVisible( False )
        typ = 0
    
    pal = de.currentPalette()
    desc = de.currentDescription()
    
    
    # Update the exposed geoshader parameters
    if xgg.Maya:
        import maya.cmds as cmds
        relativeNodes = cmds.listRelatives(desc, children=True, type="transform")
        if not relativeNodes:
            return

        nExists = False
        for relativeNode in relativeNodes:
            if xg.stripNameSpace(str(relativeNode)) == "geoshader":
                nExistsName = pal + "|" + desc + "|" + relativeNode
                nExists = cmds.objExists( nExistsName )
        if nExists:
            cnx = cmds.listConnections(nExistsName + ".miGeoShader")
            if cnx and len(cnx)==1:
                cmds.setAttr( cnx[0] + ".approx_degree", deg )
                cmds.setAttr( cnx[0] + ".approx_mode", typ )
                cmds.setAttr( cnx[0] + ".approx_parametric_subdivisions", subdi )
                cmds.setAttr( cnx[0] + ".approx_fine_sub_pixel_size", fine )
                #cmds.setAttr( cnx[0] + ".render_mode", rendermode )

                # update xg node name in xgen_geo.data
                dataStrings = cmds.getAttr( cnx[0] + ".data" ).split(" ")
                index = [i for i in range(0, len(dataStrings)) if dataStrings[i] == "-palette"]
                dataStrings[index[0] + 1] = xg.stripNameSpace(str(pal))
                index = [i for i in range(0, len(dataStrings)) if dataStrings[i] == "-description"]
                dataStrings[index[0] + 1] = xg.stripNameSpace(str(desc))
                xgenData = dataStrings[0]
                for i in range(1, len(dataStrings)):
                    xgenData += " " + dataStrings[i]
                cmds.setAttr( cnx[0] + ".data", xgenData, type="string" )


# Callback after description creation to switch to mental ray render
def xgmrOnCreateDescription( param ):
    params = str(param).split(',')
    if len(params)==2:
        xg.setAttr( "renderer", "mental ray", params[1], params[0], "RendermanRenderer" )

def xgmrSplineDegreeChanged(self,index):
    if index==1:
        self.setCustomAttr( "mr_splinedegree", "3" )
    else:
        self.setCustomAttr( "mr_splinedegree", "1" )

    self.xgmrRefresh()

def xgmrRenderModeChanged(self,index):
    self.setCustomAttr( "mr_rendermode", str(index) )
    self.xgmrRefresh()

def xgmrApproxTypeChanged(self,index):
    self.setCustomAttr( "mr_approx_type", str(index) )
    self.xgmrRefresh()

def xgmrAutoGeoshadersChanged(self,index):
    xgg.DescriptionEditor.autoCreateMR = index==0
    xgg.DescriptionEditor.updateMentalrayControls()
    self.xgmrRefresh()


#-
# ==========================================================================
# Copyright 2014 Autodesk, Inc. All rights reserved. 
#
# Use of this software is subject to the terms of the Autodesk 
# license agreement provided at the time of installation or download, 
# or which otherwise accompanies this software in either electronic 
# or hard copy form.
#
# ==========================================================================
