#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Description
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Creates a dockable UI that helps camera layout, visualizing DOF, as well as
a faster way of interfacing with cameras within Maya

Filename
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
camerascript.py
"""

# IMPORT STANDARD LIBRARIES
import os
import time
import shutil

# IMPORT THIRD-PARTY LIBRARIES
try:
    import maya.mel as mel
except ImportError:
    mel.eval('env')  # load environment config
except:
    raise


def tabsFunc(*args):
    """
    Clears tabs in the window
    """
    noItens = cmds.menu( widgets['tabsMenu'] , q=1,ia=1)
    allTabs = [widgets['frameLayout_01'], widgets['frameLayout_02'],
               widgets['frameLayout_03'], widgets['frameLayout_04']]

    for item in noItens:
        if cmds.menuItem(item,q=1,rb=1):
            indxItem = noItens.index(item)

            for tab in allTabs:
                if allTabs.index(tab) != indxItem and indxItem < len(allTabs):
                    cmds.frameLayout(tab, e=1, cl=1)
                else:
                    cmds.frameLayout(tab, e=1, cl=0)
# end tabsFunc


def getRVstate():
    """
    Check the render view to see if the window is currently open/active

    Returns:
        bool or NoneType: Tells whether or not the render view is open
    """
    for i in cmds.lsUI(windows=1):
        if i == "renderViewWindow":
            return 1
# end getRVstate


def toggleBttn(button, fLayout, stateChange, vertical,
               horizontalPosA, horizontalPosB):
    """
    Because there's no such thing as a "switch" in Maya's GUI tools or in PyQt
    in general, we must fake one ourselves. This is accomplished by placing a
    button directly on top of a line of text. The trick is that the button,
    when it's in its left position, covers the some text behind it and when the
    switch activates, the button covers up the other side of the textGrp.
    In our case, the textGrp actually reads "On Off" but only "On" or "Off" is
    ever visible at one time.

    Args:
        button: The button to query the press state of (it drives the switch)
        fLayout: The formLayout to query to location of the other elements
        stateChange: The state of the button - whether or not the button
                     should switch locations
        vertical: The vertical position to apply to both on/off states of button
        horizontalPosA: The left position of the button
        horizontalPosB: The right position of the button
    """
    bttnQuery = cmds.button( button, q=True, ann=True )
    if bttnQuery == '0':
        cmds.formLayout(fLayout, e=1, af=[(button,'top', vertical),
                                          (button,'left',horizontalPosA)] )
        cmds.button( button, e=1, ann='1' )
        if stateChange == 0: pass
        else:
            cmds.radioButtonGrp( widgets['RWN_conciseOutRBG'], e=True, en=1 )
    else:
        cmds.formLayout(fLayout, e=1, af=[(button,'top',vertical),
                                          (button,'left',horizontalPosB)] )
        cmds.button(button, e=1, ann='0')
        if stateChange == 0: pass
        else:
            cmds.radioButtonGrp(widgets['RWN_conciseOutRBG'], e=1, en=0)
# end toggleBttn


def gate(gateButtonSel):
    """
    Sets the camera's gate to either "noGate", "filmGate", or "resGate" which
    will update the active camera view's gate settings

    Args:
        gateButtonSel (str): Determines how to toggle between "none",
                             "resolution gate", and "film gate". Valid inputs
                             are "noGate", "filmGate", and "resGate"
    """
    activeCam = getActiveCamShape()
    selection = activeCam

    if (gateButtonSel == "noGate"):
        # Overscan verstion - obsolete
        cmds.camera(selection, e=True, displayFilmGate=0, displayResolution=0)
    elif (gateButtonSel == "filmGate" ):
        cmds.camera(selection, e=True, displayFilmGate=1,
                    displayResolution=0, overscan=1.3 )
    elif (gateButtonSel == "resGate" ):
        cmds.camera(selection, e=True, displayFilmGate=0,
                    displayResolution=1, overscan=1.3)
# end gate


def safe(safeState, safeAnnotation):
    """
    Sets the safety on the currently active camera

    Args:
        safeState (bool): Whether or not to turn on or off safeAnnotation
        safeAnnotation (bool): False will edit the camera's safe action,
                               whereas True will edit the safe title
    """
    activeCam = getActiveCamShape()
    if safeAnnotation==0:
        cmds.camera(activeCam, e=True, displaySafeAction=safeState)
    else:
        cmds.camera(activeCam, e=True, displaySafeTitle=safeState)
# end safe


def camName():
    """
    Gets the selected camera in the GUI's textScrollList and returns it

    Returns:
        str: The camera name that the user selected in the textScrollList GUI
    """
    txtSelCam = cmds.textScrollList( widgets['cameraTextSL'], q=True, selectItem=True )
    txtCam = txtSelCam[0]
    return txtCam
# end camName


def selCamera():
    """
    Gets the camera's transform from the shape name retrieved from camName.
    It then selects the resulting camera's transform
    """
    camConnections = cmds.listHistory(camName())
    camShape = camConnections[0]
    actualSelection = cmds.ls( sl=True )
    cmds.select( actualSelection, r=True )
# end selCamera


def resetCamControls():
    """
    Sets the active camera's controls back to the GUI's default settings.
    Zoom is set to 100%, horizontal and vertical pan is reset,
    and near/far clip planes go back to Maya's default values
    """
    cameraTextSLOutput = cmds.textScrollList(widgets['cameraTextSL'],
                                             query=True, si=True)
    cmds.setAttr( cameraTextSLOutput[0] + '.zoom', 1 )
    cmds.setAttr( cameraTextSLOutput[0] + '.horizontalPan', 0 )
    cmds.setAttr( cameraTextSLOutput[0] + '.verticalPan', 0 )
    cmds.setAttr( cameraTextSLOutput[0] + '.nearClipPlane', 0.1 )
    cmds.setAttr( cameraTextSLOutput[0] + '.farClipPlane', 10000 )
# end resetCamControls


def currentPanel():
    """
    Gets the current panel that is active based on whether or not the panel
    has been clicked into aka in "focus" and then switches the GUI and active
    camera view to that camera
    """
    focusPanel = cmds.getPanel( withFocus=True )
    if (focusPanel=='scriptEditorPanel1'):
        focusPanel='modelPanel4'
    currentCamera = cmds.modelPanel( q=True, camera=focusPanel )
    if (currentCamera==''):
        currentCamera='persp'
    cmds.textScrollList( widgets['cameraTextSL'], e=True, selectItem=currentCamera )
    switchCamera()
# end currentPanel


def switchCamera():
    """
    Changes the camera view to the current selected camera. This method is used
    in a variety of places like currentPanel or whenever the camera needs to
    be updated in Maya's viewer or within the GUI
    """
    selCamera()
    selected = cmds.textScrollList( widgets['cameraTextSL'], q=True, selectItem=True )
    lookThruToggleCheck = cmds.button( widgets['lookThruClean'], query=True, ann=True )
    if int(lookThruToggleCheck) == 0:
        cmds.lookThru( selected[0] )
    else:
        pass
    # Connect the sliders to the selected camera
    modifyCamSliders( selected[0] )
# end switchCameras


def checkForCamera():
    """
    A safety feature for the GUI. This method is run to make sure that there is
    always camera details for the GUI to reflect or makes one, if there isn't
    """
    selObj = cmds.ls( sl=True )
    if (len(selObj) != 0):
        hist = cmds.listHistory()
        lastSelected = cmds.nodeType( hist[0] )

        if (lastSelected == "camera"):
            populateTextSL()
            findCurrentCamera()
            createMissingCamera()
    populateTextSL()
    findCurrentCamera()
    createMissingCamera()
# end checkForCamera


def setAttrKeyable_cam():
    """
    Changes all of the relevant attributes on the active camera to allow keys
    """
    cmds.setAttr( ((camName()) + ".horizontalFilmOffset"), k=True )
    cmds.setAttr( ((camName()) + ".verticalFilmOffset"), k=True )
    cmds.setAttr( ((camName()) + ".horizontalFilmAperture"), k=True )
    cmds.setAttr( ((camName()) + ".verticalFilmAperture"), k=True )
    cmds.setAttr( ((camName()) + ".lensSqueezeRatio"), k=True )
    cmds.setAttr( ((camName()) + ".fStop"), k=True )
    cmds.setAttr( ((camName()) + ".focusDistance"), k=True )
    cmds.setAttr( ((camName()) + ".shutterAngle"), k=True )
# end setAttrKeyable_cam


def farClipPlaneFix():
    """
    There was an issue where the farClipPlane would mess up when I was
    switching between cameras but I've been able to get it work it the far clip
    plane was set out to a very large number, at least initially
    """
    allCam = cmds.ls( dag=True, type='camera' )
    for cam in allCam:
        cmds.setAttr( cam + ".farClipPlane", 1000000 )
        setAttrKeyable_cam()
# end farClipPlaneFix


def createMissingCamera():
    """
    Initializes Maya's default view cameras, in case for whatever reason they
    are deleted by accident. After being made, they're made invisible and added
    to their respective viewsets.
    """
    if (cmds.objExists('bottom')):
        pass
    else:
        bottom = cmds.camera( n='bottom' )
        cmds.viewSet( bottom[0], bottom=True )
        cmds.rename( 'bottom1', 'bottom' )
        cmds.setAttr( 'bottom.visibility', 0 )
        farClipPlaneFix()

    if (cmds.objExists('back')):
        pass
    else:
        back = cmds.camera( n='back' )
        cmds.viewSet( back[0], back=True )
        cmds.rename( 'back1', 'back' )
        cmds.setAttr( 'back.visibility', 0 )
        farClipPlaneFix()

    if (cmds.objExists('left')):
        pass
    else:
        left = cmds.camera( n='left' )
        cmds.viewSet( left[0], leftSide=True )
        cmds.rename( 'left1', 'left' )
        cmds.setAttr( 'left.visibility', 0 )
        farClipPlaneFix()
# end createMissingCamera


def findCurrentCamera():
    """
    This is hacky but it'll basically just select the upper right panel
    (modelPanel4) if the user has the GUI as a floating window which breaks
    the script when either the Outliner or Script Editor are open
    """
    focusPanel = cmds.getPanel( withFocus=True )
    if (focusPanel=='scriptEditorPanel1'):
        focusPanel='modelPanel4'
    if focusPanel=='outlinerPanel1':
        focusPanel='modelPanel4'
    currentCamera = cmds.modelPanel( focusPanel, q=True, camera=True )
    if (currentCamera == ''):
        currentCamera='persp'
    cmds.textScrollList( widgets['cameraTextSL'], e=True, selectItem=currentCamera )
    switchCamera()
# end findCurrentCamera


def populateTextSL():
    """
    Puts all of the cameras in the scene into the GUI's textScrollList and then
    gets which camera is the current camera and sets it up in the GUI
    """
    cameras = cmds.listCameras()
    cmds.textScrollList( widgets['cameraTextSL'], e=True, removeAll=True )
    for cam in cameras:
        cmds.textScrollList( widgets['cameraTextSL'], e=True, append=cam )
    findCurrentCamera()
# end populateTextSL


def getActiveCamShape():
    """
    Gets the current camera shape by panel and pane
    """
    pan = cmds.getPanel(wf=True)
    cam = cmds.modelPanel(pan, q=True, camera=True)
    return cam
# end getActiveCamShape


def panZoomEnableCmd(onOff):
    """
    Enable/Disable Pan/Zoom on the current camera

    Args:
        onOff (bool): Determines whether or not to allow pan/zoom on the camera
    """
    cmds.rowLayout(widgets['rowLayout_01_2'], e=True, en=onOff)
    cmds.rowLayout(widgets['rowLayout_01_3'], e=True, en=onOff)
    cmds.rowLayout(widgets['rowLayout_01_4'], e=True, en=onOff)
# end panZoomEnableCmd


def modifyCamSliders(selectedCam):
    """
    Connects GUI controls to the selectedCam input to make sure the cameras are
    represented in the GUI accurately

    Args:
        selectedCam (str): The selected camera shape node
    """
    cmds.connectControl( widgets['zoomField'], (selectedCam + '.zoom') )
    cmds.connectControl( widgets['zoomSlider'], (selectedCam + '.zoom') )
    cmds.connectControl( widgets['horiField'], (selectedCam + '.horizontalPan') )
    cmds.connectControl( widgets['horiSlider'], (selectedCam + '.horizontalPan') )
    cmds.connectControl( widgets['vertiField'], (selectedCam + '.verticalPan') )
    cmds.connectControl( widgets['vertiSlider'], (selectedCam + '.verticalPan') )
    cmds.connectControl( widgets['panZoomEnable'], (selectedCam + '.panZoomEnabled') )
    cmds.connectControl( widgets['nearClipField'], (selectedCam + '.nearClipPlane') )
    cmds.connectControl( widgets['nearClipSlider'], (selectedCam + '.nearClipPlane') )
    cmds.connectControl( widgets['farClipField'], (selectedCam + '.farClipPlane') )
    cmds.connectControl( widgets['farClipSlider'], (selectedCam + '.farClipPlane') )
# end modifyCamSliders


def createNewCam():
    """
    Creates a Maya camera

    .. todo::
        Replace method with a custom camera rig
    """
    cmds.camera()
# end createNewCam


def sin100_create():
    """
    The output of a python sine wave, set to keyframes on a Maya animation curve

    .. note::
        The sine wave is stretched by x100 so any inputs that use this
        curve must be modified to reflect this
    """
    sin = cmds.createNode( 'animCurveTL' )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=0 , value=0 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=5 , value=0.04998 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=10 , value=0.09983 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=15 , value=0.14944 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=20 , value=0.19867 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=25 , value=0.2474 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=30 , value=0.29552 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=35 , value=0.3429 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=40 , value=0.38942 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=45 , value=0.43497 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=50 , value=0.47943 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=55 , value=0.52269 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=60 , value=0.56464 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=65 , value=0.60519 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=70 , value=0.64422 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=75 , value=0.68164 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=80 , value=0.71736 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=85 , value=0.75128 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=90 , value=0.78333 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=95 , value=0.81342 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=100 , value=0.84147 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=105 , value=0.86743 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=110 , value=0.89121 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=115 , value=0.91276 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=120 , value=0.93204 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=125 , value=0.94898 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=130 , value=0.96356 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=135 , value=0.97572 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=140 , value=0.98545 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=145 , value=0.99271 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=150 , value=0.99749 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=155 , value=0.99978 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=157 , value=1 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=160 , value=0.99957 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=165 , value=0.99687 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=170 , value=0.99166 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=175 , value=0.98399 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=180 , value=0.97385 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=185 , value=0.96128 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=190 , value=0.9463 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=195 , value=0.92896 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=200 , value=0.9093 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=205 , value=0.88736 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=210 , value=0.86321 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=215 , value=0.8369 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=220 , value=0.8085 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=225 , value=0.77807 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=230 , value=0.74571 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=235 , value=0.71147 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=240 , value=0.67546 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=245 , value=0.63776 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=250 , value=0.59847 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=255 , value=0.55768 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=260 , value=0.5155 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=265 , value=0.47203 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=270 , value=0.42738 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=275 , value=0.38166 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=280 , value=0.33499 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=285 , value=0.28748 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=290 , value=0.23925 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=295 , value=0.19042 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=300 , value=0.14112 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=305 , value=0.09146 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=310 , value=0.04158 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=314.15 , value=0 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=315 , value=-0.0084 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=320 , value=-0.0584 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=325 , value=-0.1082 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=330 , value=-0.1577 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=335 , value=-0.2069 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=340 , value=-0.2555 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=345 , value=-0.3035 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=350 , value=-0.3508 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=355 , value=-0.3971 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=360 , value=-0.4425 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=365 , value=-0.4868 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=370 , value=-0.5298 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=375 , value=-0.5716 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=380 , value=-0.6119 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=385 , value=-0.6506 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=390 , value=-0.6878 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=395 , value=-0.7232 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=400 , value=-0.7568 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=405 , value=-0.7885 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=410 , value=-0.8183 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=415 , value=-0.846 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=420 , value=-0.8716 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=425 , value=-0.895 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=430 , value=-0.9162 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=435 , value=-0.9351 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=440 , value=-0.9516 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=445 , value=-0.9658 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=450 , value=-0.9775 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=455 , value=-0.9868 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=460 , value=-0.9937 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=465 , value=-0.9981 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=470 , value=-0.9999 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=471 , value=-1 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=475 , value=-0.9993 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=480 , value=-0.9962 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=485 , value=-0.9905 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=490 , value=-0.9825 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=495 , value=-0.9719 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=500 , value=-0.9589 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=505 , value=-0.9435 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=510 , value=-0.9258 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=515 , value=-0.9058 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=520 , value=-0.8835 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=525 , value=-0.8589 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=530 , value=-0.8323 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=535 , value=-0.8035 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=540 , value=-0.7728 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=545 , value=-0.7401 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=550 , value=-0.7055 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=555 , value=-0.6692 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=560 , value=-0.6313 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=565 , value=-0.5917 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=570 , value=-0.5507 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=575 , value=-0.5083 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=580 , value=-0.4646 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=585 , value=-0.4198 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=590 , value=-0.3739 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=595 , value=-0.3271 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=600 , value=-0.2794 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=605 , value=-0.2311 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=610 , value=-0.1822 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=615 , value=-0.1328 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=620 , value=-0.0831 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=625 , value=-0.0332 )
    cmds.setKeyframe( sin, inTangentType='linear', outTangentType='linear', time=628.31 , value=0 )

    cmds.selectKey( sin, add=True, k=True )
    cmds.setInfinity( preInfinite='cycleRelative' )
    cmds.setInfinity( postInfinite='cycleRelative' )
    return(sin)
# end sin100_create


def cameraFrustum_make():
    """
    Creates an accurate representation of the camera's frustum as a geometry
    in the Maya view. Unlike Maya default camera's shape, this algorithm takes
    into account camera settings such as overscan, vertical/horizontal
    priority, and other settings that the default camera settings don't.
    """
    # Get camera selection. If none selected, get from textSL selection. If none there, return selection error

    #First check if shape
    selection = cmds.ls( sl=True )
    camShape = cmds.ls( sl=True, cameras=True )
    if camShape==[]:
        # If it isn't a shape, it could just be a transform
        # if so, it's child will be a camera
        camShape = cmds.ls( sl=True )
        camShape = cmds.listRelatives( camShape, shapes=True )
        camShape = cmds.ls( camShape, cameras=True )
        if camShape==[]:
            # If the child isn't a camera, we know they didn't select a camera
            sys.exit( 'SelectionError: You haven\'t selected a valid camera' )
        else:
            # But if it is a camera, then get the camera's transform
            camTrans = cmds.listRelatives( camShape, parent=True, noIntermediate=True )
            camTrans = camTrans[0]
            camShape = camShape[0]
    else:
        # The else statement means that the selected maya node was a shape.
        camTrans=cmds.listRelatives( camShape, parent=True, noIntermediate=True )
        camTrans = camTrans[0]
    # AUTHOR NOTE: If generating a new camera, maybe I should auto-set rotateOrder to something other than default





    # Check if a frustum already exists. If the frustum exists, delete it completely
    frustCheckConnections = []
    try:
        frustCheckConnections = cmds.listConnections( camTrans + '.frustumVisibility', plugs=True, d=True )
    except:
        pass
    if frustCheckConnections != []:
        frust_innerContainerCheck = cmds.container( fc=frustCheckConnections, q=True )
        frust_outerContainer = cmds.container( fc=frust_innerContainerCheck, q=True )

        frust_innerNodes = cmds.container( frust_outerContainer, nodeList=True, q=True )
        cmds.delete( frust_innerNodes )

        # get all outbound connections of frustumContainer
        frust_outBoundConnections = cmds.listConnections( frust_outerContainer, p=True, d=True, s=True )
        for i in range(0,len(frust_outBoundConnections)):
            b = frust_outBoundConnections[i].split('.')
            cmds.delete(b[0])



    cam_trans = camTrans
    cam_shape = camShape


    # S01 :: I need a lot of info from the camera to make this script.
    #        Section 1 - Creating/initializing these 'global' nodes

    # S01a :: Film Aspect Ratio
    filmAspect = cmds.createNode( 'multiplyDivide', name='filmAspect_MD' )
    cmds.setAttr( filmAspect + '.operation', 2 )
    cmds.connectAttr( cam_shape + '.horizontalFilmAperture', filmAspect + '.input1X' )
    cmds.connectAttr( cam_shape + '.verticalFilmAperture', filmAspect + '.input2X' )

    # S01b :: Resolution Ratio
    #         Film Aspect Ratio and Resolution Ratio are compared against for clipping
    #         at nearly every case for filmFit. Resolution Aspect Ratio will now be
    #         resAspect for brevity.
    resAspect = cmds.createNode( 'multiplyDivide', name='resAspect_MD' )
    cmds.setAttr( resAspect + '.operation', 2 )
    cmds.connectAttr( 'defaultResolution.width', resAspect + '.input1X' )
    cmds.connectAttr( 'defaultResolution.height', resAspect + '.input2X' )

    # S01c :: Aperture
    visAspect_ifShakeOverscanEnabled_MD = cmds.createNode( 'multiplyDivide', name='frust_visAspect_ifShakeOverscanEnabled_MD' )
    cmds.setAttr( visAspect_ifShakeOverscanEnabled_MD + '.operation', 1 )
    cmds.connectAttr( cam_shape + '.horizontalFilmAperture', visAspect_ifShakeOverscanEnabled_MD + '.input1X' )
    cmds.connectAttr( cam_shape + '.shakeOverscan', visAspect_ifShakeOverscanEnabled_MD + '.input2X' )
    cmds.connectAttr( cam_shape + '.verticalFilmAperture', visAspect_ifShakeOverscanEnabled_MD + '.input1Y' )
    cmds.connectAttr( cam_shape + '.shakeOverscan', visAspect_ifShakeOverscanEnabled_MD + '.input2Y' )

    # This conditional's outColor R/G outputs what is later noted as
    # aper0 and aper1. It is mainly used as output for what is later taken
    # as a vector for find the vFOV and hFOV. Its values are modified if
    # shake is enabled and so hence the conditional with two possible pairs
    # of solutions. Later noted as aper0 & aper1
    aper = cmds.createNode( 'condition', name='aper_ifShakeOverEnabled_cond' )
    cmds.setAttr( aper + '.operation', 0 )
    cmds.connectAttr( cam_shape + '.shakeOverscanEnabled', aper + '.firstTerm' )
    cmds.connectAttr( visAspect_ifShakeOverscanEnabled_MD + '.outputX', aper + '.colorIfTrueR' )
    cmds.connectAttr( visAspect_ifShakeOverscanEnabled_MD + '.outputY', aper + '.colorIfTrueG' )
    cmds.connectAttr( cam_shape + '.horizontalFilmAperture', aper + '.colorIfFalseR' )
    cmds.connectAttr( cam_shape + '.verticalFilmAperture', aper + '.colorIfFalseG' )

    # S01a :: Visual Aspect - Aperture horizontal/vertical comped with shakeOverscan
    # ShakeOverscan multiplies against aperture. This must be accounted for.

    # this will be the visual aspect ratio - a combination of aperture horizontal/vertical
    # aperture horiz/vert is later noted as aper0 and aper1, respectively
    # visAspect, as such, gives two outputs which are noted as visAsp0/visAsp1,
    # for brevity's sake.
    visAspect = cmds.createNode( 'multiplyDivide', name='visAspect_postCondition_MD' )
    cmds.setAttr( visAspect + '.operation', 1 )
    cmds.setAttr( visAspect + '.input2X', 25.4 )
    cmds.setAttr( visAspect + '.input2Y', 25.4 )
    cmds.connectAttr( aper + '.outColorR', visAspect + '.input1X' )
    cmds.connectAttr( aper + '.outColorG', visAspect + '.input1Y' )

    # S02 :: Cases based on all four variants of 'filmFit'
    # S02a - Case 0 - filmFit == Fill
    # Set inner condition if filmAspect <= resAspect
    ff0_filmAsp_lessThanEq_resAsp_cond = cmds.createNode( 'condition', name='ff0_filmAsp_lessThanEq_resAsp_cond' )
    cmds.setAttr( ff0_filmAsp_lessThanEq_resAsp_cond + '.operation', 5 )
    # add the default visAper0 and visAper1 for the colorIfTrue/False, respectively
    cmds.connectAttr( visAspect + '.outputX', ff0_filmAsp_lessThanEq_resAsp_cond + '.colorIfTrueR' )
    cmds.connectAttr( visAspect + '.outputY', ff0_filmAsp_lessThanEq_resAsp_cond + '.colorIfFalseG' )

    # Need visAper1 = aper0 /resAsp * 25.4 if filmAspect <= resAspect
    ff0_visAper1_aper0_div_resAsp_MD = cmds.createNode( 'multiplyDivide', name='ff0_visAper1_aper0_div_resAsp_MD' )
    cmds.setAttr( ff0_visAper1_aper0_div_resAsp_MD + '.operation', 2 )
    cmds.connectAttr( aper + '.outColorR', ff0_visAper1_aper0_div_resAsp_MD  + '.input1Y' )
    cmds.connectAttr( resAspect + '.outputX', ff0_visAper1_aper0_div_resAsp_MD  + '.input2Y' )

    ff0_visAper1_aper0_div_resAsp_mult_254_MD = cmds.createNode( 'multiplyDivide', name='ff0_visAper1_aper0_div_resAsp_mult_254_MD' )
    cmds.setAttr( ff0_visAper1_aper0_div_resAsp_mult_254_MD + '.operation', 1 )
    cmds.setAttr( ff0_visAper1_aper0_div_resAsp_mult_254_MD + '.input2Y', 25.4 )
    cmds.connectAttr( ff0_visAper1_aper0_div_resAsp_MD + '.outputY', ff0_visAper1_aper0_div_resAsp_mult_254_MD + '.input1Y' )

    # Need visAper0 = aper1 * resAsp * 25.4 if filmAsp > resAsp
    ff0_visAper0_aper1_mult_resAsp_MD = cmds.createNode( 'multiplyDivide', name='ff0_visAper0_aper1_mult_resAsp_MD' )
    cmds.setAttr( ff0_visAper0_aper1_mult_resAsp_MD + '.operation', 1 )
    cmds.connectAttr( aper + '.outColorG', ff0_visAper0_aper1_mult_resAsp_MD + '.input1X' )
    cmds.connectAttr( resAspect + '.outputX', ff0_visAper0_aper1_mult_resAsp_MD + '.input2X' )

    ff0_visAper0_aper1_mult_resAsp_mult_254_MD = cmds.createNode( 'multiplyDivide', name='ff0_visAper0_aper1_mult_resAsp_mult_254_MD')
    cmds.setAttr( ff0_visAper0_aper1_mult_resAsp_mult_254_MD + '.operation', 1 )
    cmds.setAttr( ff0_visAper0_aper1_mult_resAsp_mult_254_MD + '.input2X', 25.4 )
    cmds.connectAttr( ff0_visAper0_aper1_mult_resAsp_MD + '.outputX', ff0_visAper0_aper1_mult_resAsp_mult_254_MD + '.input1X' )

    # connect up the inner conditional statement with the visAper outputs
    # as well as the first term (remember, filmAspect <= resAspect)
    cmds.connectAttr( filmAspect + '.outputX', ff0_filmAsp_lessThanEq_resAsp_cond + '.firstTerm' )
    cmds.connectAttr( resAspect + '.outputX', ff0_filmAsp_lessThanEq_resAsp_cond + '.secondTerm' )
    cmds.connectAttr( ff0_visAper1_aper0_div_resAsp_mult_254_MD + '.outputY', ff0_filmAsp_lessThanEq_resAsp_cond + '.colorIfTrueG' )
    cmds.connectAttr( ff0_visAper0_aper1_mult_resAsp_mult_254_MD + '.outputX', ff0_filmAsp_lessThanEq_resAsp_cond + '.colorIfFalseR' )

    # S02b :: Case 1 - filmFit == Horizontal
    # Because the filmFit uses the horizontal (width) as its primary viewer,
    # we must also account for any offset vertically. This will be referred
    # as offset1 or off1. When we next do the vertical alignment, we'll have
    # to do the same for horizontal offsets.

    # Create offset1 = ( (aper0 / resAsp) - aper1) * filmFitOffset * 0.5 * 2.54
    # Why * 0.5 and then * 2.54, we need 1/10th the value of 25.4 (1 inch = 25.4 mm )
    # but also because this will be implemented as a scale attribute, the value must
    # then be valved because scale is applied in two directions.
    # I chose not to put 1.27 because I wanted to be able to later remember
    # where I got those numbers from. 1.27 is kind of confusing.
    # * 0.5 * 2.54 isnt. You're welcome, future me!
    ff1_off1_aper0_div_resAsp_MD = cmds.createNode( 'multiplyDivide', name='ff1_off1_aper0_div_resAsp_MD' )
    cmds.setAttr( ff1_off1_aper0_div_resAsp_MD + '.operation', 2 )
    cmds.connectAttr( aper + '.outColorR', ff1_off1_aper0_div_resAsp_MD + '.input1Z' )
    cmds.connectAttr( resAspect + '.outputX', ff1_off1_aper0_div_resAsp_MD +'.input2Z' )

    ff1_off1_aper0_div_resAsp_minus_aper1_PMA = cmds.createNode( 'plusMinusAverage',name='ff1_off1_aper0_div_resAsp_minus_aper1_PMA' )
    cmds.setAttr( ff1_off1_aper0_div_resAsp_minus_aper1_PMA + '.operation', 2 )
    cmds.connectAttr( ff1_off1_aper0_div_resAsp_MD + '.outputZ', ff1_off1_aper0_div_resAsp_minus_aper1_PMA + '.input3D[0].input3Dz' )
    cmds.connectAttr( aper + '.outColorG', ff1_off1_aper0_div_resAsp_minus_aper1_PMA + '.input3D[1].input3Dz' )

    ff1_off1_aper01_composite_filmFitOff_mult_MD = cmds.createNode( 'multiplyDivide', name='ff1_off1_aper01_composite_filmFitOff_mult_MD' )
    cmds.setAttr( ff1_off1_aper01_composite_filmFitOff_mult_MD + '.operation', 1 )
    cmds.connectAttr( ff1_off1_aper0_div_resAsp_minus_aper1_PMA + '.output3Dz', ff1_off1_aper01_composite_filmFitOff_mult_MD + '.input1Z' )
    cmds.connectAttr( cam_shape + '.filmFitOffset', ff1_off1_aper01_composite_filmFitOff_mult_MD + '.input2Z' )

    # Here is the * 0.5 * 2.54.
    ff1_off1_filmFitOff_composite_half_mult_MD = cmds.createNode( 'multiplyDivide', name='ff1_off1_filmFitOff_composite_half_mult_MD' )
    cmds.setAttr( ff1_off1_filmFitOff_composite_half_mult_MD + '.operation', 1 )
    cmds.setAttr( ff1_off1_filmFitOff_composite_half_mult_MD + '.input2Z', 0.5 )
    cmds.connectAttr( ff1_off1_aper01_composite_filmFitOff_mult_MD + '.outputZ', ff1_off1_filmFitOff_composite_half_mult_MD + '.input1Z' )

    ff1_off1_filmFitOff_composite_half_2point54_mult_MD = cmds.createNode( 'multiplyDivide', name='ff1_off1_filmFitOff_composite_half_2point54_mult_MD' )
    cmds.setAttr( ff1_off1_filmFitOff_composite_half_2point54_mult_MD + '.operation', 1 )
    cmds.setAttr( ff1_off1_filmFitOff_composite_half_2point54_mult_MD + '.input2Z', 2.54 )
    cmds.connectAttr( ff1_off1_filmFitOff_composite_half_mult_MD + '.outputZ', ff1_off1_filmFitOff_composite_half_2point54_mult_MD + '.input1Z' )

    # In Maya, there is no way to create a && conditional operation 'in-node'
    # but we can multiply two conditional statements and compare that output
    # which is basically a more verbose method of doing the same thing.
    ff1_filmAsp_greatThan_resAsp_cond = cmds.createNode( 'condition', name='ff1_filmAsp_greatThan_resAsp_cond' )
    cmds.setAttr( ff1_filmAsp_greatThan_resAsp_cond + '.operation', 2 )
    cmds.setAttr( ff1_filmAsp_greatThan_resAsp_cond + '.colorIfTrueR', 1 )
    cmds.setAttr( ff1_filmAsp_greatThan_resAsp_cond + '.colorIfFalseR', 0 )
    cmds.connectAttr( filmAspect + '.outputX', ff1_filmAsp_greatThan_resAsp_cond + '.firstTerm' )
    cmds.connectAttr( resAspect + '.outputX', ff1_filmAsp_greatThan_resAsp_cond  + '.secondTerm' )

    ff1_filmOffset_notZero_check_cond = cmds.createNode( 'condition', name ='ff1_filmOffset_notZero_check_cond' )
    cmds.setAttr( ff1_filmOffset_notZero_check_cond + '.operation', 1 )
    cmds.setAttr( ff1_filmOffset_notZero_check_cond + '.secondTerm', 0 )
    cmds.setAttr( ff1_filmOffset_notZero_check_cond + '.colorIfTrueR', 1 )
    cmds.setAttr( ff1_filmOffset_notZero_check_cond + '.colorIfFalseR', 0 )
    cmds.connectAttr( cam_shape + '.filmFitOffset', ff1_filmOffset_notZero_check_cond + '.firstTerm' )

    # Now combine the two conditionals with a multiplyDivide. This will be
    # used in the final inner conditional block
    ff1_filmAsp_gThan_resAsp_fFONotZero_MD = cmds.createNode( 'multiplyDivide', name='ff1_filmAsp_greatThan_resAsp_and_filmFitOffNotZero_MD' )
    cmds.setAttr( ff1_filmAsp_gThan_resAsp_fFONotZero_MD + '.operation', 1 )
    cmds.connectAttr( ff1_filmAsp_greatThan_resAsp_cond + '.outColorR', ff1_filmAsp_gThan_resAsp_fFONotZero_MD + '.input1X' )
    cmds.connectAttr( ff1_filmOffset_notZero_check_cond + '.outColorR', ff1_filmAsp_gThan_resAsp_fFONotZero_MD + '.input2X' )

    # Create inner conditional block filmAsp > resAsp && filmFitOffset != 0
    # Add conditional composite to represent the .firstTerm
    # Now add offset1 = ( (aper0 / resAsp) - aper1 ) * filmFitOffset * 0.5 * 2.54
    # As its only output. Its colorIfFalse must be 0 because that is what it
    # would otherwise be by default
    ff1_inner_and_condition_composite_cond = cmds.createNode( 'condition', name='ff1_inner_and_condition_composite_cond' )
    cmds.setAttr( ff1_inner_and_condition_composite_cond + '.operation', 0 )
    cmds.setAttr( ff1_inner_and_condition_composite_cond + '.secondTerm', 1 )
    cmds.setAttr( ff1_inner_and_condition_composite_cond + '.colorIfFalseB', 0 )
    cmds.connectAttr( ff1_filmAsp_gThan_resAsp_fFONotZero_MD + '.outputX', ff1_inner_and_condition_composite_cond + '.firstTerm' )
    cmds.connectAttr( ff1_off1_filmFitOff_composite_half_2point54_mult_MD + '.outputZ' , ff1_inner_and_condition_composite_cond + '.colorIfTrueB' )

    # Lastly, regardless of the double conditional succeeding or failing,
    # if Case 1, visAper1 = aper0 / resAsp * 25.4
    # This will be connected to the main condition later but initialized now
    ff1_visAper1_aper0_div_resAsp_MD = cmds.createNode( 'multiplyDivide', name='ff1_visAper1_aper0_div_resAsp_MD' )
    cmds.setAttr( ff1_visAper1_aper0_div_resAsp_MD + '.operation', 2 )
    cmds.connectAttr( aper + '.outColorR', ff1_visAper1_aper0_div_resAsp_MD + '.input1Y' )
    cmds.connectAttr( resAspect + '.outputX', ff1_visAper1_aper0_div_resAsp_MD + '.input2Y' )

    ff1_visAper1_aper0_div_resAsp_mult_254_MD = cmds.createNode( 'multiplyDivide', name='ff1_visAper1_aper0_div_resAsp_mult_254_MD' )
    cmds.setAttr( ff1_visAper1_aper0_div_resAsp_mult_254_MD + '.operation', 1 )
    cmds.setAttr( ff1_visAper1_aper0_div_resAsp_mult_254_MD + '.input2Y', 25.4 )
    cmds.connectAttr( ff1_visAper1_aper0_div_resAsp_MD + '.outputY', ff1_visAper1_aper0_div_resAsp_mult_254_MD + '.input1Y' )

    # S02c :: Case 2 filmFit == Vertical
    # This is the shares almost identical to horizontal but reversed.
    # Horizontal offset is compared against the same conditional statement
    # filmAsp < resAsp && filmFitOffset !=0.
    # Horizontal offset will be referred to a off0, for brevity
    ff2_off0_aper1_mult_resAsp_MD = cmds.createNode( 'multiplyDivide', name='ff2_off0_aper1_mult_resAsp_MD' )
    cmds.setAttr( ff2_off0_aper1_mult_resAsp_MD + '.operation', 1 )
    cmds.connectAttr( aper + '.outColorG', ff2_off0_aper1_mult_resAsp_MD + '.input1Z' )
    cmds.connectAttr( resAspect + '.outputX', ff2_off0_aper1_mult_resAsp_MD +'.input2Z' )

    ff2_off0_aper1_mult_resAsp_minus_aper0_PMA = cmds.createNode( 'plusMinusAverage',name='ff2_off0_aper1_mult_resAsp_minus_aper0_PMA' )
    cmds.setAttr( ff2_off0_aper1_mult_resAsp_minus_aper0_PMA + '.operation', 2 )
    cmds.connectAttr( ff2_off0_aper1_mult_resAsp_MD + '.outputZ', ff2_off0_aper1_mult_resAsp_minus_aper0_PMA + '.input3D[0].input3Dz' )
    cmds.connectAttr( aper + '.outColorG', ff2_off0_aper1_mult_resAsp_minus_aper0_PMA + '.input3D[1].input3Dz' )

    ff2_off0_aper1_composite_filmFitOff_mult_MD = cmds.createNode( 'multiplyDivide', name='ff2_off0_aper1_composite_filmFitOff_mult_MD' )
    cmds.setAttr( ff2_off0_aper1_composite_filmFitOff_mult_MD + '.operation', 1 )
    cmds.connectAttr( ff2_off0_aper1_mult_resAsp_minus_aper0_PMA + '.output3Dz', ff2_off0_aper1_composite_filmFitOff_mult_MD + '.input1Z' )
    cmds.connectAttr( cam_shape + '.filmFitOffset', ff2_off0_aper1_composite_filmFitOff_mult_MD + '.input2Z' )

    # Here is the * 0.5 * 2.54. Same as before.
    ff2_off0_filmFitOff_composite_half_mult_MD = cmds.createNode( 'multiplyDivide', name='ff2_off0_filmFitOff_composite_half_mult_MD' )
    cmds.setAttr( ff2_off0_filmFitOff_composite_half_mult_MD + '.operation', 1 )
    cmds.setAttr( ff2_off0_filmFitOff_composite_half_mult_MD + '.input2Z', 0.5 )
    cmds.connectAttr( ff2_off0_aper1_composite_filmFitOff_mult_MD + '.outputZ', ff2_off0_filmFitOff_composite_half_mult_MD + '.input1Z' )

    ff2_off0_filmFitOff_composite_half_2point54_mult_MD = cmds.createNode( 'multiplyDivide', name='ff2_off0_filmFitOff_composite_half_2point54_mult_MD' )
    cmds.setAttr( ff2_off0_filmFitOff_composite_half_2point54_mult_MD + '.operation', 1 )
    cmds.setAttr( ff2_off0_filmFitOff_composite_half_2point54_mult_MD + '.input2Z', 2.54 )
    cmds.connectAttr( ff2_off0_filmFitOff_composite_half_mult_MD + '.outputZ', ff2_off0_filmFitOff_composite_half_2point54_mult_MD + '.input1Z' )

    # In Maya, there is no way to create a && conditional operation 'in-node'
    # but we can multiply two conditional statements and compare that output
    # which is basically a more verbose method of doing the same thing.
    ff2_filmAsp_lessThan_resAsp_cond = cmds.createNode( 'condition', name='ff2_filmAsp_lessThan_resAsp_cond' )
    cmds.setAttr( ff2_filmAsp_lessThan_resAsp_cond + '.operation', 2 )
    cmds.setAttr( ff2_filmAsp_lessThan_resAsp_cond + '.colorIfTrueR', 1 )
    cmds.setAttr( ff2_filmAsp_lessThan_resAsp_cond + '.colorIfFalseR', 0 )
    cmds.connectAttr( filmAspect + '.outputX', ff2_filmAsp_lessThan_resAsp_cond + '.firstTerm' )
    cmds.connectAttr( resAspect + '.outputX', ff2_filmAsp_lessThan_resAsp_cond + '.secondTerm' )

    ff2_filmOffset_notZero_check_cond = cmds.createNode( 'condition', name ='ff2_filmOffset_notZero_check_cond' )
    cmds.setAttr( ff2_filmOffset_notZero_check_cond + '.operation', 1 )
    cmds.setAttr( ff2_filmOffset_notZero_check_cond + '.secondTerm', 0 )
    cmds.setAttr( ff2_filmOffset_notZero_check_cond + '.colorIfTrueR', 1 )
    cmds.setAttr( ff2_filmOffset_notZero_check_cond + '.colorIfFalseR', 0 )
    cmds.connectAttr( cam_shape + '.filmFitOffset', ff2_filmOffset_notZero_check_cond + '.firstTerm' )

    # Now combine the two conditionals with a multiplyDivide. This will be
    # used in the final inner conditional block
    ff2_filmAsp_lThan_resAsp_fFONotZero_MD = cmds.createNode( 'multiplyDivide', name='ff2_filmAsp_lessThan_resAsp_filmFitOffsetNotZero_MD' )
    cmds.setAttr( ff2_filmAsp_lThan_resAsp_fFONotZero_MD + '.operation', 1 )
    cmds.connectAttr( ff2_filmAsp_lessThan_resAsp_cond + '.outColorR', ff2_filmAsp_lThan_resAsp_fFONotZero_MD + '.input1X' )
    cmds.connectAttr( ff2_filmOffset_notZero_check_cond + '.outColorR', ff2_filmAsp_lThan_resAsp_fFONotZero_MD + '.input2X' )

    # Create inner conditional block filmAsp < resAsp && filmFitOffset != 0
    # Add conditional composite to represent the .firstTerm
    # Now add offset0 = ( aper1 * resAsp - aper0 ) * filmFitOffset * 0.5 * 2.54
    # As its only output. Its colorIfFalse must be 0 because that is what it
    # would otherwise be by default
    ff2_inner_and_condition_composite_cond = cmds.createNode( 'condition', name='ff2_inner_and_condition_composite_cond' )
    cmds.setAttr( ff2_inner_and_condition_composite_cond + '.operation', 0 )
    cmds.setAttr( ff2_inner_and_condition_composite_cond + '.secondTerm', 1 )
    cmds.setAttr( ff2_inner_and_condition_composite_cond + '.colorIfFalseB', 0 )
    cmds.connectAttr( ff2_filmAsp_lThan_resAsp_fFONotZero_MD + '.outputX', ff2_inner_and_condition_composite_cond + '.firstTerm' )
    cmds.connectAttr( ff2_off0_filmFitOff_composite_half_2point54_mult_MD + '.outputZ', ff2_inner_and_condition_composite_cond + '.colorIfTrueB' )

    # Lastly, regardless of the double conditional succeeding or failing,
    # if Case 2 succeeds, visAper0 = aper1 * resAsp * 25.4
    # This will be connected to the main condition later but initialized now
    ff2_visAper0_aper1_mult_resAsp_MD = cmds.createNode( 'multiplyDivide', name='ff2_visAper0_aper1_mult_resAsp_MDD' )
    cmds.setAttr( ff2_visAper0_aper1_mult_resAsp_MD + '.operation', 1 )
    cmds.connectAttr( aper + '.outColorG', ff2_visAper0_aper1_mult_resAsp_MD + '.input1X' )
    cmds.connectAttr( resAspect + '.outputX', ff2_visAper0_aper1_mult_resAsp_MD + '.input2X' )

    ff2_visAper0_aper1_mult_resAsp_mult_254_MD = cmds.createNode( 'multiplyDivide', name='ff2_visAper0_aper1_mult_resAsp_mult_254_MD' )
    cmds.setAttr( ff2_visAper0_aper1_mult_resAsp_mult_254_MD + '.operation', 1 )
    cmds.setAttr( ff2_visAper0_aper1_mult_resAsp_mult_254_MD + '.input2X', 25.4 )
    cmds.connectAttr( ff2_visAper0_aper1_mult_resAsp_MD + '.outputX', ff2_visAper0_aper1_mult_resAsp_mult_254_MD + '.input1X' )

    # S02d :: Case 3 - filmFit == Overscan
    # The dredded overscan. I ripped my math calculations directly from this
    # script here. Credit goes to him. I still don't exactly understand whyS
    # overscan almost exactly the same as fill and yet the two filmFits
    # produce such different results
    # http://www.creativecrash.com/maya/script/kr_renderoverscan - raffile.k

    # Setting main conditional statement
    ff3_filmAsp_lessThanEq_resAsp_cond = cmds.createNode( 'condition', name='ff3_filmAsp_lessThanEq_resAsp_cond' )
    cmds.setAttr( ff3_filmAsp_lessThanEq_resAsp_cond + '.operation', 5 )
    cmds.setAttr( ff3_filmAsp_lessThanEq_resAsp_cond + '.colorIfTrueB', 0 )
    cmds.setAttr( ff3_filmAsp_lessThanEq_resAsp_cond + '.colorIfFalseB', 0 )
    cmds.connectAttr( filmAspect + '.outputX', ff3_filmAsp_lessThanEq_resAsp_cond + '.firstTerm' )
    cmds.connectAttr( resAspect + '.outputX', ff3_filmAsp_lessThanEq_resAsp_cond + '.secondTerm' )


    # now visAper0 and visAper1
    ff3_visAper0_aper1_mult_resAsp_MD = cmds.createNode( 'multiplyDivide', name='ff3_visAper0_aper1_mult_resAsp_MD' )
    cmds.setAttr( ff3_visAper0_aper1_mult_resAsp_MD + '.operation', 1 )
    cmds.connectAttr( aper + '.outColorG', ff3_visAper0_aper1_mult_resAsp_MD + '.input1X' )
    cmds.connectAttr( resAspect + '.outputX', ff3_visAper0_aper1_mult_resAsp_MD + '.input2X' )

    ff3_visAper0_aper1_mult_resAsp_mult_254_MD = cmds.createNode( 'multiplyDivide', name='ff3_visAper0_aper1_mult_resAsp_mult_254_MD' )
    cmds.setAttr( ff3_visAper0_aper1_mult_resAsp_mult_254_MD + '.operation', 1 )
    cmds.setAttr( ff3_visAper0_aper1_mult_resAsp_mult_254_MD + '.input2X', 25.4 )
    cmds.connectAttr( ff3_visAper0_aper1_mult_resAsp_MD + '.outputX', ff3_visAper0_aper1_mult_resAsp_mult_254_MD + '.input1X' )

    ff3_visAper1_aper0_div_resAsp_MD = cmds.createNode( 'multiplyDivide', name='ff3_visAper1_aper0_div_resAsp_MD' )
    cmds.setAttr( ff3_visAper1_aper0_div_resAsp_MD + '.operation', 2 )
    cmds.connectAttr( aper + '.outColorR', ff3_visAper1_aper0_div_resAsp_MD + '.input1Y' )
    cmds.connectAttr( resAspect + '.outputX', ff3_visAper1_aper0_div_resAsp_MD + '.input2Y' )

    ff3_visAper1_aper0_div_resAsp_mult_254_MD = cmds.createNode( 'multiplyDivide', name='ff3_visAper1_aper0_mult_resAsp_mult_254_MD' )
    cmds.setAttr( ff3_visAper1_aper0_div_resAsp_mult_254_MD + '.operation', 2 )
    cmds.setAttr( ff3_visAper1_aper0_div_resAsp_mult_254_MD + '.input2Y', 25.4 )
    cmds.connectAttr( ff3_visAper1_aper0_div_resAsp_MD + '.outputY', ff3_visAper1_aper0_div_resAsp_mult_254_MD + '.input1Y' )

    # Connecting visAper0 and visAper1 outputs to the main conditional
    # and their ifFalse/ifTrue default counter-parts (very important, as ff3
    # is going to be the last in a 3-conditional chain sequence soon
    cmds.connectAttr( ff3_visAper1_aper0_div_resAsp_mult_254_MD + '.outputY', ff3_filmAsp_lessThanEq_resAsp_cond + '.colorIfFalseG' )
    cmds.connectAttr( ff3_visAper0_aper1_mult_resAsp_mult_254_MD + '.outputX', ff3_filmAsp_lessThanEq_resAsp_cond + '.colorIfTrueR' )
    cmds.connectAttr( visAspect + '.outputX', ff3_filmAsp_lessThanEq_resAsp_cond + '.colorIfFalseR' )
    cmds.connectAttr( visAspect + '.outputY', ff3_filmAsp_lessThanEq_resAsp_cond + '.colorIfTrueG' )

    # S03 :: Combining the Cases
    # There isn't a super clean way to do this in Maya IFAIK but
    # we can route a nested list of outputs through three conditionals to
    # get all four possible cases.
    # 3 conditionals = 3 outColor possibilities + 1 (the last colorIfFalse)
    # Also, I'm going to write the conditionals upstream here - it reads better

    ff2ff3_check_cond = cmds.createNode( 'condition', name='ff2ff3_check_cond' )
    cmds.setAttr( ff2ff3_check_cond + '.operation', 0 )
    cmds.connectAttr( cam_shape + '.filmFit', ff2ff3_check_cond + '.firstTerm' )
    cmds.setAttr( ff2ff3_check_cond + '.secondTerm', 2 )
    cmds.connectAttr( ff3_filmAsp_lessThanEq_resAsp_cond + '.outColor', ff2ff3_check_cond + '.colorIfFalse' )
    cmds.connectAttr( ff2_visAper0_aper1_mult_resAsp_mult_254_MD + '.outputX', ff2ff3_check_cond + '.colorIfTrueR' )
    cmds.connectAttr( visAspect + '.outputY', ff2ff3_check_cond + '.colorIfTrueG' )
    cmds.connectAttr( ff2_inner_and_condition_composite_cond + '.outColorB', ff2ff3_check_cond + '.colorIfTrueB' )

    ff1ff2_check_cond = cmds.createNode( 'condition', name='ff1ff2_check_cond' )
    cmds.setAttr( ff1ff2_check_cond + '.operation', 0 )
    cmds.connectAttr( cam_shape + '.filmFit', ff1ff2_check_cond + '.firstTerm' )
    cmds.setAttr( ff1ff2_check_cond + '.secondTerm', 1 )
    # Notice, each condition will lead into the next's .colorIfFalse
    # This is how you can chain multiple condition statements together
    cmds.connectAttr( ff2ff3_check_cond + '.outColor', ff1ff2_check_cond + '.colorIfFalse' )
    cmds.connectAttr( visAspect + '.outputX', ff1ff2_check_cond + '.colorIfTrueR' )
    cmds.connectAttr( ff1_visAper1_aper0_div_resAsp_mult_254_MD + '.outputY' , ff1ff2_check_cond + '.colorIfTrueG' )
    cmds.connectAttr( ff1_inner_and_condition_composite_cond + '.outColorB' , ff1ff2_check_cond + '.colorIfTrueB' )


    ff0ff1_check_cond = cmds.createNode( 'condition', name='ff0ff1_check_cond' )
    cmds.setAttr( ff0ff1_check_cond + '.operation', 0 )
    cmds.connectAttr( cam_shape + '.filmFit', ff0ff1_check_cond + '.firstTerm' )
    cmds.setAttr( ff0ff1_check_cond + '.secondTerm', 0 )
    cmds.connectAttr( ff1ff2_check_cond + '.outColor', ff0ff1_check_cond + '.colorIfFalse' )
    cmds.connectAttr( ff0_filmAsp_lessThanEq_resAsp_cond + '.outColor', ff0ff1_check_cond + '.colorIfTrue' )

    # S03 :: ViewScale - this setup will give incorrect results if the user applies any preScaling
    # to the camera, which is common to physical setups. Thankfully the implementation is simple
    # you just take the unmodified visAper and divide by 10 to get it in the same unit range as the preScale
    # then divide by preScale. The viewScale will be used in the final vector to get the hFOV/vFOV
    #
    # Remember order of operations from high school math class - Please Excuse My Dear Aunt Sally (PEMDAS)

    # In my original setup the viewScale is split into two node groups. Here I'll try to consolidate it into one
    viewScale_div_10 = cmds.createNode( 'multiplyDivide', name='viewScale_visAper_div_10_MD' )
    cmds.setAttr( viewScale_div_10 + '.operation', 2 )
    cmds.setAttr( viewScale_div_10 + '.input2X', 10 )
    cmds.setAttr( viewScale_div_10 + '.input2Y', 10 )
    cmds.connectAttr( ff0ff1_check_cond + '.outColorR', viewScale_div_10 + '.input1X' )
    cmds.connectAttr( ff0ff1_check_cond + '.outColorG', viewScale_div_10 + '.input1Y' )

    # final pre-scale (divided by 10 and divided by preScale)
    viewScale = cmds.createNode( 'multiplyDivide', name='viewScale_MD' )
    cmds.setAttr( viewScale + '.operation', 2 )
    cmds.connectAttr( viewScale_div_10 + '.outputX', viewScale + '.input1X' )
    cmds.connectAttr( viewScale_div_10 + '.outputY', viewScale + '.input1Y' )
    cmds.connectAttr( cam_shape + '.preScale', viewScale + '.input2X' )
    cmds.connectAttr( cam_shape + '.preScale', viewScale + '.input2Y' )


    # S04 :: ViewTranslate setup - this is to account for any translation offset in the viewport
    # should the user wish to use the offset (digital offset/zoom) that's available to cameras in Maya
    # There also has to be a contingency set up if shake is enabled since shake, too, changes offset values
    #

    # viewT0 and viewT1 - horizOffset multiplied by 2.54 (25.4 / 10)
    viewT_filmOffset_mult_2point54_MD = cmds.createNode( 'multiplyDivide', name='viewT0_filmOffset_mult_2point54_MD' )
    cmds.setAttr( viewT_filmOffset_mult_2point54_MD + '.operation', 1 )
    cmds.setAttr( viewT_filmOffset_mult_2point54_MD + '.input2X', 2.54 )
    cmds.setAttr( viewT_filmOffset_mult_2point54_MD + '.input2Y', 2.54 )
    cmds.connectAttr( cam_shape + '.horizontalFilmOffset', viewT_filmOffset_mult_2point54_MD + '.input1X' )
    cmds.connectAttr( cam_shape + '.verticalFilmOffset', viewT_filmOffset_mult_2point54_MD + '.input1Y' )


    # viewT0  and viewT1 - horizOffset multiplied by 2.54 (25.4 / 10) minus output offset
    viewT_filmOffset_mult_2point54_minus_off_PMA = cmds.createNode( 'plusMinusAverage', name='viewT_filmOffset_mult_2point54_minus_off_PMA' )
    cmds.setAttr( viewT_filmOffset_mult_2point54_minus_off_PMA + '.operation', 2 )
    cmds.connectAttr( viewT_filmOffset_mult_2point54_MD + '.outputX', viewT_filmOffset_mult_2point54_minus_off_PMA + '.input2D[0].input2Dx' )
    cmds.connectAttr( viewT_filmOffset_mult_2point54_MD + '.outputY', viewT_filmOffset_mult_2point54_minus_off_PMA + '.input2D[0].input2Dy' )

    # Now account for if shakeIsEnabled - offset += horizontalShake * 2.54
    viewT_shake_mult_2point54_MD = cmds.createNode( 'multiplyDivide', name='viewT_shake_mult_2point54_MD' )
    cmds.setAttr( viewT_shake_mult_2point54_MD + '.operation', 1 )
    cmds.setAttr( viewT_shake_mult_2point54_MD + '.input2X', 2.54 )
    cmds.setAttr( viewT_shake_mult_2point54_MD + '.input2Y', 2.54 )
    cmds.connectAttr( cam_shape + '.horizontalShake', viewT_shake_mult_2point54_MD + '.input1X' )
    cmds.connectAttr( cam_shape + '.verticalShake', viewT_shake_mult_2point54_MD + '.input2X' )

    # Now account for if shakeIsEnabled - offset += horizontalShake * 2.54 (now at +=)
    viewT_shakeEnabled_PMA = cmds.createNode( 'plusMinusAverage', name='viewT_shakeEnabled_PMA' )
    cmds.setAttr( viewT_shakeEnabled_PMA + '.operation', 1 )
    cmds.connectAttr( viewT_filmOffset_mult_2point54_minus_off_PMA + '.output2Dx', viewT_shakeEnabled_PMA + '.input2D[0].input2Dx' )
    cmds.connectAttr( viewT_filmOffset_mult_2point54_minus_off_PMA + '.output2Dy', viewT_shakeEnabled_PMA + '.input2D[0].input2Dy' )
    cmds.connectAttr( viewT_shake_mult_2point54_MD + '.outputX', viewT_shakeEnabled_PMA + '.input2D[1].input2Dx' )
    cmds.connectAttr( viewT_shake_mult_2point54_MD + '.outputY', viewT_shakeEnabled_PMA + '.input2D[1].input2Dy' )

    # One more thing before we connect for the final output: because ff0ff1_check_cond
    # only outputs one outColorB and I need this to count for two separate values,
    # there needs to be one more layer of conditional statements to figure out if offset0 or offset1 is needed

    # The condition for which offset is either less than or greater than. This condition will handle
    # the less than or greater scenario but there must also be one more condition in case the ratios are equal

    # This condition is essential. The colorIfTrueR and colorIfFalseG are the only actual outputs.
    # By separating the two into different parts of the condition, we can ensure one will be output while the
    # the other will be replaced with a 0. (Hence why colorIfTrueG and colorIfFalseR are actual zeroes
    which_offset_ifFalse_cond = cmds.createNode( 'condition', name='which_offset_ifFalse_cond' )
    cmds.setAttr( which_offset_ifFalse_cond + '.operation', 4 )
    cmds.setAttr( which_offset_ifFalse_cond + '.colorIfTrueG', 0 )
    cmds.setAttr( which_offset_ifFalse_cond + '.colorIfFalseR', 0 )
    cmds.connectAttr( filmAspect + '.outputX', which_offset_ifFalse_cond + '.firstTerm' )
    cmds.connectAttr( resAspect + '.outputX', which_offset_ifFalse_cond + '.secondTerm' )
    cmds.connectAttr( ff0ff1_check_cond + '.outColorB', which_offset_ifFalse_cond + '.colorIfTrueR' )
    cmds.connectAttr( ff0ff1_check_cond + '.outColorB', which_offset_ifFalse_cond + '.colorIfFalseG' )

    # This condition covers if both terms are equal - in which case the offset = 0.
    # Otherwise, if false, it is either less than or greater than
    # This is the final conditional that will feed into viewTranslate0 and 1
    which_offset_cond = cmds.createNode( 'condition', name='which_offset_cond' )
    cmds.setAttr( which_offset_cond + '.operation', 0 )
    cmds.setAttr( which_offset_cond + '.colorIfTrueR', 0 )
    cmds.setAttr( which_offset_cond + '.colorIfTrueG', 0 )
    cmds.connectAttr( which_offset_ifFalse_cond + '.outColorR', which_offset_cond + '.colorIfFalseR' )
    cmds.connectAttr( which_offset_ifFalse_cond + '.outColorG', which_offset_cond + '.colorIfFalseG' )
    cmds.connectAttr( filmAspect + '.outputX', which_offset_cond + '.firstTerm' )
    cmds.connectAttr( resAspect + '.outputX', which_offset_cond + '.secondTerm' )
    # connecting the outColor to the pre-ifShakeEnabled conditional group
    # so that it will be applied regardless of if shake is actually enabled
    cmds.connectAttr( which_offset_cond + '.outColorR', viewT_filmOffset_mult_2point54_minus_off_PMA  + '.input2D[1].input2Dx' )
    cmds.connectAttr( which_offset_cond + '.outColorG', viewT_filmOffset_mult_2point54_minus_off_PMA  + '.input2D[1].input2Dy' )


    # final viewTranslate 0 and 1, if shake is enabled condition.
    # The outColorR/G is viewTranslate0 and viewTranslate1
    viewT_ifShakeEnabled = cmds.createNode( 'condition', name='viewT_ifShakeEnabled' )
    cmds.setAttr( viewT_ifShakeEnabled + '.operation', 0 )
    cmds.setAttr( viewT_ifShakeEnabled + '.secondTerm', 1 )
    cmds.connectAttr( viewT_shakeEnabled_PMA + '.output2Dx', viewT_ifShakeEnabled + '.colorIfTrueR' )
    cmds.connectAttr( viewT_shakeEnabled_PMA + '.output2Dy', viewT_ifShakeEnabled + '.colorIfTrueG' )
    cmds.connectAttr( viewT_filmOffset_mult_2point54_minus_off_PMA + '.output2Dx', viewT_ifShakeEnabled + '.colorIfFalseR' )
    cmds.connectAttr( viewT_filmOffset_mult_2point54_minus_off_PMA + '.output2Dy', viewT_ifShakeEnabled + '.colorIfFalseG' )

    # Finally, viewTranslate2 - which will integrate the cameraScale
    # so that cameraScale will not break the focalLength of the camera
    # this will be used as the final hFOV vector[0] and vFOX vector[1],
    # but with a couple modifications

    viewT2_focal_mult_negPointZero_MD = cmds.createNode( 'multiplyDivide', name='viewT2_focal_mult_negPointZero_MD' )
    cmds.setAttr( viewT2_focal_mult_negPointZero_MD + '.operation', 1 )
    cmds.setAttr( viewT2_focal_mult_negPointZero_MD + '.input2Z', -0.1 )
    cmds.connectAttr( cam_shape + '.focalLength', viewT2_focal_mult_negPointZero_MD + '.input1Z' )

    # This is the viewTranslate2 - the base which will be used for hFOV/vFOV vector[2]
    # focalLength *  -0.1 / cameraScale
    viewT2_MD = cmds.createNode( 'multiplyDivide', name='viewT2_focal_mult_negPointZero_div_camScale_MD' )
    cmds.setAttr( viewT2_MD + '.operation', 2 )
    cmds.connectAttr( viewT2_focal_mult_negPointZero_MD + '.outputZ', viewT2_MD + '.input1Z' )
    cmds.connectAttr( cam_shape + '.cameraScale', viewT2_MD + '.input2Z' )


    # S05 :: hAngle vector and vAngle vector and the some setup
    # The viewScale is a scale attribute (covers a distance in both directions)
    # but the hFOV and vFOV must be output as single angles.
    # To do this, the viewScale is divided by 2 or -2. In this case, 2.
    viewScale_div_2_MD = cmds.createNode( 'multiplyDivide', name='viewScale_div_2_MD' )
    cmds.setAttr( viewScale_div_2_MD + '.operation', 2 )
    cmds.setAttr( viewScale_div_2_MD + '.input2X', 2 )
    cmds.setAttr( viewScale_div_2_MD + '.input2Y', 2 )
    cmds.connectAttr( viewScale + '.outputX', viewScale_div_2_MD + '.input1X' )
    cmds.connectAttr( viewScale + '.outputY', viewScale_div_2_MD + '.input1Y' )

    # The viewScale is a scale attribute (covers a distance in both directions)
    # but the hFOV and vFOV must be output as single angles.
    # To do this, the viewScale is divided by 2 or -2. In this case, 2.
    viewScale_div_neg2_MD = cmds.createNode( 'multiplyDivide', name='viewScale_div_neg2_MD' )
    cmds.setAttr( viewScale_div_neg2_MD + '.operation', 2 )
    cmds.setAttr( viewScale_div_neg2_MD + '.input2X', -2 )
    cmds.setAttr( viewScale_div_neg2_MD + '.input2Y', -2 )
    cmds.connectAttr( viewScale + '.outputX', viewScale_div_neg2_MD + '.input1X' )
    cmds.connectAttr( viewScale + '.outputY', viewScale_div_neg2_MD + '.input1Y' )

    # The script branches here based on us working on either hFOV or vFOV
    # First up is hFOV.
    # Connect up the angleBetween nodes for hFOV
    hAngle = cmds.createNode( 'angleBetween', name='hAngle_angleBetween' )
    cmds.setAttr( hAngle + '.vector1Y', 0 )
    cmds.setAttr( hAngle + '.vector2Y', 0 )
    cmds.connectAttr( viewScale_div_neg2_MD + '.outputX', hAngle + '.vector1X' )
    cmds.connectAttr( viewScale_div_2_MD + '.outputX', hAngle + '.vector2X' )
    cmds.connectAttr( viewT2_MD + '.outputZ', hAngle + '.vector1Z' )
    cmds.connectAttr( viewT2_MD + '.outputZ', hAngle + '.vector2Z' )

    # Connect up the anglebetween node with its dependencies for vFOV
    vAngle = cmds.createNode( 'angleBetween', name='vAngle_angleBetween' )
    cmds.setAttr( vAngle + '.vector1X', 0 )
    cmds.setAttr( vAngle + '.vector2X', 0 )
    cmds.connectAttr( viewScale_div_neg2_MD + '.outputY', vAngle + '.vector1Y' )
    cmds.connectAttr( viewScale_div_2_MD + '.outputY', vAngle + '.vector2Y' )
    cmds.connectAttr( viewT2_MD + '.outputZ', vAngle + '.vector1Z' )
    cmds.connectAttr( viewT2_MD + '.outputZ', vAngle + '.vector2Z' )

    # S06 :: Creating the trig that will give hFOV and vFOV
    # This is the BeeAngle Node used in the trig math
    BeeAngle_MD = cmds.createNode( 'multiplyDivide', name='BeeAngle_MD' )
    cmds.setAttr( BeeAngle_MD + '.operation', 2 )
    cmds.setAttr( BeeAngle_MD + '.input2X', 2 )
    cmds.setAttr( BeeAngle_MD + '.input2Y', 2 )
    cmds.connectAttr( hAngle + '.angle', BeeAngle_MD + '.input1X' )
    cmds.connectAttr( vAngle + '.angle', BeeAngle_MD + '.input1Y' )

    # Get the unitConversion nodes as a variable so we can collapse them into a container later
    hAngle_connections = cmds.listConnections( hAngle )
    vAngle_connections = cmds.listConnections( vAngle )
    #print hAngle_connections[-1]
    #print vAngle_connections[-1]

    # Branching back out to two streams
    AaaAngle_180_minus_Bangle_PMA = cmds.createNode( 'plusMinusAverage', name='AaaAngle_180_minus_Bangle_PMA' )
    cmds.setAttr( AaaAngle_180_minus_Bangle_PMA + '.operation', 2 )
    cmds.setAttr( AaaAngle_180_minus_Bangle_PMA + '.input2D[0].input2Dx', 180 )
    cmds.setAttr( AaaAngle_180_minus_Bangle_PMA + '.input2D[0].input2Dy', 180 )
    cmds.connectAttr( BeeAngle_MD + '.outputX', AaaAngle_180_minus_Bangle_PMA + '.input2D[1].input2Dx' )
    cmds.connectAttr( BeeAngle_MD + '.outputY', AaaAngle_180_minus_Bangle_PMA + '.input2D[1].input2Dy' )

    AaaAngle_180_minus_Bangle_minus_Cangle_PMA = cmds.createNode( 'plusMinusAverage', name='AaaAngle_180_minus_Bangle_minus_Cangle_PMA' )
    cmds.setAttr( AaaAngle_180_minus_Bangle_minus_Cangle_PMA + '.operation', 2 )
    cmds.setAttr( AaaAngle_180_minus_Bangle_minus_Cangle_PMA + '.input2D[1].input2Dx', 90 )
    cmds.setAttr( AaaAngle_180_minus_Bangle_minus_Cangle_PMA + '.input2D[1].input2Dy', 90 )
    cmds.connectAttr( AaaAngle_180_minus_Bangle_PMA + '.output2Dx', AaaAngle_180_minus_Bangle_minus_Cangle_PMA + '.input2D[0].input2Dx' )
    cmds.connectAttr( AaaAngle_180_minus_Bangle_PMA + '.output2Dy', AaaAngle_180_minus_Bangle_minus_Cangle_PMA + '.input2D[0].input2Dy' )

    # Now convert both streams into radians (because I mistakenly make an animCurve for radians
    # instead of just setting values in degrees and I don't want to redo it. Maybe if I ever should
    # go back. AUTHOR NOTE: How to convert these values over?

    sinAPrep_div_180_MD = cmds.createNode( 'multiplyDivide', name='sinAPrep_div_180_MD' )
    cmds.setAttr( sinAPrep_div_180_MD + '.operation', 2 )
    cmds.setAttr( sinAPrep_div_180_MD + '.input2X', 180 )
    cmds.setAttr( sinAPrep_div_180_MD + '.input2Y', 180 )
    cmds.connectAttr( AaaAngle_180_minus_Bangle_minus_Cangle_PMA + '.output2Dx', sinAPrep_div_180_MD + '.input1X' )
    cmds.connectAttr( AaaAngle_180_minus_Bangle_minus_Cangle_PMA + '.output2Dy', sinAPrep_div_180_MD + '.input1Y' )

    sinAPrep_div_180_mult_pi_MD = cmds.createNode( 'multiplyDivide', name='sinAPrep_div_180_mult_pi_MD' )
    cmds.setAttr( sinAPrep_div_180_mult_pi_MD + '.operation', 1 )
    cmds.setAttr( sinAPrep_div_180_mult_pi_MD + '.input2X', 3.14159 )
    cmds.setAttr( sinAPrep_div_180_mult_pi_MD + '.input2Y', 3.14159 )
    cmds.connectAttr( sinAPrep_div_180_MD + '.outputX', sinAPrep_div_180_mult_pi_MD + '.input1X' )
    cmds.connectAttr( sinAPrep_div_180_MD + '.outputY', sinAPrep_div_180_mult_pi_MD + '.input1Y' )

    # The animCurve was scaled by 100 to give a greater length of space over the X axis
    # (time) so that more points on the curve could be placed. The node itself will
    # normalize the value properly so there is no need to convert back down on the opposite end
    # but that is what the mult_100 is for
    sinAPrep_div_180_mult_pi_mult100_MD = cmds.createNode( 'multiplyDivide', name='sinAPrep_div_180_mult_pi_mult100_MD' )
    cmds.setAttr( sinAPrep_div_180_mult_pi_mult100_MD + '.operation', 1 )
    cmds.setAttr( sinAPrep_div_180_mult_pi_mult100_MD + '.input2X', 100 )
    cmds.setAttr( sinAPrep_div_180_mult_pi_mult100_MD + '.input2Y', 100 )
    cmds.connectAttr( sinAPrep_div_180_mult_pi_MD + '.outputX', sinAPrep_div_180_mult_pi_mult100_MD + '.input1X' )
    cmds.connectAttr( sinAPrep_div_180_mult_pi_MD + '.outputY', sinAPrep_div_180_mult_pi_mult100_MD + '.input1Y' )

    # Now to perform the same deg2rad conversion for the sin of B (Basically a copy of sinAPrep but now for sinB
    sinBPrep_div_180_MD = cmds.createNode( 'multiplyDivide', name='sinBPrep_div_180_MD' )
    cmds.setAttr( sinBPrep_div_180_MD + '.operation', 2 )
    cmds.setAttr( sinBPrep_div_180_MD + '.input2X', 180 )
    cmds.setAttr( sinBPrep_div_180_MD + '.input2Y', 180 )
    # Only difference - instead of taking from AaaAngle(180-B), we will take directly from BeeAngle)
    cmds.connectAttr( BeeAngle_MD + '.outputX', sinBPrep_div_180_MD + '.input1X' )
    cmds.connectAttr( BeeAngle_MD + '.outputY', sinBPrep_div_180_MD + '.input1Y' )

    sinBPrep_div_180_mult_pi_MD = cmds.createNode( 'multiplyDivide', name='sinBPrep_div_180_mult_pi_MD' )
    cmds.setAttr( sinBPrep_div_180_mult_pi_MD + '.operation', 1 )
    cmds.setAttr( sinBPrep_div_180_mult_pi_MD + '.input2X', 3.14159 )
    cmds.setAttr( sinBPrep_div_180_mult_pi_MD + '.input2Y', 3.14159 )
    cmds.connectAttr( sinBPrep_div_180_MD + '.outputX', sinBPrep_div_180_mult_pi_MD + '.input1X' )
    cmds.connectAttr( sinBPrep_div_180_MD + '.outputY', sinBPrep_div_180_mult_pi_MD + '.input1Y' )

    # The animCurve was scaled by 100 to give a greater length of space over the X axis
    # (time) so that more points on the curve could be placed. The node itself will
    # normalize the value properly so there is no need to convert back down on the opposite end
    # but that is what the mult_100 is for
    sinBPrep_div_180_mult_pi_mult100_MD = cmds.createNode( 'multiplyDivide', name='sinBPrep_div_180_mult_pi_mult100_MD' )
    cmds.setAttr( sinBPrep_div_180_mult_pi_mult100_MD + '.operation', 1 )
    cmds.setAttr( sinBPrep_div_180_mult_pi_mult100_MD + '.input2X', 100 )
    cmds.setAttr( sinBPrep_div_180_mult_pi_mult100_MD + '.input2Y', 100 )
    cmds.connectAttr( sinBPrep_div_180_mult_pi_MD + '.outputX', sinBPrep_div_180_mult_pi_mult100_MD + '.input1X' )
    cmds.connectAttr( sinBPrep_div_180_mult_pi_MD + '.outputY', sinBPrep_div_180_mult_pi_mult100_MD + '.input1Y' )

    # Now for the actual trig. The function defined above will be generated 4 times
    # so that we can derive the a tangent for hFOV and vFOV
    sinA_animCurveTL = sin100_create()
    sinB_animCurveTL = sin100_create()
    sinAVert_animCurveTL = sin100_create()
    sinBVert_animCurveTL = sin100_create()

    cmds.connectAttr( sinAPrep_div_180_mult_pi_mult100_MD + '.outputX', sinA_animCurveTL + '.input' )
    cmds.connectAttr( sinBPrep_div_180_mult_pi_mult100_MD + '.outputX', sinB_animCurveTL + '.input' )
    cmds.connectAttr( sinAPrep_div_180_mult_pi_mult100_MD + '.outputY', sinAVert_animCurveTL + '.input' )
    cmds.connectAttr( sinBPrep_div_180_mult_pi_mult100_MD + '.outputY', sinBVert_animCurveTL + '.input' )

    # Get unitToTimeConversion nodes so that they can be collapsed into the container later

    sinA_animCurveTL_connections = cmds.listConnections( sinA_animCurveTL )
    sinB_animCurveTL_connections = cmds.listConnections( sinB_animCurveTL )
    sinAVert_animCurveTL_connections = cmds.listConnections( sinAVert_animCurveTL )
    sinBVert_animCurveTL_connections = cmds.listConnections( sinBVert_animCurveTL )
    #print sinA_animCurveTL_connections[0]
    #print sinB_animCurveTL_connections[0]
    #print sinAVert_animCurveTL_connections[0]
    #print sinBVert_animCurveTL_connections[0]

    # S07 :: Take the final trig values and adjust them to the distance of nearClipPlane and farClipPlane
    #        so that they can be visually represented by a cube (the frustum)
    #        Both separated streams come together one last time

    # Setting hFOV and vFOV
    sideBLength_MD = cmds.createNode( 'multiplyDivide', name='sideBLength_sinB_div_sinA_MD' )
    cmds.setAttr( sideBLength_MD + '.operation', 2 )
    # Horizontal
    cmds.connectAttr( sinB_animCurveTL + '.output' , sideBLength_MD + '.input1X' )
    cmds.connectAttr( sinA_animCurveTL + '.output' , sideBLength_MD + '.input2X' )
    # Vertical
    cmds.connectAttr( sinBVert_animCurveTL + '.output' , sideBLength_MD + '.input1Y' )
    cmds.connectAttr( sinAVert_animCurveTL + '.output' , sideBLength_MD + '.input2Y' )

    # Output the resulting trig values to multiply against the nearClipPlane
    sideBLength_MD_nearClip_MD = cmds.createNode( 'multiplyDivide', name='sideBLength_MD_nearClip_MD' )
    cmds.setAttr( sideBLength_MD_nearClip_MD + '.operation', 1 )
    cmds.connectAttr( sideBLength_MD + '.outputX', sideBLength_MD_nearClip_MD + '.input1X' )
    cmds.connectAttr( sideBLength_MD + '.outputY', sideBLength_MD_nearClip_MD + '.input1Y' )
    cmds.connectAttr( cam_shape + '.nearClipPlane', sideBLength_MD_nearClip_MD + '.input2X' )
    cmds.connectAttr( cam_shape + '.nearClipPlane', sideBLength_MD_nearClip_MD + '.input2Y' )

    # Multiply this value by 2
    # This creates the horizontal scale or translate values necessary to actualize the frustum
    # AUTHOR NOTE: If time, go back and see if areas of the math can be optimized to remove this step
    # This is the output values for horizontal/vertical.
    # This is the nearClipPlane's vertical and horizontal scale or translate values
    sideBLength_MD_nearClip_mult_2_MD = cmds.createNode( 'multiplyDivide', name='sideBLength_MD_nearClip_mult_2_MD' )
    cmds.setAttr( sideBLength_MD_nearClip_mult_2_MD + '.operation', 1 )
    cmds.setAttr( sideBLength_MD_nearClip_mult_2_MD + '.input2X', 1 )
    cmds.setAttr( sideBLength_MD_nearClip_mult_2_MD + '.input2Y', 1 )
    cmds.connectAttr( sideBLength_MD_nearClip_MD + '.outputX', sideBLength_MD_nearClip_mult_2_MD + '.input1X' )
    cmds.connectAttr( sideBLength_MD_nearClip_MD + '.outputY', sideBLength_MD_nearClip_mult_2_MD + '.input1Y' )

    # Output the resulting trig values to multiply against the farClipPlane now.
    sideBLength_MD_farClip_MD = cmds.createNode( 'multiplyDivide', name='sideBLength_MD_farClip_MD' )
    cmds.setAttr( sideBLength_MD_farClip_MD + '.operation', 1 )
    cmds.connectAttr( sideBLength_MD + '.outputX', sideBLength_MD_farClip_MD + '.input1X' )
    cmds.connectAttr( sideBLength_MD + '.outputY', sideBLength_MD_farClip_MD + '.input1Y' )
    cmds.connectAttr( cam_shape + '.farClipPlane', sideBLength_MD_farClip_MD + '.input2X' )
    cmds.connectAttr( cam_shape + '.farClipPlane', sideBLength_MD_farClip_MD + '.input2Y' )

    # Multiply this value by 2
    # This creates the horizontal scale or translate values necessary to actualize the frustum
    # AUTHOR NOTE: If time, go back and see if areas of the math can be optimized to remove this step
    # This is the output values for horizontal/vertical.
    # This is the farClipPlane's vertical and horizontal scale or translate values
    sideBLength_MD_farClip_mult_2_MD = cmds.createNode( 'multiplyDivide', name='sideBLength_MD_farClip_mult_2_MD' )
    cmds.setAttr( sideBLength_MD_farClip_mult_2_MD + '.operation', 1 )
    cmds.setAttr( sideBLength_MD_farClip_mult_2_MD + '.input2X', 1 )
    cmds.setAttr( sideBLength_MD_farClip_mult_2_MD + '.input2Y', 1 )
    cmds.connectAttr( sideBLength_MD_farClip_MD + '.outputX', sideBLength_MD_farClip_mult_2_MD + '.input1X' )
    cmds.connectAttr( sideBLength_MD_farClip_MD + '.outputY', sideBLength_MD_farClip_mult_2_MD + '.input1Y' )

    # S08a :: The FrustumCTL - Frustum Cube - basic creation
    # Create the cube controller and make sure it does not show up in render or take lighting calculations
    # Give it a basic semi-transparent shader and give user controls over its transparency. Off/Wire/Dim/Full

    frustumCube_outline = cmds.polyCube( constructionHistory=False, object=True, createUVs=0, name='frustumCube_outline_01' )
    frustumCube_outline_shape = cmds.listRelatives( shapes=True, fullPath=True )

    frustumCube_outline_pointConst = cmds.pointConstraint( cam_trans, frustumCube_outline )
    frustumCube_outline_orientConst = cmds.orientConstraint( cam_trans, frustumCube_outline )


    # rendering and selection preferences for the cubes
    cmds.setAttr( frustumCube_outline[0] + '.overrideEnabled', 1 )
    cmds.setAttr( frustumCube_outline[0] + '.overrideDisplayType', 2 )
    cmds.setAttr( frustumCube_outline[0] + '.overrideShading', 0 )
    cmds.setAttr( frustumCube_outline[0] + '.overrideTexturing', 0 )
    cmds.setAttr( frustumCube_outline[0] + '.overridePlayback', 1 )
    cmds.setAttr( frustumCube_outline[0] + '.overrideColor', 1 )
    #cmds.parent( frustumCube_outline[0], cam_trans )
    #cmds.setAttr( frustumCube_outline[0] + '.translate', 0,0,0 )
    #cmds.setAttr( frustumCube_outline[0] + '.rotate', 0,0,0 )

    cmds.setAttr( frustumCube_outline_shape[0] + '.castsShadows', 0 )
    cmds.setAttr( frustumCube_outline_shape[0] + '.receiveShadows', 0 )
    cmds.setAttr( frustumCube_outline_shape[0] + '.motionBlur', 0 )
    cmds.setAttr( frustumCube_outline_shape[0] + '.primaryVisibility', 0 )
    cmds.setAttr( frustumCube_outline_shape[0] + '.smoothShading', 0 )
    cmds.setAttr( frustumCube_outline_shape[0] + '.visibleInReflections', 0 )
    cmds.setAttr( frustumCube_outline_shape[0] + '.visibleInRefractions', 0 )
    cmds.setAttr( frustumCube_outline_shape[0] + '.doubleSided', 0 )

    cmds.setAttr( frustumCube_outline[0] + '.tx', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube_outline[0] + '.ty', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube_outline[0] + '.tz', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube_outline[0] + '.rx', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube_outline[0] + '.ry', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube_outline[0] + '.rz', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube_outline[0] + '.sx', keyable=False, channelBox=False )
    cmds.setAttr( frustumCube_outline[0] + '.sy', keyable=False, channelBox=False )
    cmds.setAttr( frustumCube_outline[0] + '.sz', keyable=False, channelBox=False )
    cmds.setAttr( frustumCube_outline[0] + '.v', keyable=False, channelBox=False )

    # We need to scale the cube
    # so that it will give an accurate representation
    # of the frustum even if the camera is scaled later
    frustum_inverse_scale_MD = cmds.createNode( 'multiplyDivide', name='frustum_inverse_scale_MD' )
    cmds.setAttr( frustum_inverse_scale_MD + '.operation', 2 )
    cmds.setAttr( frustum_inverse_scale_MD + '.input1', 1,1,1 )
    cmds.connectAttr( cam_trans + '.scale', frustum_inverse_scale_MD + '.input2' )

    # Because the frustum is parented underneath the camera, the frustum's scale
    # must always be positive. If the camera becomes negative, the frustum will
    # face the wrong direction if any of its scale attributes are negative.
    #
    # To do this, we must create 3 distanceBetween nodes - Maya's equivalent to an abs() function
    frustum_inverse_scale_abs_x = cmds.createNode( 'distanceBetween', name='frustum_inverse_scale_abs_x' )
    frustum_inverse_scale_abs_y = cmds.createNode( 'distanceBetween', name='frustum_inverse_scale_abs_y' )
    frustum_inverse_scale_abs_z = cmds.createNode( 'distanceBetween', name='frustum_inverse_scale_abs_z' )
    cmds.connectAttr( frustum_inverse_scale_MD + '.outputX', frustum_inverse_scale_abs_x + '.point1X' )
    cmds.connectAttr( frustum_inverse_scale_MD + '.outputY', frustum_inverse_scale_abs_y + '.point1Y' )
    cmds.connectAttr( frustum_inverse_scale_MD + '.outputZ', frustum_inverse_scale_abs_z + '.point1Z' )
    cmds.connectAttr( frustum_inverse_scale_abs_x + '.distance', frustumCube_outline[0] + '.scaleX' )
    cmds.connectAttr( frustum_inverse_scale_abs_y + '.distance', frustumCube_outline[0] + '.scaleY' )
    cmds.connectAttr( frustum_inverse_scale_abs_z + '.distance', frustumCube_outline[0] + '.scaleZ' )


    #This second cube will be the colored area within the black outline
    # The "green shader - black outline look" is inspired by djx's djDOF shader
    frustumCube01 = cmds.polyCube( constructionHistory=False, object=True, createUVs=0, name='frustumCube_a_01' )
    frustumCube01_shape = cmds.listRelatives( shapes=True )
    #cmds.parent( frustumCube01_shape[0], frustumCube_outline[0], shape=True )
    frustumCube_pointConst = cmds.pointConstraint( frustumCube_outline[0], frustumCube01 )
    frustumCube_orientConst = cmds.orientConstraint( frustumCube_outline[0], frustumCube01 )


    #cmds.setAttr( frustumCube01 + '.translate', 0,0,0 )
    #cmds.setAttr( frustumCube01 + '.rotate', 0,0,0 )

    cmds.setAttr( frustumCube01_shape[0] + '.overrideEnabled', 1 )
    cmds.setAttr( frustumCube01_shape[0] + '.overrideDisplayType', 2 )
    cmds.setAttr( frustumCube01_shape[0] + '.overrideTexturing', 0 )
    cmds.setAttr( frustumCube01_shape[0] + '.overridePlayback', 0 )


    cmds.setAttr( frustumCube01_shape[0] + '.castsShadows', 0 )
    cmds.setAttr( frustumCube01_shape[0] + '.receiveShadows', 0 )
    cmds.setAttr( frustumCube01_shape[0] + '.motionBlur', 0 )
    cmds.setAttr( frustumCube01_shape[0] + '.primaryVisibility', 0 )
    cmds.setAttr( frustumCube01_shape[0] + '.smoothShading', 0 )
    cmds.setAttr( frustumCube01_shape[0] + '.visibleInReflections', 0 )
    cmds.setAttr( frustumCube01_shape[0] + '.visibleInRefractions', 0 )
    cmds.setAttr( frustumCube01_shape[0] + '.doubleSided', 0 )

    cmds.setAttr( frustumCube01[0] + '.tx', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube01[0] + '.ty', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube01[0] + '.tz', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube01[0] + '.rx', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube01[0] + '.ry', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube01[0] + '.rz', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube01[0] + '.sx', keyable=False, channelBox=False )
    cmds.setAttr( frustumCube01[0] + '.sy', keyable=False, channelBox=False )
    cmds.setAttr( frustumCube01[0] + '.sz', keyable=False, channelBox=False )
    cmds.setAttr( frustumCube01[0] + '.v', keyable=False, channelBox=False )

    # Now an exact duplicate cube will be made. This is to implement the "full" visiblity display
    frustumCube02 = cmds.polyCube( constructionHistory=False, object=True, createUVs=0, name='frustumCube_b_01' )
    frustumCube02_shape = cmds.listRelatives( shapes=True )
    #cmds.parent( frustumCube02_shape[0], frustumCube_outline[0], shape=True )
    frustumCube_pointConst = cmds.pointConstraint( frustumCube_outline[0], frustumCube02 )
    frustumCube_orientConst = cmds.orientConstraint( frustumCube_outline[0], frustumCube02 )

    #cmds.setAttr( frustumCube01 + '.translate', 0,0,0 )
    #cmds.setAttr( frustumCube01 + '.rotate', 0,0,0 )

    cmds.setAttr( frustumCube02_shape[0] + '.overrideEnabled', 1 )
    cmds.setAttr( frustumCube02_shape[0] + '.overrideDisplayType', 2 )
    cmds.setAttr( frustumCube02_shape[0] + '.overrideTexturing', 0 )
    cmds.setAttr( frustumCube02_shape[0] + '.overridePlayback', 0 )


    cmds.setAttr( frustumCube02_shape[0] + '.castsShadows', 0 )
    cmds.setAttr( frustumCube02_shape[0] + '.receiveShadows', 0 )
    cmds.setAttr( frustumCube02_shape[0] + '.motionBlur', 0 )
    cmds.setAttr( frustumCube02_shape[0] + '.primaryVisibility', 0 )
    cmds.setAttr( frustumCube02_shape[0] + '.smoothShading', 0 )
    cmds.setAttr( frustumCube02_shape[0] + '.visibleInReflections', 0 )
    cmds.setAttr( frustumCube02_shape[0] + '.visibleInRefractions', 0 )
    cmds.setAttr( frustumCube02_shape[0] + '.doubleSided', 0 )

    cmds.setAttr( frustumCube02[0] + '.tx', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube02[0] + '.ty', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube02[0] + '.tz', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube02[0] + '.rx', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube02[0] + '.ry', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube02[0] + '.rz', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( frustumCube02[0] + '.sx', keyable=False, channelBox=False )
    cmds.setAttr( frustumCube02[0] + '.sy', keyable=False, channelBox=False )
    cmds.setAttr( frustumCube02[0] + '.sz', keyable=False, channelBox=False )
    cmds.setAttr( frustumCube02[0] + '.v', keyable=False, channelBox=False )




    # Lambert Shader for frustumCube01
    frustumCube_a_lamb = cmds.shadingNode( 'lambert', asShader=True, name='frustumCube_a_lamb' )
    cmds.setAttr( frustumCube_a_lamb + '.color', 0,0,0, type='double3' )
    cmds.setAttr( frustumCube_a_lamb + '.transparency', 0.85,0.85,0.85, type='double3' )
    cmds.setAttr( frustumCube_a_lamb + '.ambientColor', 0,0,0, type='double3' )
    cmds.setAttr( frustumCube_a_lamb + '.incandescence', 0.0,0.06,0.01, type='double3' )
    cmds.setAttr( frustumCube_a_lamb + '.diffuse', 0 )
    cmds.setAttr( frustumCube_a_lamb + '.translucence', 0 )
    cmds.setAttr( frustumCube_a_lamb + '.translucenceDepth', 0 )
    cmds.setAttr( frustumCube_a_lamb + '.translucenceFocus', 0 )
    frustumCube_a_lambSG = cmds.sets( renderable=True, empty=True, name='frustumCube_a_lambSG' );
    cmds.connectAttr( frustumCube_a_lamb + ".outColor", frustumCube_a_lambSG + ".surfaceShader", force=True)
    cmds.select( frustumCube01 )
    cmds.sets( e=True, forceElement=frustumCube_a_lambSG )

    # Lambert Shader for frustumCube02
    frustumCube_b_lamb = cmds.shadingNode( 'lambert', asShader=True, name='frustumCube_b_lamb' )
    cmds.setAttr( frustumCube_b_lamb + '.color', 0,0,0, type='double3' )
    cmds.setAttr( frustumCube_b_lamb + '.transparency', 0.5,0.5,0.5, type='double3' )
    cmds.setAttr( frustumCube_b_lamb + '.ambientColor', 0,0,0, type='double3' )
    cmds.setAttr( frustumCube_b_lamb + '.incandescence', 0.0,0.04,0.006, type='double3' )
    cmds.setAttr( frustumCube_b_lamb + '.diffuse', 0 )
    cmds.setAttr( frustumCube_b_lamb + '.translucence', 0 )
    cmds.setAttr( frustumCube_b_lamb + '.translucenceDepth', 0 )
    cmds.setAttr( frustumCube_b_lamb + '.translucenceFocus', 0 )

    #frustumCube_surf = cmds.shadingNode( 'surfaceShader', asShader=True, name='frustumCube_surf')
    #cmds.setAttr( frustumCube_surf + ".outColor", 0.03, 0.09, 0, type='double3' )
    #cmds.setAttr( frustumCube_surf + ".outTransparency", 0.9, 0.9, 0.9, type='double3' )
    frustumCube_b_lambSG = cmds.sets( renderable=True, empty=True, name='frustumCube_b_lambSG' );
    cmds.connectAttr( frustumCube_b_lamb + ".outColor", frustumCube_b_lambSG + ".surfaceShader", force=True)
    cmds.select( frustumCube02 )
    cmds.sets( e=True, forceElement=frustumCube_b_lambSG )

    # Add camera controls for the frustum - its visibility and shader color/transparency
    if cmds.objExists(camTrans + '.frustumVisibility')==1:
        cmds.setAttr( camTrans + '.frustumVisibility', keyable=True )
        cmds.setAttr( camTrans + '.frustumVisibility', 2 )
    else:
        cmds.addAttr( camTrans, ln="frustumVisibility", nn="Frustum Visibility", at="enum", en="Off:Outline:Dim:Full:" )
        cmds.setAttr( camTrans + '.frustumVisibility', keyable=True )
        cmds.setAttr( camTrans + '.frustumVisibility', 2 )

    frustumCube_outline_visiblity_cond = cmds.createNode( 'condition', name='frustumCube_outline_visiblity_cond' )
    cmds.setAttr( frustumCube_outline_visiblity_cond + '.operation', 3 )
    cmds.setAttr( frustumCube_outline_visiblity_cond + '.secondTerm', 1 )
    cmds.setAttr( frustumCube_outline_visiblity_cond + '.colorIfTrueR', 1 )
    cmds.setAttr( frustumCube_outline_visiblity_cond + '.colorIfFalseR', 0 )
    cmds.connectAttr( cam_trans + '.frustumVisibility', frustumCube_outline_visiblity_cond + '.firstTerm' )
    cmds.connectAttr( frustumCube_outline_visiblity_cond + '.outColorR', frustumCube_outline[0] + '.visibility' )

    frustumCube01_visiblity_cond = cmds.createNode( 'condition', name='frustumCube01_visiblity_cond' )
    cmds.setAttr( frustumCube01_visiblity_cond + '.operation', 3 )
    cmds.setAttr( frustumCube01_visiblity_cond + '.secondTerm', 2 )
    cmds.setAttr( frustumCube01_visiblity_cond + '.colorIfTrueR', 1 )
    cmds.setAttr( frustumCube01_visiblity_cond + '.colorIfFalseR', 0 )
    cmds.connectAttr( cam_trans + '.frustumVisibility', frustumCube01_visiblity_cond + '.firstTerm' )
    cmds.connectAttr( frustumCube01_visiblity_cond + '.outColorR', frustumCube01[0] + '.visibility' )

    frustumCube02_visiblity_cond = cmds.createNode( 'condition', name='frustumCube02_visiblity_cond' )
    cmds.setAttr( frustumCube02_visiblity_cond + '.operation', 3 )
    cmds.setAttr( frustumCube02_visiblity_cond + '.secondTerm', 3 )
    cmds.setAttr( frustumCube02_visiblity_cond + '.colorIfTrueR', 1 )
    cmds.setAttr( frustumCube02_visiblity_cond + '.colorIfFalseR', 0 )
    cmds.connectAttr( cam_trans + '.frustumVisibility', frustumCube02_visiblity_cond + '.firstTerm' )
    cmds.connectAttr( frustumCube02_visiblity_cond + '.outColorR', frustumCube02[0] + '.visibility' )

    # S08b :: frustumCube_outline - preparing negative scale/translate sideBLengths
    #
    # In order to correctly connect the near clip and far clip planes
    # negative versions of each hFOV and vFOV and clipPlanes must first be created
    # some vertices will need fully positive values. Others will need fully
    # negative values. And others will need some combinatoin of the two!
    sideBLength_MD_nearClip_mult_neg2_MD = cmds.createNode( 'multiplyDivide', name='sideBLength_MD_nearClip_mult_neg2_MD' )
    cmds.setAttr( sideBLength_MD_nearClip_mult_neg2_MD + '.operation', 1 )
    cmds.setAttr( sideBLength_MD_nearClip_mult_neg2_MD + '.input2X', -1 )
    cmds.setAttr( sideBLength_MD_nearClip_mult_neg2_MD + '.input2Y', -1 )
    cmds.connectAttr( sideBLength_MD_nearClip_MD + '.outputX', sideBLength_MD_nearClip_mult_neg2_MD + '.input1X' )
    cmds.connectAttr( sideBLength_MD_nearClip_MD + '.outputY', sideBLength_MD_nearClip_mult_neg2_MD + '.input1Y' )

    sideBLength_MD_farClip_mult_neg2_MD = cmds.createNode( 'multiplyDivide', name='sideBLength_MD_farClip_mult_neg2_MD' )
    cmds.setAttr( sideBLength_MD_farClip_mult_neg2_MD + '.operation', 1 )
    cmds.setAttr( sideBLength_MD_farClip_mult_neg2_MD + '.input2X', -1 )
    cmds.setAttr( sideBLength_MD_farClip_mult_neg2_MD + '.input2Y', -1 )
    cmds.connectAttr( sideBLength_MD_farClip_MD + '.outputX', sideBLength_MD_farClip_mult_neg2_MD + '.input1X' )
    cmds.connectAttr( sideBLength_MD_farClip_MD + '.outputY', sideBLength_MD_farClip_mult_neg2_MD + '.input1Y' )

    clipPlaneNeg_MD = cmds.createNode( 'multiplyDivide', name='clipPlaneNeg_MD' )
    cmds.setAttr( clipPlaneNeg_MD + '.operation', 1 )
    cmds.setAttr( clipPlaneNeg_MD + '.input2X', -1 )
    cmds.setAttr( clipPlaneNeg_MD + '.input2Y', -1 )
    cmds.connectAttr( cam_shape + '.nearClipPlane', clipPlaneNeg_MD + '.input1X' )
    cmds.connectAttr( cam_shape + '.farClipPlane', clipPlaneNeg_MD + '.input1Y' )

    clipPlaneNeg_point5_offset_PMA = cmds.createNode( 'plusMinusAverage', name='clipPlaneNeg_point5_offset_PMA' )
    cmds.setAttr( clipPlaneNeg_point5_offset_PMA + '.operation', 1 )
    cmds.setAttr( clipPlaneNeg_point5_offset_PMA + '.input2D[1].input2Dx', -0.5 )
    cmds.setAttr( clipPlaneNeg_point5_offset_PMA + '.input2D[1].input2Dy', 0.5 )
    cmds.connectAttr( clipPlaneNeg_MD + '.outputX',clipPlaneNeg_point5_offset_PMA + '.input2D[0].input2Dx' )
    cmds.connectAttr( clipPlaneNeg_MD + '.outputY',clipPlaneNeg_point5_offset_PMA + '.input2D[0].input2Dy' )


    # S08c :: Subtracting the original polyCube's +-0.5 local vertex points
    #
    # Since a polyCube is exactly 1 un x 1 un x 1 un at spawn
    # all the calculations will be off by 1 unit in every direction
    # unless an offset is applied to both sides of the cube (0.5/-0.5)
    # From there, every value must either stay clean or reflect ( * -1 )
    # First comes the nearClipPlane. If I did the farClipPlane, the normals
    # of the cube would be flipped inside out because of how Maya priorities vertex numbers
    #
    # All that's left is to add these offsets back into each vert's corresponding sideBLength
    nearClip_pnt0_PMA = cmds.createNode( 'plusMinusAverage', name='nearClip_pnt0_PMA' )
    cmds.setAttr( nearClip_pnt0_PMA + '.operation', 2 )
    cmds.setAttr( nearClip_pnt0_PMA + '.input2D[1].input2Dx', -0.5 )
    cmds.setAttr( nearClip_pnt0_PMA + '.input2D[1].input2Dy', -0.5 )
    cmds.connectAttr( sideBLength_MD_nearClip_mult_neg2_MD + '.outputX', nearClip_pnt0_PMA + '.input2D[0].input2Dx' )
    cmds.connectAttr( sideBLength_MD_nearClip_mult_neg2_MD + '.outputY', nearClip_pnt0_PMA + '.input2D[0].input2Dy' )

    nearClip_pnt1_PMA = cmds.createNode( 'plusMinusAverage', name='nearClip_pnt1_PMA' )
    cmds.setAttr( nearClip_pnt1_PMA + '.operation', 2 )
    cmds.setAttr( nearClip_pnt1_PMA + '.input3D[1].input3Dx', 0.5 )
    cmds.setAttr( nearClip_pnt1_PMA + '.input3D[1].input3Dy', -0.5 )
    cmds.connectAttr( cam_shape + '.nearClipPlane', nearClip_pnt1_PMA + '.input3D[1].input3Dz' )
    cmds.connectAttr( sideBLength_MD_nearClip_mult_2_MD + '.outputX', nearClip_pnt1_PMA + '.input3D[0].input3Dx' )
    cmds.connectAttr( sideBLength_MD_nearClip_mult_neg2_MD + '.outputY', nearClip_pnt1_PMA + '.input3D[0].input3Dy' )

    nearClip_pnt2_PMA = cmds.createNode( 'plusMinusAverage', name='nearClip_pnt2_PMA' )
    cmds.setAttr( nearClip_pnt2_PMA + '.operation', 2 )
    cmds.setAttr( nearClip_pnt2_PMA + '.input3D[1].input3Dx', -0.5 )
    cmds.setAttr( nearClip_pnt2_PMA + '.input3D[1].input3Dy', 0.5 )
    cmds.connectAttr( cam_shape + '.nearClipPlane', nearClip_pnt2_PMA + '.input3D[1].input3Dz' )
    cmds.connectAttr( sideBLength_MD_nearClip_mult_neg2_MD + '.outputX', nearClip_pnt2_PMA + '.input3D[0].input3Dx' )
    cmds.connectAttr( sideBLength_MD_nearClip_mult_2_MD + '.outputY', nearClip_pnt2_PMA + '.input3D[0].input3Dy' )

    nearClip_pnt3_PMA = cmds.createNode( 'plusMinusAverage', name='nearClip_pnt3_PMA' )
    cmds.setAttr( nearClip_pnt3_PMA + '.operation', 2 )
    cmds.setAttr( nearClip_pnt3_PMA + '.input3D[1].input3Dx', 0.5 )
    cmds.setAttr( nearClip_pnt3_PMA + '.input3D[1].input3Dy', 0.5 )
    cmds.connectAttr( cam_shape + '.nearClipPlane', nearClip_pnt3_PMA + '.input3D[1].input3Dz' )
    cmds.connectAttr( sideBLength_MD_nearClip_mult_2_MD + '.outputX', nearClip_pnt3_PMA + '.input3D[0].input3Dx' )
    cmds.connectAttr( sideBLength_MD_nearClip_mult_2_MD + '.outputY', nearClip_pnt3_PMA + '.input3D[0].input3Dy' )



    # Now that the nearClipPlane is done, all that is left is the farClipPlane
    farClip_pnt4_PMA = cmds.createNode( 'plusMinusAverage', name='farClip_pnt4_PMA' )
    cmds.setAttr( farClip_pnt4_PMA + '.operation', 2 )
    cmds.setAttr( farClip_pnt4_PMA + '.input2D[1].input2Dx', -0.5 )
    cmds.setAttr( farClip_pnt4_PMA + '.input2D[1].input2Dy', 0.5 )
    cmds.connectAttr( sideBLength_MD_farClip_mult_neg2_MD + '.outputX', farClip_pnt4_PMA + '.input2D[0].input2Dx' )
    cmds.connectAttr( sideBLength_MD_farClip_mult_2_MD + '.outputY', farClip_pnt4_PMA + '.input2D[0].input2Dy' )

    farClip_pnt5_PMA = cmds.createNode( 'plusMinusAverage', name='farClip_pnt5_PMA' )
    cmds.setAttr( farClip_pnt5_PMA + '.operation', 2 )
    cmds.setAttr( farClip_pnt5_PMA + '.input3D[1].input3Dx', 0.5 )
    cmds.setAttr( farClip_pnt5_PMA + '.input3D[1].input3Dy', 0.5 )
    cmds.connectAttr( sideBLength_MD_farClip_mult_2_MD + '.outputX', farClip_pnt5_PMA + '.input3D[0].input3Dx' )
    cmds.connectAttr( sideBLength_MD_farClip_mult_2_MD + '.outputY', farClip_pnt5_PMA + '.input3D[0].input3Dy' )

    farClip_pnt6_PMA = cmds.createNode( 'plusMinusAverage', name='farClip_pnt6_PMA' )
    cmds.setAttr( farClip_pnt6_PMA + '.operation', 2 )
    cmds.setAttr( farClip_pnt6_PMA + '.input3D[1].input3Dx', -0.5 )
    cmds.setAttr( farClip_pnt6_PMA + '.input3D[1].input3Dy', -0.5 )
    cmds.connectAttr( sideBLength_MD_farClip_mult_neg2_MD + '.outputX', farClip_pnt6_PMA + '.input3D[0].input3Dx' )
    cmds.connectAttr( sideBLength_MD_farClip_mult_neg2_MD + '.outputY', farClip_pnt6_PMA + '.input3D[0].input3Dy' )

    farClip_pnt7_PMA = cmds.createNode( 'plusMinusAverage', name='farClip_pnt7_PMA' )
    cmds.setAttr( farClip_pnt7_PMA + '.operation', 2 )
    cmds.setAttr( farClip_pnt7_PMA + '.input3D[1].input3Dx', 0.5 )
    cmds.setAttr( farClip_pnt7_PMA + '.input3D[1].input3Dy', -0.5 )
    cmds.connectAttr( sideBLength_MD_farClip_mult_2_MD + '.outputX', farClip_pnt7_PMA + '.input3D[0].input3Dx' )
    cmds.connectAttr( sideBLength_MD_farClip_mult_neg2_MD + '.outputY', farClip_pnt7_PMA + '.input3D[0].input3Dy' )


    # S09 :: Connect the final PMAs to the actual frustumCube_outline
    cmds.connectAttr( nearClip_pnt0_PMA + '.output2Dx', frustumCube_outline_shape[0] + '.pnts[0].pntx' )
    cmds.connectAttr( nearClip_pnt0_PMA + '.output2Dy', frustumCube_outline_shape[0] + '.pnts[0].pnty' )
    cmds.connectAttr( clipPlaneNeg_point5_offset_PMA + '.output2Dx', frustumCube_outline_shape[0] + '.pnts[0].pntz' )
    cmds.connectAttr( nearClip_pnt1_PMA + '.output3Dx', frustumCube_outline_shape[0] + '.pnts[1].pntx' )
    cmds.connectAttr( nearClip_pnt1_PMA + '.output3Dy', frustumCube_outline_shape[0] + '.pnts[1].pnty' )
    cmds.connectAttr( clipPlaneNeg_point5_offset_PMA + '.output2Dx', frustumCube_outline_shape[0] + '.pnts[1].pntz' )
    cmds.connectAttr( nearClip_pnt2_PMA + '.output3Dx', frustumCube_outline_shape[0] + '.pnts[2].pntx' )
    cmds.connectAttr( nearClip_pnt2_PMA + '.output3Dy', frustumCube_outline_shape[0] + '.pnts[2].pnty' )
    cmds.connectAttr( clipPlaneNeg_point5_offset_PMA + '.output2Dx', frustumCube_outline_shape[0] + '.pnts[2].pntz' )
    cmds.connectAttr( nearClip_pnt3_PMA + '.output3Dx', frustumCube_outline_shape[0] + '.pnts[3].pntx' )
    cmds.connectAttr( nearClip_pnt3_PMA + '.output3Dy', frustumCube_outline_shape[0] + '.pnts[3].pnty' )
    cmds.connectAttr( clipPlaneNeg_point5_offset_PMA + '.output2Dx', frustumCube_outline_shape[0] + '.pnts[3].pntz' )

    cmds.connectAttr( farClip_pnt4_PMA + '.output2Dx', frustumCube_outline_shape[0] + '.pnts[4].pntx' )
    cmds.connectAttr( farClip_pnt4_PMA + '.output2Dy', frustumCube_outline_shape[0] + '.pnts[4].pnty' )
    cmds.connectAttr( clipPlaneNeg_point5_offset_PMA + '.output2Dy', frustumCube_outline_shape[0] + '.pnts[4].pntz' )
    cmds.connectAttr( farClip_pnt5_PMA + '.output3Dx', frustumCube_outline_shape[0] + '.pnts[5].pntx' )
    cmds.connectAttr( farClip_pnt5_PMA + '.output3Dy', frustumCube_outline_shape[0] + '.pnts[5].pnty' )
    cmds.connectAttr( clipPlaneNeg_point5_offset_PMA + '.output2Dy', frustumCube_outline_shape[0] + '.pnts[5].pntz' )
    cmds.connectAttr( farClip_pnt6_PMA + '.output3Dx', frustumCube_outline_shape[0] + '.pnts[6].pntx' )
    cmds.connectAttr( farClip_pnt6_PMA + '.output3Dy', frustumCube_outline_shape[0] + '.pnts[6].pnty' )
    cmds.connectAttr( clipPlaneNeg_point5_offset_PMA + '.output2Dy', frustumCube_outline_shape[0] + '.pnts[6].pntz' )
    cmds.connectAttr( farClip_pnt7_PMA + '.output3Dx', frustumCube_outline_shape[0] + '.pnts[7].pntx' )
    cmds.connectAttr( farClip_pnt7_PMA + '.output3Dy', frustumCube_outline_shape[0] + '.pnts[7].pnty' )
    cmds.connectAttr( clipPlaneNeg_point5_offset_PMA + '.output2Dy', frustumCube_outline_shape[0] + '.pnts[7].pntz' )

    # Set the outline to just be the output of the other two cubes to simplify connections
    cmds.connectAttr( frustumCube_outline_shape[0] + '.pnts[0]', frustumCube01_shape[0] + '.pnts[0]' )
    cmds.connectAttr( frustumCube_outline_shape[0] + '.pnts[1]', frustumCube01_shape[0] + '.pnts[1]' )
    cmds.connectAttr( frustumCube_outline_shape[0] + '.pnts[2]', frustumCube01_shape[0] + '.pnts[2]' )
    cmds.connectAttr( frustumCube_outline_shape[0] + '.pnts[3]', frustumCube01_shape[0] + '.pnts[3]' )
    cmds.connectAttr( frustumCube_outline_shape[0] + '.pnts[4]', frustumCube01_shape[0] + '.pnts[4]' )
    cmds.connectAttr( frustumCube_outline_shape[0] + '.pnts[5]', frustumCube01_shape[0] + '.pnts[5]' )
    cmds.connectAttr( frustumCube_outline_shape[0] + '.pnts[6]', frustumCube01_shape[0] + '.pnts[6]' )
    cmds.connectAttr( frustumCube_outline_shape[0] + '.pnts[7]', frustumCube01_shape[0] + '.pnts[7]' )

    cmds.connectAttr( frustumCube_outline_shape[0] + '.pnts[0]', frustumCube02_shape[0] + '.pnts[0]' )
    cmds.connectAttr( frustumCube_outline_shape[0] + '.pnts[1]', frustumCube02_shape[0] + '.pnts[1]' )
    cmds.connectAttr( frustumCube_outline_shape[0] + '.pnts[2]', frustumCube02_shape[0] + '.pnts[2]' )
    cmds.connectAttr( frustumCube_outline_shape[0] + '.pnts[3]', frustumCube02_shape[0] + '.pnts[3]' )
    cmds.connectAttr( frustumCube_outline_shape[0] + '.pnts[4]', frustumCube02_shape[0] + '.pnts[4]' )
    cmds.connectAttr( frustumCube_outline_shape[0] + '.pnts[5]', frustumCube02_shape[0] + '.pnts[5]' )
    cmds.connectAttr( frustumCube_outline_shape[0] + '.pnts[6]', frustumCube02_shape[0] + '.pnts[6]' )
    cmds.connectAttr( frustumCube_outline_shape[0] + '.pnts[7]', frustumCube02_shape[0] + '.pnts[7]' )


    # S010 :: Create containers for every stage of the script and then container those as well
    # Case 0 Container
    a_container = cmds.container( addNode=[ff0_filmAsp_lessThanEq_resAsp_cond, ff0_visAper1_aper0_div_resAsp_MD, ff0_visAper1_aper0_div_resAsp_mult_254_MD, ff0_visAper0_aper1_mult_resAsp_MD, ff0_visAper0_aper1_mult_resAsp_mult_254_MD] )

    # Case 1 Container
    b_container = cmds.container( addNode=[ff1_off1_aper0_div_resAsp_MD, ff1_off1_aper0_div_resAsp_minus_aper1_PMA, ff1_off1_aper01_composite_filmFitOff_mult_MD, ff1_off1_filmFitOff_composite_half_mult_MD, ff1_off1_filmFitOff_composite_half_2point54_mult_MD, ff1_filmAsp_greatThan_resAsp_cond, ff1_filmOffset_notZero_check_cond, ff1_filmAsp_gThan_resAsp_fFONotZero_MD, ff1_inner_and_condition_composite_cond, ff1_visAper1_aper0_div_resAsp_MD, ff1_visAper1_aper0_div_resAsp_mult_254_MD] )

    # Case 2 Container
    c_container = cmds.container( addNode=[ff2_off0_aper1_mult_resAsp_MD, ff2_off0_aper1_mult_resAsp_minus_aper0_PMA, ff2_off0_aper1_composite_filmFitOff_mult_MD, ff2_off0_filmFitOff_composite_half_mult_MD, ff2_off0_filmFitOff_composite_half_2point54_mult_MD, ff2_filmAsp_lessThan_resAsp_cond, ff2_filmOffset_notZero_check_cond, ff2_filmAsp_lThan_resAsp_fFONotZero_MD, ff2_inner_and_condition_composite_cond, ff2_visAper0_aper1_mult_resAsp_MD, ff2_visAper0_aper1_mult_resAsp_mult_254_MD] )

    # Case 3 Container
    d_container = cmds.container( addNode=[ff3_filmAsp_lessThanEq_resAsp_cond, ff3_visAper0_aper1_mult_resAsp_MD, ff3_visAper0_aper1_mult_resAsp_mult_254_MD, ff3_visAper1_aper0_div_resAsp_MD, ff3_visAper1_aper0_div_resAsp_mult_254_MD] )

    # filmFit composite (checking)
    e_container = cmds.container( addNode=[ff2ff3_check_cond, ff1ff2_check_cond, ff0ff1_check_cond] )

    # ViewScale
    f_container = cmds.container( addNode=[viewScale_div_10, viewScale, viewScale_div_2_MD, viewScale_div_neg2_MD] )

    # ViewTranslate
    g_container = cmds.container( addNode=[viewT_filmOffset_mult_2point54_MD, viewT_filmOffset_mult_2point54_minus_off_PMA, viewT_shake_mult_2point54_MD, viewT_shakeEnabled_PMA, which_offset_ifFalse_cond, which_offset_cond, viewT_ifShakeEnabled, viewT2_focal_mult_negPointZero_MD, viewT2_MD] )

    # Trigonometry
    h_container = cmds.container( addNode=[hAngle, vAngle, hAngle_connections[-1], vAngle_connections[-1], BeeAngle_MD, AaaAngle_180_minus_Bangle_PMA, AaaAngle_180_minus_Bangle_minus_Cangle_PMA, sinAPrep_div_180_MD, sinAPrep_div_180_mult_pi_MD, sinAPrep_div_180_mult_pi_mult100_MD, sinBPrep_div_180_MD, sinBPrep_div_180_mult_pi_MD, sinBPrep_div_180_mult_pi_mult100_MD, sinA_animCurveTL, sinB_animCurveTL, sinAVert_animCurveTL, sinBVert_animCurveTL, sinA_animCurveTL_connections[0], sinB_animCurveTL_connections[0], sinAVert_animCurveTL_connections[0], sinBVert_animCurveTL_connections[0]] )

    # Trigonometry * clip planes
    i_container = cmds.container( addNode=[sideBLength_MD, sideBLength_MD_nearClip_MD, sideBLength_MD_nearClip_mult_2_MD, sideBLength_MD_farClip_MD, sideBLength_MD_farClip_mult_2_MD] )

    # Frustum Cube
    j_container = cmds.container( addNode=[frustum_inverse_scale_MD, frustum_inverse_scale_abs_x, frustum_inverse_scale_abs_y, frustum_inverse_scale_abs_z] )

    # Frustum Cube - preparing for near and far clip planes
    k_container = cmds.container( addNode=[sideBLength_MD_nearClip_mult_neg2_MD, sideBLength_MD_farClip_mult_neg2_MD, clipPlaneNeg_MD, clipPlaneNeg_point5_offset_PMA, nearClip_pnt0_PMA, nearClip_pnt1_PMA, nearClip_pnt2_PMA, nearClip_pnt3_PMA, farClip_pnt4_PMA, farClip_pnt5_PMA, farClip_pnt6_PMA, farClip_pnt7_PMA] )

    # Frustum Cube Shader/Visibility conditions
    l_container = cmds.container( addNode=[frustumCube_outline_visiblity_cond, frustumCube01_visiblity_cond, frustumCube02_visiblity_cond] )

    # FrustumCube and outline point constraints
    m_container = cmds.container( addNode=[frustumCube_outline_pointConst[0], frustumCube_outline_orientConst[0], frustumCube_pointConst[0], frustumCube_orientConst[0]] )

    #Frustum shapes and surfaceShaders that I want hidden
    n_container = cmds.container( addNode=[frustumCube01[0], frustumCube02[0], frustumCube_outline[0]], includeShapes=True, includeTransform=True, force=True )

    frustum_container = cmds.container( addNode=[visAspect_ifShakeOverscanEnabled_MD,resAspect,filmAspect,aper,visAspect,a_container,b_container,c_container,d_container,e_container,f_container,g_container,h_container,i_container,j_container,k_container,l_container,m_container,n_container], includeShapes=True, includeTransform=True, force=True, name='frustum_container' )

    # S011 :: Message pass the mother container to all outgoing connections
    #         This is how I will implement deleting in case the user
    #         selects the frustum button by accident more than once.
    #         The message attribute will be checked and all outgoing deleted

    cmds.connectAttr( frustum_container + '.message', frustumCube_outline[0] + '.ihi', force=True )
    cmds.connectAttr( frustum_container + '.message', frustumCube01[0] + '.ihi', force=True )
    cmds.connectAttr( frustum_container + '.message', frustumCube02[0] + '.ihi', force=True )
    cmds.connectAttr( frustum_container + '.message', frustumCube_a_lamb + '.ihi', force=True )
    cmds.connectAttr( frustum_container + '.message', frustumCube_a_lambSG + '.ihi', force=True )
    cmds.connectAttr( frustum_container + '.message', frustumCube_b_lamb + '.ihi', force=True )
    cmds.connectAttr( frustum_container + '.message', frustumCube_b_lambSG + '.ihi', force=True )

    if frustCheckConnections != []:
        print '\n'
        print 're-initialized frustum properly'
        print '\n'

    cmds.select( selection )
# end cameraFrustum_make


def cameraCoverage_bake():
    """
    Gets the camera's view within the Maya scene and bakes it into the scene's
    geometry, to show what objects have been seen by the camera.
    """
    selection = cmds.ls( sl=True )
    allShapes = cmds.listRelatives( selection, shapes=True, noIntermediate=True )
    allMeshShapes = []
    cameraList = cmds.ls( cameras=True )
    for i in range(0,len(allShapes)):
        if allShapes[i] in cameraList:
            cameraTrans = cmds.listRelatives( allShapes[i], parent=True, noIntermediate=True )
            cameraShape = allShapes[i]
        else:
            pass
    allMeshShapes = cmds.ls( allShapes, type="mesh" )
    if allMeshShapes != []:
        allMeshTrans = cmds.listRelatives( allMeshShapes, parent=True, noIntermediate=True )
    else:
        sys.exit( 'SelectionError: You must select valid geometry' )

    # Filter out anything unwanted so that only geometry objects are chosen
    # (In case the user accidentally selects something other than geometry
    geoShape = allMeshShapes
    geoTrans = allMeshTrans

    # S01 :: Get all values from the UI for the script
    timeRangeMin = cmds.intFieldGrp( 'timeRange', query=True, value1=True )
    timeRangeMax = cmds.intFieldGrp( 'timeRange', query=True, value2=True )

    txRes = int( cmds.optionMenu( 'txRes', query=True, value=True ) )
    outputFormat = cmds.optionMenu('outputFormat', query=True, value=True )

    filePrefix = cmds.textFieldGrp('filePrefix', query=True, text=True )
    #deleteAfter = cmds.radioButtonGrp('postBakeExecution', query=True )
    #***AUTHOR NOTE: Go back and add a "are you sure" option for the 2048 px option!


    # S02 :: Create the basis for the "frustum" white projection
    #        this check and p2d are necessary because wrap U and V must be turned off
    #        to avoid redundancy, one checker will be made and it will be applied to each
    #        projection during the for loop. No sense in make hundreds of unneeded nodes
    checker = cmds.createNode( 'checker' )
    cmds.setAttr( checker + '.defaultColor', 0,0,0 )
    p2d = cmds.createNode( 'place2dTexture' )
    cmds.setAttr( p2d + '.wrapU', 0 )
    cmds.setAttr( p2d + '.wrapV', 0 )
    cmds.setAttr( p2d + '.repeatU', 0.25 )
    cmds.setAttr( p2d + '.repeatV', 0.25 )
    cmds.connectAttr( p2d + '.outUV', checker + '.uv' )
    cmds.connectAttr( p2d + '.outUvFilterSize', checker + '.uvFilterSize' )

    # S04 :: Lastly, before the for loop is created, make the plusMinusAverage node that will
    #        combine the projections together during (AUTHOR NOTE: after?) the for-loop
    #        in this case, we need a plusMinusAverage node that will average the values incoming
    #        AUTHOR NOTE: Later on, to save computation, you should change the checker color to 1/timeRange
    #        so that you can simply "add" and not have to "average", this saving power/time
    #
    #        To avoid having to store a list, we're going to also create a group and put it
    #        under the camera so we can have a place to store our nodes
    camBake_projComp_PMA = cmds.createNode( 'plusMinusAverage' )
    cmds.setAttr( camBake_projComp_PMA + '.operation', 3 )

    # A bit of cleanup so that the cameras can be organized under one grp
    camBake_mast_grp = cmds.group( em=True, parent='camera1' )
    cmds.setAttr( camBake_mast_grp + '.translateX', 1 )
    camBake_light_grp = cmds.group( em=True, parent=camBake_mast_grp )
    camBake_cam_grp = cmds.group( em=True, parent=camBake_mast_grp )


    # S05 :: Construct the for loop which will make this script possible
    #        lists are initialzed prior to for loop execution
    camera_dup_list=[]
    camera_dupShape_list=[]
    light_list=[]
    light_shape_list=[]
    light_shape_reverse_list=[]
    projection_list=[]


    for frames in range(timeRangeMin,timeRangeMax):
        cmds.currentTime( frames )
        camera_dup = cmds.camera()
        camera_dupShape = camera_dup[1]

        temp_parentConstraint = cmds.parentConstraint( cameraTrans, camera_dup[0] )
        cmds.delete( temp_parentConstraint )

        # S04 :: Create proj, set it to camera selection, resolution settings and fill fit-type
        #        AUTHOR NOTE: Ideally you want to have res settings and fit type be what the camera is. This is temporary
        #
        # Connect projection with the checker file
        camBake_proj = cmds.createNode('projection')
        cmds.connectAttr( checker + '.outColorR', camBake_proj + '.imageR' )

        cmds.connectAttr( camera_dupShape + '.message', camBake_proj + '.linkedCamera', f=True )
        cmds.setAttr( camBake_proj + '.projType', 8 )
        cmds.setAttr( camBake_proj + '.fitType', 2 )
        cmds.setAttr( camBake_proj + '.fitFill', 0 )
        #cmds.connectAttr( camera_dupShape + '.message', camBake_proj + '.linkedCamera' )

        # S04 :: In order for use to obscure the backside of objects, we need lights - constraint to the appropriate camera
        camBake_spotL_shape = cmds.spotLight( decayRate=0, dropOff=0, penumbra=0, shadowColor=[0,0,0], intensity=1, coneAngle=179 )
        cmds.setAttr( camBake_spotL_shape + '.useDepthMapShadows', 1 )
        cmds.setAttr( camBake_spotL_shape + '.useDmapAutoFocus', 0 )
        # AUTHOR NOTE: ***If time, go back and query the vFOV and hFOV. Whichever is larger will be used for the dMapFocus!!!***
        cmds.setAttr( camBake_spotL_shape + '.dmapFocus', 179 )
        # AUTHOR NOTE: DMAP RESOLUTION should probably be equal to the output texture resolution
        # wouldn't it make sense to make those two work on a 1:1 ratio?
        #cmds.setAttr( camBake_spotL_shape + '.dmapResolution',

        # Get shape parent for parenting
        camBake_spotL_parent = cmds.listRelatives( camBake_spotL_shape, parent=True, fullPath=True )
        # AUTHOR NOTE: after the script works, you can delete this setAttr scale. It's only temporary
        cmds.setAttr( camBake_spotL_parent[0] + '.scale', 0.02,0.02,0.02 )
        spot_point = cmds.parentConstraint( camera_dup[0], camBake_spotL_parent, maintainOffset=False, weight=1 )

        # Now connect the lightShadowfraction to a new reverse node
        camBake_lightShadowF_reverse = cmds.createNode( 'reverse', name='camBake_lightShadowF_reverse' )
        cmds.connectAttr( camBake_spotL_shape + '.lightShadowFraction', camBake_lightShadowF_reverse + '.inputX' )

        # Append objects we plan to reference later
        camera_dup_list.append( camera_dup[0] )
        camera_dupShape_list.append( camera_dupShape )
        light_list.append( camBake_spotL_parent )
        light_shape_list.append( camBake_spotL_shape )
        light_shape_reverse_list.append( camBake_lightShadowF_reverse )
        projection_list.append( camBake_proj )

    # connect cameras to projection nodes
    for i in range(0,len(camera_dup_list)):
        cmds.connectAttr( camera_dupShape_list[i] + '.message', projection_list[i-1] + '.linkedCamera', f=True )
    # Organize the lights and cameras under the new groups
    for i in range(0,len(light_list)):
        cmds.parent( light_list[i], camBake_light_grp )

    for i in range(0, len(camera_dup_list)):
        cmds.parent( camera_dup_list[i], camBake_cam_grp )


    # Connect checker to projection for the final white frustum
    # Combine the projections to a single plusMinusAverage node
    # AUTHOR NOTE: GO back later and use averaging on the shadow color of maybe the lights
    # or the shader connection so that you don't have to waste processing averaging the
    # PMAs here!
    camBake_proj_PMA = cmds.createNode( 'plusMinusAverage', name='camBake_proj_PMA' )
    cmds.setAttr( camBake_proj_PMA + '.operation', 3 )

    for i in range(0,len(projection_list)):
            cmds.connectAttr( projection_list[i] + '.outColorR', (camBake_proj_PMA + '.input1D' + str([i])), force=True )

    # Finally, we need to use the list of lights and their lightShadowFraction attribute to
    # acquire the shadows on the scene. Why not use surfaceLuminance? Because it's too slow to bake
    # ALSO if there are other lights in the scene, it will mess up the baking process. Whereas this is
    # guaranteed to keep the surface shader from breaking. It's all-around a better strategy

    camBake_lightShadowF_PMA = cmds.createNode( 'plusMinusAverage', name='camBake_lightShadowF' )
    cmds.setAttr( camBake_lightShadowF_PMA + '.operation', 3 )

    for i in range(0,len(light_shape_reverse_list)):
        cmds.connectAttr( light_shape_reverse_list[i] + '.outputX', (camBake_lightShadowF_PMA + '.input1D' + str([i])), force=True )


    # combine the projection white with the shadow black
    camBake_projShadow_comp_MD = cmds.createNode( 'multiplyDivide' )
    cmds.setAttr( camBake_projShadow_comp_MD + '.operation', 1 )
    cmds.connectAttr( camBake_proj_PMA + '.output1D', camBake_projShadow_comp_MD + '.input1X' )
    cmds.connectAttr( camBake_lightShadowF_PMA + '.output1D', camBake_projShadow_comp_MD + '.input2X' )

    # Now connect to a newly created surfaceShader
    camBake_surf = cmds.shadingNode( 'surfaceShader', asShader=True, name='camBake_surf')
    camBake_surfSG = cmds.sets( renderable=True, empty=True, name='camBake_surfSG' );
    cmds.connectAttr( camBake_surf + ".outColor", camBake_surfSG + ".surfaceShader", force=True)
    cmds.connectAttr( camBake_projShadow_comp_MD + '.outputX', camBake_surf + '.outColorR' )
    cmds.connectAttr( camBake_projShadow_comp_MD + '.outputX', camBake_surf + '.outColorG' )
    cmds.connectAttr( camBake_projShadow_comp_MD + '.outputX', camBake_surf + '.outColorB' )





    # Check if the user wanted to delete the nodes after execution or if
    # the scene is meant to be preserved
    if cmds.radioButtonGrp( 'postExeCommand', query=True, select=True )==1:
        # The user wants to delete the unnecessary nodes after creation. Therefore
        # we'll perform the bake and then delete everything that was generated
        # assigning the shader to the actual geometry is unneeded
        bakedCamTx = cmds.convertSolidTx( camBake_surfSG, geoTrans, antiAlias=0, bm=2, fts=1, sp=0, sh=1, alpha=0, doubleSided=0, componentRange=0, resolutionX=txRes, resolutionY=txRes, fileFormat=outputFormat, uvRange=(0,1,0,1), bc=(0,0,0) )

        # http://stackoverflow.com/questions/12433695/extract-elements-of-list-at-odd-positions
        bakedCamTx_p2dList = bakedCamTx[1::2]
        bakedCamTx= bakedCamTx[0::2]

        # delete all other unnecessary nodes
        cmds.delete( camBake_projShadow_comp_MD, camBake_lightShadowF_PMA, camBake_proj_PMA, camBake_light_grp, camBake_cam_grp, camBake_cam_grp, camBake_light_grp, camBake_mast_grp, camBake_projComp_PMA, p2d, checker )

        for i in range(0,len(bakedCamTx_p2dList)):
            cmds.delete( bakedCamTx_p2dList[i] )

        #for i in range(0,len(camera_dup_list)):
        #    print light_shape_reverse_list[i]
        #    cmds.delete( light_shape_reverse_list, projection_list[i], camera_dup_list[i], light_list[i] )

        # Build the baked files underneath the original surface shader
        camBake_bakedTx_tripleS = cmds.createNode( 'tripleShadingSwitch', name='camBake_bakedTx_tripleS' )
        for i in range(0,len(geoShape)):
            # For some reason, the inTriple needs to be ran before the inShape, despite the fact
            # that the command will run in either outside of the for loop.
            cmds.connectAttr( bakedCamTx[i] + '.outColor', camBake_bakedTx_tripleS + '.input' + str([i]) + '.inTriple', f=True )
            cmds.connectAttr( geoShape[i] + '.instObjGroups[0]', camBake_bakedTx_tripleS + '.input' + str([i]) + '.inShape', force=True )

            # AUTHOR NOTE: as a note of optimization, you can combine this for loop with the UV-optimization for loop - since they contain the same number of args
        cmds.connectAttr( camBake_bakedTx_tripleS + '.output', camBake_surf + '.outColor' )


        # UV Optimization attributes
        if cmds.radioButtonGrp( 'uvOptimization', query=True, select=True )==2:
            #print cmds.radioButtonGrp( 'uvOptimization', query=True, select=True )
            for i in range(0,len(geoTrans)):
                cmds.select( geoTrans[i], r=True )
                try:
                    cmds.artSelectCtx( 'artSelectCtx' )
                except:
                    pass
                cmds.setToolTo( 'artSelectCtx' )

                # clear selection of vertices if one already exists
                # AUTHOR NOTE: store selection and revert after script is run!!!
                cmds.selectMode( component=True )
                cmds.select( cl=True )

                # Get file texture path from file nodes for each geometry shape
                bakedCamTx_filePath = cmds.getAttr( bakedCamTx[i] + '.fileTextureName' )

                # select vertices from file read
                #filePath = 'E:/temp-work-transfer-folder/black-white-zebra-strips.jpg'
                cmds.artSelectCtx( 'artSelectCtx', importfileload=bakedCamTx_filePath, e=True, importreassign=True, selectop='select' )
                # shrink selection and then grow by two
                # This is to avoid applying UV corrections to any artifacts generated during the texture bake process
                #
                # The user has the option to specify these values - since they are arbitrary

                # AUTHOR NOTE: using len() here may not work logistically. Test

                for i in range(-1,(cmds.intSliderGrp( 'camCov_shrinkSlider', query=True, value=True) - 1) ):
                    print '\n\nShrinking\n\n'
                    mel.eval( " ShrinkPolygonSelectionRegion" )
                for i in range(-1,(cmds.intSliderGrp( 'camCov_growSlider', query=True, value=True) - 1) ):
                    print '\n\nGrowing\n\n'
                    mel.eval( "GrowPolygonSelectionRegion" )

                # Convert verts to UV selection

                cmds.polyListComponentConversion( fromVertex=True, toUV=True )

                # Select the vertices in white. AKA what is in view
                # UV change - normalize UV size if enabled

                cmds.polyNormalizeUV()
                #print geoShape
                #print geoShape[i]
                cmds.setAttr( geoShape[i] + '.uvPivot', 0.5, 0.5 )
                cmds.InvertSelection()
                cmds.polyNormalizeUV()
                cmds.polyEditUV( su=0.05, sv=0.05 )
                cmds.InvertSelection()

                # AUTHOR NOTE: set tool back to previous tool
                # AUTHOR NOTE: There should be a confirmation screen with UV editor so that people can say if they like the result yes/no

    else:
        # If the selected option is to keep - then obviously they want a preview
        # in the viewer without any other lights obstructing. In this case -
        # don't bake or delete anything and instead create a rig to work with.
        cmds.select( geoTrans )
        cmds.sets( e=True, forceElement=camBake_surfSG )
# end cameraCoverage_bake


def D2N_bakeAndCopy():
    """
    Bakes the DOF locator's animation so that it can be more easily exported as
    a FBX file
    """
    # Get DOF cube locator selection
    selection = cmds.ls( sl=True )
    if len(selection)>1:
        print '\n\n'
        sys.exit( 'SelectionError: Please select only the Depth of Field Cube' )

    DOF_locChildren = cmds.listRelatives( cmds.ls( sl=True ), children=True, noIntermediate=True )

    if DOF_locChildren==[]:
        print '\n\n'
        sys.exit( 'SelectionError: You must select the Depth of Field Cube before running the DOF2Nuke Bake! ' )

    DOF_locatorShape = DOF_locChildren[0]
    DOF_locatorTransform = cmds.listRelatives( DOF_locatorShape, parent=True, noIntermediate=True )

    if DOF_locatorTransform==[]:
        print '\n\n'
        sys.exit( 'SelectionError: Something went wrong. Make sure you selected the DOF locator before running the script' )

    # Get timeRange and filePath
    D2NBake_filePathAndName = cmds.textFieldGrp( 'D2NBake_filePathAndName', query=True, text=True )
    if D2NBake_filePathAndName=="":
        print '\n\n'
        sys.exit( 'Please specify a file path' )

    # AUTHOR NOTE: Find the script you saved that checks if a file path was
    # specified properly then change the slashes to forward
    D2NBake_timeRange_radio = cmds.radioButtonGrp( 'D2NBake_timeRange_radio', query=True, select=1 )
    if D2NBake_timeRange_radio==1:
        D2NBake_timeRange_startFrame = cmds.playbackOptions( query=True, minTime=True )
        D2NBake_timeRange_endFrame = cmds.playbackOptions( query=True, maxTime=True )
    else:
        D2NBake_timeRange_startFrame = cmds.intFieldGrp( 'D2NBake_timeRange_intField', query=True, value1=True )
        D2NBake_timeRange_endFrame = cmds.intFieldGrp( 'D2NBake_timeRange_intField', query=True, value2=True )

    # In the DOF_controller() script, we made a single, lonely multiplyDivide node
    # that would eventually be used to create the D2NBake
    #
    # and then took its value and made it absolute. This node will now be used for
    # ratio of where the controller sits along the camera's clipPlane
    # using the DOF locator as a selection
    D2NBake_loc_TransRatio_temp1 = cmds.listConnections( DOF_locatorTransform, destination=True )
    D2NBake_loc_TransRatio_temp2 = cmds.listConnections( D2NBake_loc_TransRatio_temp1[0], destination=True )
    D2NBake_loc_TransRatio_temp3 = cmds.listConnections( D2NBake_loc_TransRatio_temp2[0], destination=True )
    D2NBake_loc_TransRatio_temp4 = cmds.listConnections( D2NBake_loc_TransRatio_temp3[0], destination=True, p=False )
    D2NBake_loc_TransRatio = D2NBake_loc_TransRatio_temp4[-1]

    # Now we need to get a query on the half-scale - again, also for export
    D2NBake_loc_scale = cmds.listConnections( DOF_locatorTransform, destination=True )
    D2NBake_loc_scale = cmds.listConnections( D2NBake_loc_scale[-2], destination=True )
    D2NBake_loc_scale = D2NBake_loc_scale[-1]

    # Create a locator to house the FBX Bake
    # AFAIK FBX can ONLY bake t/r/s so we need to
    # do this to get the percentage distance value out
    #
    # Also, by doing it in a separate transform,
    # When the animation is baked out, we can delete the
    # locator without losing the original file
    D2NBake_locator_ref = cmds.spaceLocator( p=(0,0,0) )
    cmds.connectAttr( D2NBake_loc_TransRatio + '.distance', D2NBake_locator_ref[0] + '.translateX' )
    cmds.connectAttr( D2NBake_loc_scale + '.outputZ', D2NBake_locator_ref[0] + '.scaleX' )

    # Now to bake the animation of the locator
    cmds.bakeResults( D2NBake_locator_ref, simulation=True, time=(D2NBake_timeRange_startFrame,D2NBake_timeRange_endFrame), sampleBy=1, disableImplicitControl=True, preserveOutsideKeys=True, sparseAnimCurveBake=False, removeBakedAttributeFromLayer=False, removeBakedAnimFromLayer=False, bakeOnOverrideLayer=False, minimizeRotation=True, at=["tx","sx"] )

    # Export the dummyLoc to FBX
    cmds.file( D2NBake_filePathAndName, force=True, options="", typ="FBX export", pr=True, es=True )

    # Create a paste-dump for the Nuke script

    # finally, clean the export - delete the UI
    # and delete the locator that we baked to
    cmds.deleteUI( 'D2NBake_timeRange_window' )
    cmds.delete( D2NBake_locator_ref )
# end D2N_bakeAndCopy


def renderWithNotes_defaultValues(activePanelCamera):
    """
    When the render with notes window appears, the following function defines
    its default text

    Args:
        activePanelCamera (str): The current active camera (aka in focus)

    Returns:
        str: The resulting default text to send to the render window
    """
    #full scene path
    scenePathFull = cmds.file( q=True, sn=True )
    if scenePathFull == "": scenePathFull='untitled Maya file'
    # parent scene file
    parentSceneFile = cmds.file( q=True, sn=True, shn=True )
    renderCam = activePanelCamera
    currentFrame = cmds.currentTime( q=True )
    # Current real world date/time
    currentDate = time.strftime("%d/%m/%Y")
    currentTime = time.strftime("%H:%M:%S")
    outputText = str( '\n:::' + '\nScene Path:\n ' + scenePathFull + '\nParent Scene File:\n ' + parentSceneFile + '\nRender Camera:\n ' + renderCam + '\nFrame:\n ' + str(int(currentFrame)) + '\n\nDate:\n ' + currentDate + '\nTime (military):\n ' + currentTime + '\n:::' )
    return outputText
# end renderWithNotes_defaultValues


def renderWithNotes_OK():
    """
    Executes when the user presses render with notes, this function renders
    the current frame to the specified location and outputs the required text
    """
    text = cmds.scrollField( widgets['RWN_SF'], query=True, text=True )

    # Make a pseudo-save dialog box to get the user to save to a location
    # Before the pseudo-save box can be made, we need a parsed list of all possible fileformats available to the user
    # this script will account for all registered file formats (should work for renderman, vray, and other packages)
        # http://forums.cgsociety.org/showthread.php?f=89&t=1083698&highlight=image+format+list
      # http://forums.cgsociety.org/showthread.php?f=89&t=1083698&highlight=image+format+list
    phile = mLoc = str(mel.eval('getenv "MAYA_LOCATION"')) + '/scripts/others/createImageFormats.mel'
    imageFormatIndex={}
    try:
        read_phile=open(phile,"r")
        textPhile =str(read_phile.read())

        lst = textPhile.split("$i =")
        for each in lst:
            if each.split()[0].split(";")[0].isdigit() :
                if (each.split()[-1].split(";")[0].replace('"',"")).isalnum():
                    imageFormatIndex[each.split()[0].split(";")[0]]=each.split()[-1].split(";")[0].replace('"',"").upper()

    finally:
        read_phile.close()

    imageFormatIndex.update({'12':'YUV'})
    imageFormatIndex.update({'13':'SGI16'})
    imageFormatIndex.update({'4':'TIF16'})
    imageFormatIndex.update({'10':'MAYA16 IFF'})
    imageFormatIndex.update({'7':'MAYA IFF'})
    filterList = []
    for keys,values in imageFormatIndex.items():
        list = str(values) + ' ' + ( '(' + str(keys) + ')' )
        filterList.append( list )
    multipleFilters = ';;'.join(filterList)

    try:
        fileFull = cmds.fileDialog2(fileFilter=multipleFilters, caption='Write to a text file', rf=True )
        fileExtensionInt = int(str(fileFull[0]).split('/')[-1].split('.')[-1])
        fileExtension = fileFull[1]
    except TypeError:
        cmds.warning( 'Aborted by user' )
    # AUTHOR NOTE: input that os.path script that checks if a file path is valid!!!!

    filePath = str(fileFull[0]).split('/')
    filePath[0] = filePath[0][-2:]
    fileName = filePath[-1].split('.')[0]
    filePath = '/'.join(filePath[:-1])

    autoOutput = str(renderWithNotes_automatedOutput())
    if autoOutput != "":
        autoOutput = 'Automated Output\n' + autoOutput

    outputTextFile = open( str(filePath) + '/' + str(fileName) + '.txt', 'w' )
    outputTextFile.write( 'User Submitted Notes:\n{0}\n\n{1}'.format(str(text), autoOutput) )
    outputTextFile.close()




    # render the scene to specified directory
    # annoyingly, the render command doesn't have a flag for overriding file type
    # so the file type must be queried from the render globals, replaced with our own, and then changed back
    # (we change it back to the original values in case the user has something different from their render globals)
    getImageFormat = int(cmds.getAttr( 'defaultRenderGlobals.imageFormat' ))
    getImageFilePrefix = cmds.getAttr( 'defaultRenderGlobals.imageFilePrefix' )

    cmds.setAttr( 'defaultRenderGlobals.imageFormat', fileExtensionInt )

    # imageFilePrefix will not set with a variable in python so we must eval as string

    cmds.setAttr( 'defaultRenderGlobals.imageFilePrefix', fileName, type='string' )
    #cmds.setAttr( 'defaultRenderGlobals.imageFilePrefix', fileName, type='string' )

    # render and then copy render to user-specified location
    render = cmds.render( rep=True )
    render = str(render).split('/')
    shutil.copyfile( str('/'.join(render)), (str(filePath) + '/' + str(render[-1])) )

    # set back to the previously defined value
    cmds.setAttr( 'defaultRenderGlobals.imageFormat', getImageFormat )
    cmds.setAttr( 'defaultRenderGlobals.imageFilePrefix', getImageFilePrefix, type='string' )

    if cmds.window('RWN_textOption', exists=True ):
        cmds.deleteUI( 'RWN_textOption' )
# end renderWithNotes_OK


def renderWithNotes_Cancel():
    """
    Deletes the window when the user cancels the render with notes feature
    """
    cmds.deleteUI("RWN_textOption")
# end renderWithNotes_Cancel


def renderWithNotes():
    """
    Creates the render with notes window, whose text and information is
    populated by other functions such as renderWithNotes_OK,
    renderWithNotes_Cancel, and other similar functions
    """
    # re-initialize older windows
    if cmds.window("RWN_textOption", exists=True):
        cmds.deleteUI("RWN_textOption")

    # get active window camera
    focusPanel = cmds.getPanel( withFocus=True )
    activePanelCamera = cmds.modelPanel( focusPanel, q=True, camera=True )

    if activePanelCamera == "":
        print '\n\n'
        sys.exit( 'Maya requires an active panel to render. Please select the viewport window that you wnat to render' )

    # generate default values for the text scroll field to be filled with
    textSF_default = renderWithNotes_defaultValues( activePanelCamera )

    widgets['RWN_textWindow'] = cmds.window('RWN_textOption', title='Would you like to say a few words about this render?' )
    cmds.columnLayout( nch=2, adj=0 )
    windowWidth = 600
    windowHeight = 450
    cmds.frameLayout( label='                                                                              Render Notes (optional)', width=windowWidth, height=windowHeight)
    widgets['RWN_formLayout01'] = cmds.formLayout()
    # Toggle switch widgets
    widgets['RWN_titleText'] = cmds.text('Text that you write here will appear in the same save folder directory as a .txt file \n Keep blank if do not wish to write notes about your render', align='center' )
    widgets['RWN_autoOutTDesc'] = cmds.text( label='Automated Output',fn='smallPlainLabelFont')
    widgets['RWN_textTog'] = cmds.textField( 'textTog',ed=0,w=60, bgc=(0.18,0.18,0.18) )
    widgets['RWN_onOffText'] = cmds.text( label=' ON    OFF',fn='smallBoldLabelFont' )
    widgets['RWN_autoOutButton'] = cmds.button(l='',w=30,h=18,ann='0',c='toggleBttn(widgets["RWN_autoOutButton"],widgets["RWN_formLayout01"],1,62,158,128)' )
    widgets['RWN_conciseOutRBG'] = cmds.radioButtonGrp( label='Concise Output   ', vertical=True, labelArray2=['Yes', ' No'], numberOfRadioButtons=2, en=False, select=2, cw=[(1,100),(2,50)] )
    widgets['RWN_selSetTFG'] = cmds.textFieldGrp( label='Selection Set (optional) ', columnWidth=(2,140) )


    widgets['RWN_SF'] = cmds.scrollField( editable=True, wordWrap=True, text=textSF_default, w=(windowWidth-80), h=(windowHeight-200) )
    widgets['RWN_OK'] = cmds.button( label='OK', c='renderWithNotes_OK()', w=70 )
    widgets['RWN_CANCEL'] = cmds.button( label='Cancel', c='renderWithNotes_Cancel()', w=70 )
    cmds.setParent('..')

    cmds.formLayout(widgets['RWN_formLayout01'],e=1,af=[ (widgets['RWN_autoOutTDesc'],'top',47+15+2+0), (widgets['RWN_autoOutTDesc'],'left',40) ])
    cmds.formLayout(widgets['RWN_formLayout01'],e=1,af=[ (widgets['RWN_textTog'],'top',47+15+0), (widgets['RWN_textTog'],'left',40+88) ])
    cmds.formLayout(widgets['RWN_formLayout01'],e=1,af=[ (widgets['RWN_onOffText'],'top',45+15+5+0), (widgets['RWN_onOffText'],'left',40+4+88) ])
    cmds.formLayout(widgets['RWN_formLayout01'],e=1,af=[ (widgets['RWN_autoOutButton'],'top',45+15+0+2), (widgets['RWN_autoOutButton'],'left',40+88) ])
    cmds.formLayout(widgets['RWN_formLayout01'],e=1,af=[ (widgets['RWN_selSetTFG'],'top',47+10+25+1), (widgets['RWN_selSetTFG'],'left',10+3) ])
    cmds.formLayout(widgets['RWN_formLayout01'],e=1,af=[ (widgets['RWN_conciseOutRBG'],'top',45+15+0+2), (widgets['RWN_conciseOutRBG'],'left',40+88+293) ])


    cmds.formLayout(widgets['RWN_formLayout01'],e=1,af=[ (widgets['RWN_titleText'],'top',20+10), (widgets['RWN_titleText'],'left',100) ])
    cmds.formLayout(widgets['RWN_formLayout01'],e=1,af=[ (widgets['RWN_SF'],'top',70+15+20), (widgets['RWN_SF'],'left',40) ])
    cmds.formLayout(widgets['RWN_formLayout01'],e=1,af=[ (widgets['RWN_CANCEL'],'top',windowHeight-120+15+20), (widgets['RWN_CANCEL'],'left',windowWidth-175-10) ])
    cmds.formLayout(widgets['RWN_formLayout01'],e=1,af=[ (widgets['RWN_OK'],'top',windowHeight-120+15+20), (widgets['RWN_OK'],'left',windowWidth-98-10) ])

    cmds.showWindow( widgets['RWN_textWindow'] )
# end renderWithNotes


def DOF_controller():
    """
    Creates a DOF controller in the middle of the camera's near/far clip planes
    and sizes the controller to be approximately half the FOV of the camera.

    It also creates the relationship between the camera and the objects in the
    scene so that exporting the DOF controller and hooking the controller up
    to the DOF shader for rendering are both possible
    """
    # Check if the selection is cameraShape

    selection = cmds.ls( sl=True )
    if selection==[]:
        print '\n\n'
        sys.exit( 'SelectionError: Please select a camera' )

    cameraList = cmds.ls( cameras=True )
    selectionList = cmds.ls( sl=True, shapes=True, dag=True )

    if selectionList[0] not in cameraList:
        print '\n\n'
        sys.exit( 'SelectionError: Please select a camera!' )


    # Check if a DOF controller already exists using container. If the DOF exists, delete it completely
    DOFCheckConnections = []
    try:
        DOFCheckConnections = cmds.listConnections( selection[0] + '.DOFVisibility', plugs=True, d=True )
    except:
        pass
    if DOFCheckConnections != []:
        DOF_innerContainerCheck = cmds.container( fc=DOFCheckConnections, q=True )
        DOF_innerNodes = cmds.container( DOF_innerContainerCheck, nodeList=True, q=True )
        cmds.delete( DOF_innerNodes )

        # get all outbound connections of frustumContainer
        DOF_outBoundConnections = cmds.listConnections( DOF_innerContainerCheck, p=True, d=True, s=True )
        for i in range(0,len(DOF_outBoundConnections)):
            b = DOF_outBoundConnections[i].split('.')
            cmds.delete(b[0])

    camTrans = selection[0]
    camShape = selectionList[0]
    cameraTrans = camTrans
    cameraShape = camShape



    # S01 :: create and initialize (values and hide) all nodes to create DOF

    # S01A :: Create dist locs
    # I've decided to go with locators instead of using the transform of camera because, if the camera
    # has been incorporated into a rig, it may not display its world space coordinates properly.
    # Also, I COULD use a decomposeMatrix node but I run into the same possibility that the user
    # doesn't have/want matrixNodes plugins loaded.

    distDim = cmds.distanceDimension( sp=(0,0,0), ep=(0,0,-1) )
    distDim_locs = cmds.listConnections( distDim )
    focusDistMeasure_distShape = distDim
    focusDistMeasure_dist = cmds.listRelatives( focusDistMeasure_distShape, parent=True, noIntermediate=True )
    focusDistMeasure_dist = focusDistMeasure_dist[0]

    nearDist = distDim_locs[0]
    # for container grouping
    nearDistShape = cmds.listRelatives( nearDist, shapes=True, noIntermediate=True )
    cmds.hide( nearDist )


    # orient the locators in the proper position
    # Bug Update: 10/27/14 - With cameras that have their rotate channels
    # locked on aim constrained, the nearDist_pConst was causing weird rotations.
    # This is dirty but I'm going to get and set the camera rotation values before/after
    # to fix the problem.
    cameraTrans_temporaryRotateGet = cmds.getAttr( cameraTrans + '.rotate' )
    nearDist_pConst = cmds.pointConstraint( cameraTrans, nearDist, offset=[0,0,0], weight=1 )
    cmds.setAttr( cameraTrans + '.rotateX', cameraTrans_temporaryRotateGet[0][0] )
    cmds.setAttr( cameraTrans + '.rotateY', cameraTrans_temporaryRotateGet[0][1] )
    cmds.setAttr( cameraTrans + '.rotateZ', cameraTrans_temporaryRotateGet[0][2] )


    farDist = distDim_locs[1]
    # set Rotate order so that it can spin 360 on y-axis without flipping
    cmds.setAttr( farDist + '.rotateOrder', 4 )
    DOF_group = cmds.group( em=True )
    cmds.parent( DOF_group, cameraTrans )
    cmds.parent( farDist, DOF_group )
    # get the parent underneath the group to face the same direction as the camera
    cmds.setAttr( DOF_group + '.rotate', 0,0,0 )

    cameraDistAverage = abs(cmds.getAttr( cameraShape + '.nearClipPlane' ) + cmds.getAttr( cameraShape + '.farClipPlane' ) ) /-2



    # get the control centred properly
    cmds.setAttr( farDist + '.translate', 0,0,cameraDistAverage )
    cmds.setAttr( farDist + '.rotate', 0,0,0 )
    cmds.setAttr( farDist + '.scale', cameraDistAverage,cameraDistAverage/4,cameraDistAverage/2 )

    # But now unparent the ctl because we want it to be able to move freely from the camera (not parent behavior)
    # orientConstrain the axis so that it will always face the camera
    cmds.parent( farDist, w=True )
    cmds.delete( DOF_group )
    # lock and hide excess attributes AUTHOR NOTE

    # S01B :: DOF Manipulator
    c1 = cmds.curve( d=1, p=[(-0.5,-0.5,-0.5), (0.5,-0.5,-0.5)], k=[0,1] )
    c2 = cmds.curve( d=1, p=[(-0.5,-0.5,-0.5), (-0.5,0.5,-0.5)], k=[0,1] )
    c3 = cmds.curve( d=1, p=[(-0.5,-0.5,-0.5), (-0.5,-0.5,0.5)], k=[0,1] )
    c4 = cmds.curve( d=1, p=[(-0.5,0.5,-0.5), (-0.5,0.5,0.5)], k=[0,1] )
    c5 = cmds.curve( d=1, p=[(-0.5,0.5,-0.5), (0.5,0.5,-0.5)], k=[0,1] )
    c6 = cmds.curve( d=1, p=[(0.5,0.5,0.5), (-0.5,0.5,0.5)], k=[0,1] )
    c7 = cmds.curve( d=1, p=[(0.5,0.5,0.5), (0.5,-0.5,0.5)], k=[0,1] )
    c8 = cmds.curve( d=1, p=[(0.5,0.5,0.5), (0.5,0.5,-0.5)], k=[0,1] )
    c9 = cmds.curve( d=1, p=[(0.5,-0.5,0.5), (-0.5,-0.5,0.5)], k=[0,1] )
    c10 = cmds.curve( d=1, p=[(0.5,-0.5,-0.5), (0.5,-0.5,0.5)], k=[0,1] )
    c11 = cmds.curve( d=1, p=[(0.5,-0.5,-0.5), (0.5,0.5,-0.5)], k=[0,1] )
    c12 = cmds.curve( d=1, p=[(-0.5,-0.5,0.5), (-0.5,0.5,0.5)], k=[0,1] )

    cAll_t = cmds.ls( c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12 )
    cAll_s = cmds.listRelatives( cAll_t, s=True )
    # giving the cube a quick color
    for i in range(0, len(cAll_s)):
        cmds.setAttr( cAll_s[i] + '.overrideEnabled', 1 )
        cmds.setAttr( cAll_s[i] + '.overrideColor', 17 )
    # and now the farDist loc and the distDim
    cmds.setAttr( distDim + '.overrideEnabled', 1 )
    cmds.setAttr( distDim + '.overrideColor', 17 )
    cmds.setAttr( farDist + '.overrideEnabled', 1 )
    cmds.setAttr( farDist + '.overrideColor', 4 )

    DOF_nurbsCube = cmds.parent( cAll_s, farDist, r=True, s=True )
    cmds.delete( cAll_t )

    # DOF Modification Oct, 17 2014
    # This is to address a critical error with the controller
    # where the distance becomes inaccurate if off axis from the camera
    #
    # Now that the controller has been made, we need to create a locator
    # that will store that actual position (distance) from the camera
    farDist_ref_grp = cmds.group( empty=True )
    cmds.parent( farDist_ref_grp, cameraTrans )
    cmds.setAttr( farDist_ref_grp + '.translate', 0,0,0 )
    cmds.setAttr( farDist_ref_grp + '.rotate', 0,0,0 )

    # this locator will follow the controller automatically
    # but, at the same time, will keep constrained to the camera to judge
    # the actual distance from camera
    farDist_refShape = cmds.createNode( 'locator', name='farDist_refShape' )
    farDist_ref = cmds.listRelatives( farDist_refShape, parent=True, noIntermediate=True )

    #p_temp = cmds.pointConstraint( farDist_ref_grp, farDist_ref, maintainOffset=False, weight=1 )
    #o_temp = cmds.pointConstraint( farDist_ref_grp, farDist_ref, maintainOffset=False, weight=1 )
    #cmds.delete( p_temp, o_temp )
    cmds.parent( farDist_ref[0], farDist_ref_grp )
    farDistref_pConst = cmds.pointConstraint( farDist, farDist_ref[0], maintainOffset=False, skip=['x','y'], weight=1 )


    cmds.hide( farDist_ref )
    cmds.setAttr( farDist_ref[0] + '.translateX', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( farDist_ref[0] + '.translateY', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( farDist_ref[0] + '.rotateX', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( farDist_ref[0] + '.rotateY', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( farDist_ref[0] + '.rotateZ', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( farDist_ref[0] + '.scaleX', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( farDist_ref[0] + '.scaleY', lock=True, keyable=False, channelBox=False )
    cmds.setAttr( farDist_ref[0] + '.scaleZ', lock=True, keyable=False, channelBox=False )

    cmds.setAttr( farDist_ref[0] + '.translateZ', keyable=False, channelBox=False )
    cmds.setAttr( farDist_ref[0] + '.visibility', keyable=False, channelBox=False )


    # S01C :: Main DOF Nodes
    samplerInfo = cmds.createNode( 'samplerInfo' )
    # Need the absolute value for scale in this script
    absScale_dist = cmds.createNode( 'distanceBetween', name='absScale_dist' )
    cmds.setAttr( absScale_dist + '.point1Y', 0 )
    cmds.setAttr( absScale_dist + '.point1Z', 0 )
    cmds.setAttr( absScale_dist + '.point2X', 0 )
    cmds.setAttr( absScale_dist + '.point2Y', 0 )
    cmds.setAttr( absScale_dist + '.point2Z', 0 )
    halfScale_MD = cmds.createNode( 'multiplyDivide' )
    cmds.setAttr( halfScale_MD + '.operation', 1 )
    cmds.setAttr( halfScale_MD + '.input2Z', 0.5 )
    addHalfRange_PMA = cmds.createNode( 'plusMinusAverage' )
    cmds.setAttr( addHalfRange_PMA + '.operation', 1 )
    subHalfRange_PMA = cmds.createNode( 'plusMinusAverage' )
    cmds.setAttr( subHalfRange_PMA + '.operation', 2 )
    setRangeNear_sR = cmds.createNode( 'setRange' )
    cmds.setAttr( setRangeNear_sR + '.oldMinZ', 0 )
    cmds.setAttr( setRangeNear_sR + '.minZ', 0 )
    cmds.setAttr( setRangeNear_sR + '.maxZ', 1 )
    farClamp_cla = cmds.createNode( 'clamp' )
    cmds.setAttr( farClamp_cla + '.minB', 0 )
    cmds.setAttr( farClamp_cla + '.maxB', 1 )
    rampNear_ramp = cmds.createNode( 'ramp' )
    cmds.setAttr( rampNear_ramp + '.type', 0 )
    cmds.setAttr( rampNear_ramp + '.colorEntryList[0].color', 0,1,0, type='double3' )
    cmds.setAttr( rampNear_ramp + '.colorEntryList[1].color', 0,0,1, type='double3' )
    cmds.setAttr( rampNear_ramp + '.colorEntryList[0].position', 1 )

    reversePointCamZ_MD = cmds.createNode( 'multiplyDivide' )
    cmds.setAttr( reversePointCamZ_MD + '.operation', 1 )
    cmds.setAttr( reversePointCamZ_MD + '.input2Z', -1 )
    setRangeFar_sR = cmds.createNode( 'setRange' )
    cmds.setAttr( setRangeFar_sR + '.minZ', 0 )
    cmds.setAttr( setRangeFar_sR + '.maxZ', 1 )
    rampFar_ramp = cmds.createNode( 'ramp' )
    cmds.setAttr( rampFar_ramp + '.type', 0 )
    cmds.setAttr( rampFar_ramp + '.colorEntryList[0].color', 0,1,0, type='double3' )
    cmds.setAttr( rampFar_ramp + '.colorEntryList[1].color', 1,0,0, type='double3' )
    cmds.setAttr( rampFar_ramp + '.colorEntryList[1].position', 1 )


    DOF_comp_cond = cmds.createNode( 'condition' )
    cmds.setAttr( DOF_comp_cond + '.operation', 2 )
    DOF_surf = cmds.shadingNode( 'surfaceShader', asShader=True )
    DOF_surfSG = cmds.sets( renderable=True, empty=True, name='DOF_surfSG' );
    cmds.connectAttr( DOF_surf + ".outColor", DOF_surfSG + ".surfaceShader", force=True)


    # This is 'the lonely multiplyDivide' which will be used for baking
    # if the user chooses to bake out the transform for a program like Nuke
    # This multiplyDivide is now set up for the DOF2Nuke Bake if the user later requests it
    D2NBake_transRatio_MD = cmds.createNode( 'multiplyDivide', name='D2NBake_transRatio_MD' )
    cmds.setAttr( D2NBake_transRatio_MD + '.operation', 2 )
    cmds.connectAttr( cameraShape + '.farClipPlane', D2NBake_transRatio_MD + '.input2X' )
    cmds.connectAttr( farDist_ref[0] + '.translateZ', D2NBake_transRatio_MD  + '.input1X' )

    # The value of D2NBake_transRatio_MD must be absolute (no negatives)
    D2NBake_transRatio_dist = cmds.createNode( 'distanceBetween', name='D2NBake_transRatio_dist' )
    cmds.setAttr( D2NBake_transRatio_dist + '.point1Y', 0 )
    cmds.setAttr( D2NBake_transRatio_dist + '.point1Z', 0 )
    cmds.setAttr( D2NBake_transRatio_dist + '.point2X', 0 )
    cmds.setAttr( D2NBake_transRatio_dist + '.point2Y', 0 )
    cmds.setAttr( D2NBake_transRatio_dist + '.point2Z', 0 )
    cmds.connectAttr( D2NBake_transRatio_MD + '.outputX', D2NBake_transRatio_dist  + '.point1X' )

    # S02 :: link all standard DOF Nodes
    cmds.connectAttr( farDist + '.scaleZ', absScale_dist + '.point1X')

    cmds.connectAttr( absScale_dist + '.distance', halfScale_MD + '.input1Z' )

    cmds.connectAttr( focusDistMeasure_distShape + '.distance', addHalfRange_PMA + '.input2D[0].input2Dy' )
    cmds.connectAttr( halfScale_MD + '.outputZ', addHalfRange_PMA + '.input2D[1].input2Dy' )

    cmds.connectAttr( samplerInfo + '.pointCameraZ', reversePointCamZ_MD + '.input1Z' )
    cmds.connectAttr( reversePointCamZ_MD + '.outputZ', addHalfRange_PMA + '.input2D[0].input2Dx' )
    cmds.connectAttr( reversePointCamZ_MD + '.outputZ', setRangeNear_sR + '.valueZ' )
    cmds.connectAttr( reversePointCamZ_MD + '.outputZ', setRangeFar_sR + '.valueZ' )
    cmds.connectAttr( halfScale_MD + '.outputZ', addHalfRange_PMA + '.input2D[1].input2Dx' )

    cmds.connectAttr( focusDistMeasure_distShape + '.distance', subHalfRange_PMA + '.input1D[0]' )
    cmds.connectAttr( halfScale_MD + '.outputZ', subHalfRange_PMA + '.input1D[1]' )

    cmds.connectAttr( addHalfRange_PMA + '.output2Dy', setRangeFar_sR + '.oldMinZ' )
    cmds.connectAttr( subHalfRange_PMA + '.output1D', setRangeNear_sR + '.oldMaxZ' )
    cmds.connectAttr( cameraShape + '.farClipPlane', setRangeFar_sR + '.oldMaxZ' )

    cmds.connectAttr( setRangeNear_sR + '.outValueZ', farClamp_cla + '.inputB' )
    cmds.connectAttr( farClamp_cla + '.outputB', rampNear_ramp + '.vCoord' )
    cmds.connectAttr( setRangeFar_sR + '.outValueZ', rampFar_ramp + '.vCoord' )

    cmds.connectAttr( reversePointCamZ_MD + '.outputZ', DOF_comp_cond + '.firstTerm' )
    cmds.connectAttr( addHalfRange_PMA + '.output2Dy', DOF_comp_cond + '.secondTerm' )
    cmds.connectAttr( rampFar_ramp + '.outColor', DOF_comp_cond + '.colorIfTrue' )
    cmds.connectAttr( rampNear_ramp + '.outColor', DOF_comp_cond + '.colorIfFalse' )

    cmds.connectAttr( DOF_comp_cond + '.outColor', DOF_surf + '.outColor' )

    # S03 :: Add a basic 'on/off' for visibility
    if cmds.objExists(cameraTrans + '.DOFVisibility')==1:
        cmds.setAttr( cameraTrans + '.DOFVisibility', keyable=True )
    else:
        cmds.addAttr( cameraTrans, ln="DOFVisibility", nn="DOF Visibility", at="enum", en="Off:On:" )
        cmds.setAttr( cameraTrans + '.DOFVisibility', keyable=True )

    DOF_visiblity_cond = cmds.createNode( 'condition', name='DOF_visibility_cond' )
    cmds.setAttr( DOF_visiblity_cond + '.operation', 0 )
    cmds.setAttr( DOF_visiblity_cond + '.secondTerm', 1 )
    cmds.setAttr( DOF_visiblity_cond + '.colorIfTrueR', 1 )
    cmds.setAttr( DOF_visiblity_cond + '.colorIfFalseR', 0 )
    cmds.connectAttr( cameraTrans + '.DOFVisibility', DOF_visiblity_cond + '.firstTerm' )
    cmds.connectAttr( DOF_visiblity_cond + '.outColorR', farDist + '.visibility' )
    cmds.connectAttr( DOF_visiblity_cond + '.outColorR', distDim + '.visibility' )
    cmds.setAttr( cameraTrans + '.DOFVisibility', 1 )

    # S04 :: collapse work-nodes into container and parent underneath the camera
    DOF_container = cmds.container( addNode=[ cAll_s[0], cAll_s[1], cAll_s[2], cAll_s[3], cAll_s[4], cAll_s[5], cAll_s[6], cAll_s[7], cAll_s[8], cAll_s[9], cAll_s[10], cAll_s[11], farDistref_pConst[0], absScale_dist, DOF_group, focusDistMeasure_dist, focusDistMeasure_distShape, nearDist, nearDistShape[0], nearDist_pConst[0], farDist_ref[0], farDist_refShape, DOF_visiblity_cond, D2NBake_transRatio_MD, D2NBake_transRatio_dist, samplerInfo,halfScale_MD, focusDistMeasure_dist,addHalfRange_PMA,subHalfRange_PMA,setRangeNear_sR,farClamp_cla,rampNear_ramp,reversePointCamZ_MD,setRangeFar_sR,rampFar_ramp,DOF_comp_cond] )

    # S05 :: message out the container to all external nodes
    #        this will aid in the deletion process
    #        when someone clicks the button more than once.
    cmds.connectAttr( DOF_container + '.message', DOF_surf + '.ihi', f=True )
    cmds.connectAttr( DOF_container + '.message', DOF_surfSG + '.ihi', f=True )
    cmds.connectAttr( DOF_container + '.message', farDist + '.ihi', f=True )

    if DOFCheckConnections != []:
        print '\n\n'
        print 're-initialized DOF_Controller'

    cmds.select( selection )
# end DOF_controller


def D2N_bakeAndCopy():
    """
    Creates a dummy locator, copies all of the animation of the DOF controller
    to it, exports the locator as FBX data, and then resets the scene to before
    the function had been run
    """
     # Get DOF cube locator selection
    selection = cmds.ls( sl=True )
    if len(selection)>=2 or len(selection)==0:
        print '\n\n'
        sys.exit( 'SelectionError: Please select the Depth of Field Cube' )

    DOF_locChildren = cmds.listRelatives( cmds.ls( sl=True ), children=True, noIntermediate=True )

    if DOF_locChildren==[]:
        print '\n\n'
        sys.exit( 'SelectionError: You must select the Depth of Field Cube before running the DOF2Nuke Bake! ' )

    DOF_locatorShape = DOF_locChildren[0]
    DOF_locatorTransform = cmds.listRelatives( DOF_locatorShape, parent=True, noIntermediate=True )

    if DOF_locatorTransform==[]:
        print '\n\n'
        sys.exit( 'SelectionError: Something went wrong. Make sure you selected the DOF locator before running the script' )

    # Get timeRange and filePath
    D2NBake_filePathAndName = cmds.textFieldGrp( 'D2NBake_filePathAndName', query=True, text=True )
    if D2NBake_filePathAndName=="":
        print '\n\n'
        sys.exit( 'Please specify a file path' )

    # AUTHOR NOTE: Find the script you saved that checks if a file path was
    # specified properly then change the slashes to forward
    D2NBake_timeRange_radio = cmds.radioButtonGrp( 'D2NBake_timeRange_radio', query=True, select=1 )
    if D2NBake_timeRange_radio==1:
        D2NBake_timeRange_startFrame = cmds.playbackOptions( query=True, minTime=True )
        D2NBake_timeRange_endFrame = cmds.playbackOptions( query=True, maxTime=True )
    else:
        D2NBake_timeRange_startFrame = cmds.intFieldGrp( 'D2NBake_timeRange_intField', query=True, value1=True )
        D2NBake_timeRange_endFrame = cmds.intFieldGrp( 'D2NBake_timeRange_intField', query=True, value2=True )

    # In the DOF_controller() script, we made a single, lonely multiplyDivide node
    # that would eventually be used to create the D2NBake
    #
    # and then took its value and made it absolute. This node will now be used for
    # ratio of where the controller sits along the camera's clipPlane
    # using the DOF locator as a selection
    D2NBake_loc_TransRatio_temp1 = cmds.listConnections( DOF_locatorTransform, destination=True )
    D2NBake_loc_TransRatio_temp2 = cmds.listConnections( D2NBake_loc_TransRatio_temp1[0], destination=True )
    D2NBake_loc_TransRatio_temp3 = cmds.listConnections( D2NBake_loc_TransRatio_temp2[0], destination=True )
    D2NBake_loc_TransRatio_temp4 = cmds.listConnections( D2NBake_loc_TransRatio_temp3[0], destination=True, p=False )
    D2NBake_loc_TransRatio = D2NBake_loc_TransRatio_temp4[-1]
    print D2NBake_loc_TransRatio

    # Now we need to get a query on the half-scale - again, also for export
    D2NBake_loc_scale = cmds.listConnections( DOF_locatorTransform, destination=True )
    D2NBake_loc_scale = cmds.listConnections( D2NBake_loc_scale[-2], destination=True )
    D2NBake_loc_scale = D2NBake_loc_scale[-1]

    # Create a locator to house the FBX Bake
    # AFAIK FBX can ONLY bake t/r/s so we need to
    # do this to get the percentage distance value out
    #
    # Also, by doing it in a separate transform,
    # When the animation is baked out, we can delete the
    # locator without losing the original file
    D2NBake_locator_ref = cmds.spaceLocator( p=(0,0,0) )
    cmds.connectAttr( D2NBake_loc_TransRatio + '.distance', D2NBake_locator_ref[0] + '.translateX' )
    cmds.connectAttr( D2NBake_loc_scale + '.outputZ', D2NBake_locator_ref[0] + '.scaleX' )

    # Now to bake the animation of the locator
    cmds.bakeResults( D2NBake_locator_ref, simulation=True, time=(D2NBake_timeRange_startFrame,D2NBake_timeRange_endFrame), sampleBy=1, disableImplicitControl=True, preserveOutsideKeys=True, sparseAnimCurveBake=False, removeBakedAttributeFromLayer=False, removeBakedAnimFromLayer=False, bakeOnOverrideLayer=False, minimizeRotation=True, at=["tx","sx"] )

    # Export the dummyLoc to FBX
    cmds.file( D2NBake_filePathAndName, force=True, options="", typ="FBX export", pr=True, es=True )

    # Create a paste-dump for the Nuke script

    # finally, clean the export - delete the UI
    # and delete the locator that we baked to
    cmds.deleteUI( 'D2NBake_timeRange_window' )
    cmds.delete( D2NBake_locator_ref )

def DOF2Nuke():
    """
    Sends the DOF controller directly to Nuke

    .. note::
        Currently WIP. Auto opening Nuke from within a Maya shell has been
        buggy, even after sourcing Nuke's dependency Python files

    """
    # Perform the animation bake on the separate locator
    # Give option to use either the active range slider or specify a custom frame range
    def disable_intFieldGrp( *args ):
        cmds.intFieldGrp( D2NBake_timeRange_intField, e=True, enable=False )
    def enable_intFieldGrp( *args ):
        cmds.intFieldGrp( D2NBake_timeRange_intField, e=True, enable=True )

    D2NBake_timeRange_window = cmds.window( 'D2NBake_timeRange_window', title='Time Range Selection' )
    cmds.columnLayout( adjustableColumn=True, columnAttach=('both',5), height=20, rowSpacing=10 )
    D2NBake_filePathAndName = cmds.textFieldGrp( 'D2NBake_filePathAndName', label='Save FBX to...' )
    D2NBake_timeRange_radio = cmds.radioButtonGrp( 'D2NBake_timeRange_radio', label='Time Range', labelArray2=['Time Slider', 'Custom Time Range'], numberOfRadioButtons=2, select=1, on2=enable_intFieldGrp, of2=disable_intFieldGrp )
    D2NBake_timeRange_intField = cmds.intFieldGrp( 'D2NBake_timeRange_intField', numberOfFields=2, label='Start/End Frame', value1=0, value2=24, enable=False )
    D2NBake_timeRange_button = cmds.button( 'D2NBake_timeRange_button', label='bake and copy to clipboard', command='D2N_bakeAndCopy()' )
    cmds.showWindow( D2NBake_timeRange_window )
# end DOF2Nuke


def c_icon():
    """
    Creates the cheeky "C" icon for people to click

    Returns:
        str: The name of the highest-most node for the c icon
    """
    c_inner = cmds.curve( d=3, p=[[1.697824476190684, 0.0, -0.9084265434084042], [1.6805607808454843, 0.0, -0.898767677967657], [1.6591057446726334, 0.0, -0.8916159992433734], [0.9558573367847394, 0.0, -0.7009045665958089], [0.9320184077037937, 0.0, -0.6985206736877143], [0.9105633715309427, 0.0, -0.6961367807796198], [0.9010277998985645, 0.0, -0.7175918169524708], [0.8962600140823753, 0.0, -0.7461985318496054], [0.8175915481152547, 0.0, -0.9583650006700204], [0.6531029374567304, 0.0, -1.1776831482147196], [0.4743109693496389, 0.0, -1.3135650439761095], [0.29313510833445267, 0.0, -1.3922335099432297], [0.054745817524997034, 0.0, -1.4208402248403644], [-0.20509850945730962, 0.0, -1.3826979383108515], [-0.43872001445057607, 0.0, -1.2682710787223128], [-0.6222797683738568, 0.0, -1.091863003523316], [-0.7796167003080976, 0.0, -0.8415542481733879], [-0.8702046308156908, 0.0, -0.5554870992020411], [-0.910730810253298, 0.0, -0.2575004856902215], [-0.9154985960694871, 0.0, 0.3384727413334176], [-0.8606690591833124, 0.0, 0.7055922491799791], [-0.755777771227152, 0.0, 1.0059627555998931], [-0.6485025903628969, 0.0, 1.1871386166150792], [-0.5102368016934128, 0.0, 1.3277882981926583], [-0.30522201159728085, 0.0, 1.4612863010459534], [-0.11451057894971645, 0.0, 1.5184997308402228], [0.1977793920106705, 0.0, 1.5208836237483174], [0.367035788485384, 0.0, 1.4660540868621426], [0.5482116495005702, 0.0, 1.3587789059978874], [0.715084153067189, 0.0, 1.1823708307988903], [0.8390465842881059, 0.0, 0.9463654328975293], [0.9296345147956989, 0.0, 0.6602982839261826], [0.934402300611888, 0.0, 0.6459949264776151], [0.9391700864280772, 0.0, 0.6340754619371424], [0.9606251226009282, 0.0, 0.6340754619371424], [0.9796962658656846, 0.0, 0.6388432477533315], [1.675792995029295, 0.0, 0.877232538562787], [1.6972480312021458, 0.0, 0.8820003243789762], [1.7163191744669022, 0.0, 0.8891520031032598], [1.7067836028345242, 0.0, 0.9153748250923], [1.6948641382940512, 0.0, 0.9487493258056238], [1.606660100694553, 0.0, 1.222897010236498], [1.4683943120250689, 0.0, 1.5113480521159393], [1.3396640949879624, 0.0, 1.7068272705796934], [1.179943270145627, 0.0, 1.871315881238218], [1.0178385523951974, 0.0, 2.0048138840915133], [0.793752619034309, 0.0, 2.124008529496241], [0.5863539360300825, 0.0, 2.2002931025552663], [0.31935793032349236, 0.0, 2.262274318165725], [-0.18364347328445896, 0.0, 2.259890425257631], [-0.5936730534767221, 0.0, 2.152615244393374], [-0.8988113457128253, 0.0, 1.9881266337348498], [-1.1491201010627536, 0.0, 1.7807279507306242], [-1.3326798549860346, 0.0, 1.5661775890021141], [-1.4757134294717082, 0.0, 1.3420916556412257], [-1.5996758606926251, 0.0, 1.0655600783022574], [-1.6974154699245019, 0.0, 0.6579143910180878], [-1.7546288997187711, 0.0, 0.20974252429631127], [-1.7260221848216366, 0.0, -0.3361689516573422], [-1.659273183394989, 0.0, -0.7104401382281874], [-1.5496141096226395, 0.0, -1.0584885028099922], [-1.380357713147926, 0.0, -1.36601068795419], [-1.149120101062754, 0.0, -1.6592295156498207], [-0.8964274528047311, 0.0, -1.8642443057459526], [-0.6151280896495736, 0.0, -2.0168134518640066], [-0.31714147613775406, 0.0, -2.1145530610958834], [-0.02392264844212367, 0.0, -2.1503114547173015], [0.24307335726446652, 0.0, -2.1455436689011127], [0.5577472211329477, 0.0, -2.109785275279694], [0.8509660488285782, 0.0, -2.009661773139723], [1.1179620545351683, 0.0, -1.8451731624811978], [1.3468157737122453, 0.0, -1.6353905865688771], [1.4731620978412567, 0.0, -1.4661341900941636], [1.6042762077864574, 0.0, -1.1967542914794789], [1.6805607808454832, 0.0, -0.986971715567158], [1.6977512149029381, 0.0, -0.9084881000483197]] )
    c_innerShape = cmds.listRelatives( c_inner, children=True, noIntermediate=True )
    c_outer1 = cmds.circle( ch=True, o=True, nr=[0,1,0], s=12, r=2.7 )
    c_outer1Shape = cmds.listRelatives( c_outer1, children=True, noIntermediate=True )
    c_outer2 = cmds.circle( ch=True, o=True, nr=[0,1,0], s=12, r=2.9 )

    cmds.makeIdentity( c_inner, apply=True, t=1, r=1, s=1, n=0, pn=1 )
    cmds.makeIdentity( c_outer1[0], apply=True, t=1, r=1, s=1, n=0, pn=1 )
    cmds.makeIdentity( c_outer2[0], apply=True, t=1, r=1, s=1, n=0, pn=1 )

    c_iconShape = cmds.parent( c_innerShape[0], c_outer1Shape[0], c_outer2[0], s=True, r=True )
    c_icon = cmds.listRelatives( c_iconShape[0], parent=True, noIntermediate=True )
    mel.eval( 'DeleteHistory ' + c_icon[0] )

    return c_icon
# end c_icon


def r_icon():
    """
    Creates a "r" icon in the Maya viewport

    Returns:
        str: The name of the highest-most Maya node for the R icon
    """
    r_inner1 = cmds.curve( d=3, p=[[-0.9824506865070561, 0.0, -1.4188835217593194], [-0.9824506865070561, 0.0, -1.3963399997687826], [-0.9824506865070561, 0.0, -1.3813109851084224], [-0.9824506865070561, 0.0, -0.3756194207527628], [-0.9824506865070561, 0.0, -0.33929930199022884], [-0.9824506865070561, 0.0, -0.3342896304367766], [-0.9724313434001507, 0.0, -0.3342896304367766], [-0.09198156788080969, 0.0, -0.3342896304367766], [0.2674623660794334, 0.0, -0.35558073453895034], [0.3914517370273918, 0.0, -0.39816294274329955], [0.5129362721986237, 0.0, -0.5083757169192626], [0.5868289276120534, 0.0, -0.6160836553184996], [0.6269063000396764, 0.0, -0.7388206083780933], [0.6419353147000351, 0.0, -0.8440237110006041], [0.6344208073698556, 0.0, -1.0005759470460056], [0.5968482707189592, 0.0, -1.1446040042077765], [0.5229556153055295, 0.0, -1.2573216141604657], [0.41399525901792966, 0.0, -1.338728776904075], [0.2549381871958011, 0.0, -1.4051069249873276], [0.08586177226676694, 0.0, -1.4226407754244121], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323], [-0.9824506865070561, 0.0, -1.418883521759323]] )
    r_inner1Shape = cmds.listRelatives( r_inner1, children=True, noIntermediate=True )
    r_inner2 = cmds.curve( d=3, p=[[-1.7746838763198456, 0.0, -2.137051968234829], [-1.7770200514363734, 0.0, -2.048277313806768], [-1.7793562265529015, 0.0, -1.8567109542514757], [-1.776633172657427, 0.0, 2.120747632140758], [-1.776633172657427, 0.0, 2.1302282594637827], [-1.7728409217282173, 0.0, 2.13307244766069], [-1.759568043475983, 0.0, 2.13307244766069], [-1.0068062340278547, 0.0, 2.13307244766069], [-0.9992217321694352, 0.0, 2.134020510392994], [-0.9935333557756206, 0.0, 2.133072447660691], [-0.9887930421141085, 0.0, 2.1254879458022717], [-0.987844979381806, 0.0, 2.1179034439438524], [-0.987844979381806, 0.0, 0.3794981810648377], [-0.9873345799170095, 0.0, 0.3702623350148819], [-0.9873345799170095, 0.0, 0.36333545047741556], [-0.9815621761357871, 0.0, 0.36333545047741556], [-0.9677084070608535, 0.0, 0.3621809697211704], [-0.6144372956500479, 0.0, 0.3621809697211704], [-0.45973687431328963, 0.0, 0.37603473879610494], [-0.2981095684390647, 0.0, 0.4580028724894616], [-0.19305181962081863, 0.0, 0.5376620446703297], [-0.03488795601532718, 0.0, 0.7500865038193112], [0.8231776472852974, 0.0, 2.123208925955062], [0.8319143043547474, 0.0, 2.135828541722045], [0.8435631804473478, 0.0, 2.1416529797683452], [0.8610364945862481, 0.0, 2.1416529797683452], [1.750234036321401, 0.0, 2.1416529797683452], [1.7628536520883846, 0.0, 2.1406822400939616], [1.772561048832218, 0.0, 2.138740760745195], [1.7793562265529015, 0.0, 2.1309748433501285], [1.777414747204135, 0.0, 2.1183552275831445], [0.9796378845879636, 0.0, 0.7674531728990752], [0.8527177905610239, 0.0, 0.60499545254459], [0.7562585191005493, 0.0, 0.5017671094026781], [0.6225693533921719, 0.0, 0.3866928908182521], [0.46857297263948405, 0.0, 0.2733109401541851], [0.45841936511732895, 0.0, 0.26992640431346704], [0.4533425613562512, 0.0, 0.2665418684727481], [0.45841936511732895, 0.0, 0.25977279679131193], [0.5718013157813953, 0.0, 0.23100424214520743], [0.8442564509592279, 0.0, 0.12777589900329378], [1.057482208924488, 0.0, -0.005913266705083409], [1.2571698235268738, 0.0, -0.2140622209092733], [1.390858989235251, 0.0, -0.47128694480387345], [1.4636265098106964, 0.0, -0.769126098787094], [1.4653187777310557, 0.0, -1.1295791658236052], [1.401012596757406, 0.0, -1.4155724443643116], [1.2972834633073849, 0.0, -1.6211653513918662], [1.1541851535214593, 0.0, -1.8194161347411164], [0.9708404441082419, 0.0, -1.9625144445270433], [0.7427775128869225, 0.0, -2.0623851398984705], [0.4297499602302104, 0.0, -2.1356905501939316], [0.24640525081699316, 0.0, -2.1416529797683452], [-1.774691161300569, 0.0, -2.137099781215616]] )
    r_inner2Shape = cmds.listRelatives( r_inner2, children=True, noIntermediate=True )
    r_outer1 = cmds.circle( ch=True, o=True, nr=[0,1,0], s=12, r=2.7 )
    r_outer1Shape = cmds.listRelatives( r_outer1, children=True, noIntermediate=True )
    r_outer2 = cmds.circle( ch=True, o=True, nr=[0,1,0], s=12, r=2.9 )

    cmds.setAttr( r_inner1 + '.scale', 0.935,0.935,0.935, type='double3' )
    cmds.setAttr( r_inner2 + '.scale', 0.935,0.935,0.935, type='double3' )
    cmds.setAttr( r_outer1[0] + '.translate', -0.027,0,0.013, type='double3' )
    cmds.setAttr( r_outer2[0] + '.translate', -0.027,0,0.013, type='double3' )

    cmds.makeIdentity( r_inner1, apply=True, t=1, r=1, s=1, n=0, pn=1 )
    cmds.makeIdentity( r_inner2, apply=True, t=1, r=1, s=1, n=0, pn=1 )
    cmds.makeIdentity( r_outer1[0], apply=True, t=1, r=1, s=1, n=0, pn=1 )
    cmds.makeIdentity( r_outer2[0], apply=True, t=1, r=1, s=1, n=0, pn=1 )

    r_iconShape = cmds.parent( r_inner1Shape[0], r_inner2Shape[0], r_outer1Shape[0], r_outer2[0], s=True, r=True )
    r_icon = cmds.listRelatives( r_iconShape[0], parent=True, noIntermediate=True )
    mel.eval( 'DeleteHistory ' + r_icon[0] )

    return r_icon
# end r_icon


widgets= {}
def UI():
    """
    Creates and docks the main UI for the camera script tool, as well as
    deletes the UI if it already exists in the scene
    """
    if cmds.dockControl('ck_cam_toolDock',exists=1):
        cmds.deleteUI('ck_cam_toolDock')
    if cmds.window('D2NBake_timeRange_window', exists=1):
        cmds.deleteUI('D2NBake_timeRange_window')
    if cmds.window('RWN_textOption', exists=1):
        cmds.deleteUI('RWN_textOption')


    widgets['window'] = cmds.window()

    # Tab filter
    widgets['menuLyt'] = cmds.menuBarLayout()
    widgets['tabsMenu'] = cmds.menu( 'tabsMenuRBs', label='Filter Tabs', to=0 )
    #widgets['helpMenu'] = cmds.menu( 'helpMenuRBs', label='Help', to=0 )

    widgets['tabsRadioC'] = cmds.radioMenuItemCollection()



    cmds.menuItem('Modify', rb=1, command=tabsFunc )
    # shake? AUTHOR NOTE: Frustum must implement shake before
    # I can safely add this feature!

    cmds.menuItem('Create', rb=1,
        command=tabsFunc )
    # Full camera rig
    # cf_makeCameraPerspective - creates camera from active panel(?)
    # seperate calls for frustum, DOF, coverage Internactive, thirds
    cmds.menuItem('DOF', rb=1,
        command=tabsFunc )
    # Create and export to Nuke option
    cmds.menuItem('Camera Frustum', rb=1,
        command=tabsFunc )
    # Camera Frustum - Needs UV options as well


    # AUTHOR NOTE: How to get what resolution gate a camera has and then set it in the UI upon selection?
    # AUTHOR NOTE: How to get what safety of a camera has and then set it in the UI upon selection?

    # MAIN
    cmds.scrollLayout( cr=1 )
    widgets['mainLayout'] = cmds.columnLayout(adj=1)

    # FrameLayout for Create
    widgets['frameLayout_02'] = cmds.frameLayout( label='Create', collapsable=1, w=300, bs='etchedIn', mh=0, parent=widgets['mainLayout'] )
    widgets['formLayout_02'] = cmds.formLayout()

    createWidth=120
    createHeight=30
    widgets['create_fullCam'] = cmds.button( label='Create a new camera', c='createNewCam()', width=createWidth )
    widgets['create_frustum'] = cmds.button( label='Create camera frustum', c='cameraFrustum_make()', width=createWidth)
    widgets['create_DOF'] = cmds.button( label='Create DOF control', c='DOF_controller()', width=createWidth )
    widgets['create_D2NBake'] = cmds.button( label='Bake DOF to Nuke', c='DOF2Nuke()', width=createWidth )
    cmds.setParent('..')
    cmds.setParent('..')
    cmds.setParent('..')

    # FrameLayout for Modify
    widgets['frameLayout_01'] = cmds.frameLayout( label='Modify', collapsable=1, bs='etchedIn', mh=0, parent=widgets['mainLayout'] )
    widgets['formLayout_01'] = cmds.formLayout( parent=widgets['frameLayout_01'] )

    # Help line
    #widgets['frameLayout_helpLine'] = cmds.frameLayout()
    widgets['helpLine'] = cmds.helpLine( w=210 )


    # Toggle switch widgets
    widgets['lookThruTdesc'] = cmds.text( label='Look Thru Selected',fn='smallPlainLabelFont')
    widgets['textTog'] = cmds.textField( 'textTog',ed=0,w=60, bgc=(0.18,0.18,0.18) )
    widgets['onOffText'] = cmds.text( label=' ON    OFF',fn='smallBoldLabelFont' )
    widgets['lookThruClean'] = cmds.button(l='',w=30,h=18,ann='0',command='toggleBttn(widgets["lookThruClean"],widgets["formLayout_01"],0,7,320,350)' )

    widgets['cameraTextSL'] = cmds.textScrollList( selectCommand='switchCamera()', width=150, h=110 )
    #populateTextSL() dies properly but checkForCamera() lives even after window is closed. Why?
    #check all jobs in a scene: jobs = cmds.scriptJob( listJobs=True )
    cmds.scriptJob( event=('DagObjectCreated', 'checkForCamera()'), parent=widgets['window'], kws=True )
    cmds.scriptJob( event=('NameChanged', 'populateTextSL()'), parent=widgets['window'], kws=True )

    widgets['rowLayout_01_1'] = cmds.rowLayout( numberOfColumns=2, adjustableColumn=2 )
    widgets['panZoomEnable'] = cmds.checkBox( label='Pan Zoom Enable', onc='panZoomEnableCmd(1)', ofc='panZoomEnableCmd(0)' )
    widgets['panZoomReset'] = cmds.button( label='Reset', w=90, c='resetCamControls()' )
    cmds.setParent('..')

    widgets['sepBtm'] = cmds.separator( w=315,height=5, style='out' )

    widgets['rowLayout_01_2'] = cmds.rowLayout( numberOfColumns=3, adjustableColumn=3, en=False )
    widgets['zoomText'] = cmds.text( label='zoom : ',  w=70 )
    widgets['zoomField'] = cmds.floatField( w=50, h=15 )
    widgets['zoomSlider'] = cmds.floatSlider( h=15, min=0.1, max=5, step=0.01 )
    cmds.setParent('..')
    widgets['rowLayout_01_3'] = cmds.rowLayout( numberOfColumns=3, adjustableColumn=3, en=False )
    widgets['horiText'] = cmds.text( l="horizontal : ", w=70 )
    widgets['horiField'] = cmds.floatField( w=50, h=15 )
    widgets['horiSlider'] = cmds.floatSlider( h=15, min=-1, max=1, step=0.1 )
    cmds.setParent('..')
    widgets['rowLayout_01_4'] = cmds.rowLayout( numberOfColumns=3, adjustableColumn=3, en=False )
    widgets['vertiText'] = cmds.text( l="vertical : ", w=70 )
    widgets['vertiField'] = cmds.floatField( w=50, h=15 )
    widgets['vertiSlider'] = cmds.floatSlider( h=15, min=-1, max=1, step=0.1 )
    cmds.setParent('..')
    widgets['rowLayout_01_5'] = cmds.rowLayout( numberOfColumns=3, adjustableColumn=3 )
    widgets['nearClipText'] = cmds.text( l="Near Clip : ", w=70 )
    widgets['nearClipField'] = cmds.floatField( w=50, h=15, s=1 )
    widgets['nearClipSlider'] = cmds.floatSlider( h=15, min=0.001 )
    cmds.setParent('..')
    widgets['rowLayout_01_6'] = cmds.rowLayout( numberOfColumns=3, adjustableColumn=3 )
    widgets['farClipText'] = cmds.text( l="Far Clip : ", w=70 )
    widgets['farClipField'] = cmds.floatField( w=50, h=15 )
    widgets['farClipSlider'] = cmds.floatSlider( h=15 )
    cmds.setParent('..')

    widgets['frameLayout_01_1'] = cmds.frameLayout( label='Camera Gate\Safety Overlay', collapsable=1, collapse=False, w=350 )
    cmds.rowColumnLayout( nc=2, cw=[(1,110),(2,200)], cal=[(1,'center'),(2,'center')] )
    cmds.rowColumnLayout( nc=1, cw=(1,120), co=(1,'left',4), cal=(1,'center') )
    cmds.radioCollection()
    cmds.radioButton( 'noGate', l='No Gate', onc='gate(\'noGate\')' )
    cmds.radioButton( 'filmGate', l='Film Gate', onc='gate(\'filmGate\')' )
    cmds.radioButton( 'resGate', l='Resolution Gate', onc='gate(\'resGate\')' )
    cmds.setParent('..')

    cmds.rowColumnLayout( nc=1, co=(1,'left',50), cal=(1,'left') )
    cmds.checkBox( l='Safe Action', onc='safe(1,0)', ofc='safe(0,0)' )
    cmds.checkBox( l='Safe Title', onc='safe(1,1)', ofc='safe(0,1)' )
    cmds.text( l='Be sure to select a camera first' )
    cmds.setParent('..')
    cmds.setParent('..')

    widgets['sepBtm'] = cmds.separator( w=315,height=5, style='none' )
    cmds.setParent('..')

    # Frame Layout for Camera Coverage
    widgets['frameLayout_03'] = cmds.frameLayout( label='Camera Coverage Bake', collapsable=1, collapse=False, w=300, bs='etchedIn', mh=0, parent=widgets['mainLayout'] )
    widgets['formLayout_03'] = cmds.formLayout()

    # widgets['camCov_formLayout_01'] = cmds.formLayout()
    #widgets['camCov_columnLayout_01'] = cmds.columnLayout()
    #cmds.separator( height=10 )
    widgets['camCov_text_01'] = cmds.text( label='Please select geometry, then camera', fn='smallPlainLabelFont')
    #cmds.separator( height=10 )
    widgets['camCov_timeRangeIntFG'] = cmds.intFieldGrp( 'timeRange', numberOfFields=2, label='Time Range', value1=0, value2=24, cal=[(1,'right'), (2,'left'), (3,'left')], cw=[(1,140),(2,53),(3,53)] )
    widgets['camCov_outFormatOM'] = cmds.optionMenu( 'outputFormat', l='Extension ', width=122 )
    #widgets['camCov_outFormatOM'] = cmds.optionMenu( 'outputFormat', l='             .ext' )

    cmds.menuItem( l='jpg' )
    cmds.menuItem( l='tiff' )
    widgets['camCov_txRes'] = cmds.optionMenu( 'txRes', label='Resolution', width=122 )
    cmds.menuItem( label='256' )
    cmds.menuItem( label='512' )
    cmds.menuItem( label='1024' )
    cmds.menuItem( label='2048' )

    widgets['camCov_textFilePrefix'] = cmds.textFieldGrp( 'filePrefix', label='File Prefix   ', text='covBake_', width=250 )
    widgets['camCov_postExeCmd_RG'] = cmds.radioButtonGrp( 'postExeCommand', label='Post Execution Command', labelArray2=['Delete Nodes','Keep Nodes'], numberOfRadioButtons=2, cw=[(2,115)], select=True )
    widgets['camCov_uvOptimize_RG'] = cmds.radioButtonGrp( 'uvOptimization', label='UV Optimization', labelArray2=['Off','On'], numberOfRadioButtons=2, cw=[(2,115)], en2=True, select=True )

    widgets['camCov_shrinkSlider'] = cmds.intSliderGrp( 'camCov_shrinkSlider', label='Shrink UVs', field=True, value=1, min=0, max=5, cw=(3,115) )
    widgets['camCov_growSlider'] = cmds.intSliderGrp( 'camCov_growSlider', label='Grow UVs', field=True, value=2, min=0, max=5, cw=(3,115) )

    widgets['camCov_button'] = cmds.button( label='Generate Coverage Bake', command='cameraCoverage_bake()', backgroundColor=(1.0,0.0,0.0), width=300, align='left' )
    widgets['sep_bttm_none'] = cmds.separator( style='none', height=25 )
    cmds.setParent('..')
    cmds.setParent('..')


    widgets['formLayout_renderBttn'] = cmds.formLayout()
    widgets['sep_Bttm_doubleD'] = cmds.separator( width=400, height=30, style='in' )
    renderWithNotesWidth = 400
    renderWithNotesHeight = 40
    widgets['render_bttn'] = cmds.button( label='', c='renderWithNotes()', width=renderWithNotesWidth, height=renderWithNotesHeight, align='center' )
    # AUTHOR NOTE: Can't click when directly over text. Fix!
    widgets['render_bttnText'] = cmds.text( label='Render with Notes', fn='boldLabelFont', width=renderWithNotesWidth-280, height=renderWithNotesHeight-30, align='left', nbg=0, ut=1 )
    cmds.setParent('..')

    #widgets['zoomSlider'] = cmds.floatSlider( h=15, min=0.1, step=0.1 )














    # Assemble widgets to layout

    # render buttonwidgets['sep_bttm_none']

    """
    widgets['mainLayout'] = cmds.columnLayout(adj=1)

    # FrameLayout for Modify
    widgets['frameLayout_01'] = cmds.frameLayout( label='Modify', collapsable=1, bs='etchedIn', mh=0, parent=widgets['mainLayout'] )
    widgets['formLayout_01'] = cmds.formLayout()
    """
    #cmds.formLayout(widgets['frameLayout_01'],e=1,af=[ (widgets['render_bttn'],'top',20+15+200), (widgets['render_bttn'],'left',0) ] )


    # Modify Menu (formLayout_01)
    cmds.formLayout(widgets['formLayout_01'],e=1,af=[ (widgets['helpLine'],'top',5), (widgets['helpLine'],'left',0) ])

    cmds.formLayout(widgets['formLayout_01'],e=1,af=[ (widgets['lookThruTdesc'],'top',4+5), (widgets['lookThruTdesc'],'left',230) ])
    cmds.formLayout(widgets['formLayout_01'],e=1,af=[ (widgets['textTog'],'top',5), (widgets['textTog'],'left',90+230) ])
    cmds.formLayout(widgets['formLayout_01'],e=1,af=[ (widgets['onOffText'],'top',4+5), (widgets['onOffText'],'left',5+90+230) ])
    #Default button position - to fix display Bug
    cmds.formLayout( widgets['formLayout_01'], e=1, af=[ (widgets['lookThruClean'],'top',2+5), (widgets['lookThruClean'],'left',90+260)] )

    cmds.formLayout(widgets['formLayout_01'],e=1,af=[ (widgets['cameraTextSL'],'top',25+5), (widgets['cameraTextSL'],'left',230) ])
    cmds.formLayout(widgets['formLayout_01'],e=1,af=[ (widgets['rowLayout_01_1'],'top',25+5), (widgets['rowLayout_01_1'],'left',10) ])
    cmds.formLayout(widgets['formLayout_01'],e=1,af=[ (widgets['rowLayout_01_2'],'top',25+34), (widgets['rowLayout_01_2'],'left',10) ])
    cmds.formLayout(widgets['formLayout_01'],e=1,af=[ (widgets['rowLayout_01_3'],'top',25+50), (widgets['rowLayout_01_3'],'left',10) ])
    cmds.formLayout(widgets['formLayout_01'],e=1,af=[ (widgets['rowLayout_01_4'],'top',25+66), (widgets['rowLayout_01_4'],'left',10) ])
    cmds.formLayout(widgets['formLayout_01'],e=1,af=[ (widgets['rowLayout_01_5'],'top',25+82), (widgets['rowLayout_01_5'],'left',10) ])
    cmds.formLayout(widgets['formLayout_01'],e=1,af=[ (widgets['rowLayout_01_6'],'top',25+98), (widgets['rowLayout_01_6'],'left',10) ])
    cmds.formLayout(widgets['formLayout_01'],e=1,af=[ (widgets['frameLayout_01_1'],'top',25+125), (widgets['frameLayout_01_1'],'left',10) ])


    # Create Menu (formLayout_02)
    cmds.formLayout(widgets['formLayout_02'],e=1,af=[ (widgets['create_fullCam'],'top',12), (widgets['create_fullCam'],'left',10) ])
    cmds.formLayout(widgets['formLayout_02'],e=1,af=[ (widgets['create_frustum'],'top',12+createHeight), (widgets['create_frustum'],'left',10) ])

    cmds.formLayout(widgets['formLayout_02'],e=1,af=[ (widgets['create_DOF'],'top',12), (widgets['create_DOF'],'left',60+createWidth) ])
    cmds.formLayout(widgets['formLayout_02'],e=1,af=[ (widgets['create_D2NBake'],'top',12+createHeight), (widgets['create_D2NBake'],'left',60+createWidth) ])

    #cmds.formLayout(widgets['formLayout_02'],e=1,af=[ (widgets['a'],'top',25+125), (widgets['a'],'left',10) ])



    # Camera Coverage Menu (formLayout_03)
    #cmds.formLayout( widgets['formLayout_03'],e=1,af=[(widgets['camCov_columnLayout_01'],'top',5), (widgets['camCov_columnLayout_01'],'left',5)] )
    #widgets['camCov_columnLayout_01']
    #widgets['camCov_formLayout_01'] = cmds.formLayout()
    cmds.formLayout( widgets['formLayout_03'],e=1,af=[(widgets['camCov_text_01'],'top',60+10), (widgets['camCov_text_01'],'left',108)] )
    #timeRangeIntFG form left issues - had to put in arbitrary negative numbers
    cmds.formLayout( widgets['formLayout_03'],e=1,af=[(widgets['camCov_timeRangeIntFG'],'top',40+15+22+16), (widgets['camCov_timeRangeIntFG'],'left',-70)] )
    #textFilePrefix form left issues - had to put in arbitrary negative numbers
    cmds.formLayout( widgets['formLayout_03'],e=1,af=[(widgets['camCov_textFilePrefix'],'top',40+15+22+38), (widgets['camCov_textFilePrefix'],'left',-70)] )
    cmds.formLayout( widgets['formLayout_03'],e=1,af=[(widgets['camCov_txRes'],'top',40+15+22+16), (widgets['camCov_txRes'],'left',220)] )
    cmds.formLayout( widgets['formLayout_03'],e=1,af=[(widgets['camCov_outFormatOM'],'top',40+15+22+38), (widgets['camCov_outFormatOM'],'left',220)] )


    cmds.formLayout( widgets['formLayout_03'],e=1,af=[(widgets['camCov_postExeCmd_RG'],'top',40+20+15+80), (widgets['camCov_postExeCmd_RG'],'left',0)] )
    cmds.formLayout( widgets['formLayout_03'],e=1,af=[(widgets['camCov_uvOptimize_RG'],'top',40+20+15+96), (widgets['camCov_uvOptimize_RG'],'left',0)] )
    cmds.formLayout( widgets['formLayout_03'],e=1,af=[(widgets['camCov_shrinkSlider'],'top',40+20+15+114), (widgets['camCov_shrinkSlider'],'left',0)] )
    cmds.formLayout( widgets['formLayout_03'],e=1,af=[(widgets['camCov_growSlider'],'top',40+20+15+136), (widgets['camCov_growSlider'],'left',0)] )
    cmds.formLayout( widgets['formLayout_03'],e=1,af=[(widgets['camCov_button'],'top',40+20+15+165), (widgets['camCov_button'],'left',40)] )
    cmds.formLayout( widgets['formLayout_03'],e=1,af=[(widgets['sep_bttm_none'],'top',10+40+20+15+165), (widgets['sep_bttm_none'],'left',40)] )

    #cmds.formLayout( widgets['formLayout_03'],e=1,af=[(widgets['render_bttn'],'top',20+15+450), (widgets['render_bttn'],'left',0)] )

    # Render Section Menu
    cmds.formLayout( widgets['formLayout_renderBttn'],e=1,af=[(widgets['render_bttn'],'top',40+33), (widgets['render_bttn'],'left',0)] )
    #cmds.formLayout( widgets['formLayout_renderBttn'],e=1,af=[(widgets['render_bttnText'],'top',40+33), (widgets['render_bttnText'],'left',0)] )

    # AUTHOR NOTE: If time, go back and change formatting so its spacing between 'Camera Coverage Bake' shortens depending on if the frame is collapsed
    cmds.formLayout( widgets['formLayout_renderBttn'],e=1,af=[(widgets['render_bttnText'],'top',40+48), (widgets['render_bttnText'],'left',140)] )

    """
       widgets['mainLayout'] = cmds.columnLayout(adj=1)

    # FrameLayout for Modify
    widgets['frameLayout_01'] = cmds.frameLayout( label='Modify', collapsable=1, bs='etchedIn', mh=0, parent=widgets['mainLayout'] )
    widgets['formLayout_01'] = cmds.formLayout( parent=widgets['mainLayout'] )
    """
    #cmds.formLayout( widgets['formLayout_03'],e=1,af=[(widgets['render_bttnText'],'top',20+15+165), (widgets['render_bttnText'],'left',0)] )

    #widgets['render_bttnText'] = cmds.text( label='Render with Notes', fn='boldLabelFont', width=renderWithNotesWidth, height=renderWithNotesHeight )
    #widgets['render_bttn']
    # Refresh bug
    cmds.dockControl('dockControl1',e=1, r=1 )

    # Show dock with camera list already populated
    widgets['dockPanel'] = cmds.dockControl( 'ck_cam_toolDock', label='Camera Tools', area='right', w=400, content=widgets['window'], aa='right', sizeable=0, vis=True )
    populateTextSL()
# end UI


if __name__ == "__main__":
    UI()

