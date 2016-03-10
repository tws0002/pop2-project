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
# @file xgRampWidget.py
# @brief Contains PySide Ramp Widget to emulate Maya's ramp widget
#
# <b>CONFIDENTIAL INFORMATION: This software is the confidential and
# proprietary information of Walt Disney Animation Studios ("WDAS").
# This software may not be used, disclosed, reproduced or distributed
# for any purpose without prior written authorization and license
# from WDAS. Reproduction of any section of this software must include
# this legend and all copyright notices.
# Copyright Disney Enterprises, Inc. All rights reserved.</b>
#
# @author Arthur Shek
# @author Thomas V Thompson II
#
# @version Created 05/04/09
#

import os
import sys
import string
from PySide import QtGui, QtCore
from xgenm.ui.util.xgComboBox import _ComboBoxUI


class InterpTypes:
    """This class stores interpolation types for access as an enum
    """
    kFlat   = 0
    kLinear = 1
    kSmooth = 2
    kSpline = 3


class RampCurve:
    """This class stores the representation of a ramp curve and
    functions to operate on the curve

    The main data representation is the 'cv' list, which is a
    Python list of all the cv points.  Each point is itself
    represented as a 3 member list, consisting of param, value
    and interpolation type.
    """

    def __init__(self):
        self.clear()

    def clear(self):
        self.cv = []

    def sortPoints(self):
        self.cv.sort()

    def numPoints(self):
        return len(self.cv)

    def getPoint(self, item):
        return self.cv[item]

    def modifyPoint(self, item, param, value, interp):
        self.cv[item] = [param, value, interp]

    def addPoint(self, param, value, interp):
        """Adds a point to the curve data.  Return the new point
        position in the cv list for selection knowledge."""
        self.cv.append([param, value, interp])
        self.sortPoints()
        for i in range(len(self.cv)):
            pt = self.cv[i]
            if param == pt[0]:
                return i
        return -1

    def removePoint(self, item):
        del self.cv[item]

    def movePoint(self, item, param, value):
        """Move a point to another param and value location."""
        self.cv[item][0] = param
        self.cv[item][1] = value

    def hasZeroPoint(self):
        for i in range(len(self.cv)):
            pt = self.cv[i]
            if pt[0] == 0.0:
                return True
        return False

    def hasOnePoint(self):
        for i in range(len(self.cv)):
            pt = self.cv[i]
            if pt[0] == 1.0:
                return True
        return False

    def getValue(self, param):
        """Gets the value at any param on the curve.  Code stolen
        liberally from XGen SgCurve class."""
        
        value = 0

        found = False
        upperBoundIdx = -1
        self.sortedData = sorted(self.cv) # always operate on sorted data
        if not len(self.sortedData): return value

        # find the cv data point index just greater than the desired param
        for i in range(len(self.sortedData)):
            pt = self.sortedData[i]
            if pt[0] > param:
                upperBoundIdx = i
                found = True
                break

        if found:
            if upperBoundIdx == 0:
                # the given param is below than our curve range, so
                # return the first value
                value = self.sortedData[0][1]
            else:
                k1 = self.sortedData[upperBoundIdx][1]
                t1 = self.sortedData[upperBoundIdx][0]
                upperBoundIdx = upperBoundIdx-1
                k0 = self.sortedData[upperBoundIdx][1]
                t0 = self.sortedData[upperBoundIdx][0]
                interpType = self.sortedData[upperBoundIdx][2]
                if interpType == InterpTypes.kFlat:
                    value = k0
                elif interpType == InterpTypes.kLinear:
                    u = (param-t0)/(t1-t0)
                    value = k0 + u*(k1-k0)
                elif interpType == InterpTypes.kSmooth:
                    # standard cubic interpolation
                    u = (param-t0)/(t1-t0)
                    value = k0*(u-1)*(u-1)*(2*u+1) + k1*u*u*(3 - 2*u)
                elif interpType == InterpTypes.kSpline:
                    # catmull-rom spline interpolation
                    scale = 1.0/(t1-t0)
                    u = (param-t0)*scale
                    k0p = 0
                    if not upperBoundIdx == 0:
                        upperBoundIdx=upperBoundIdx-1
                        k0p = 0.5 * ((k1-self.sortedData[upperBoundIdx][1]) /
                              (scale * (t1-self.sortedData[upperBoundIdx][0])))
                        upperBoundIdx=upperBoundIdx+1
                    else:
                        k0p = ((k1-k0) / (scale * (2*t1-2*t0)))
                    upperBoundIdx=upperBoundIdx+1
                    upperBoundIdx=upperBoundIdx+1
                    k1p = 0
                    if not upperBoundIdx == len(self.sortedData):
                        k1p = 0.5 * ((self.sortedData[upperBoundIdx][1]-k0) /
                              (scale * (self.sortedData[upperBoundIdx][0]-t0)))
                    else:
                        k1p = ((k1-k0) / (scale * (2*t1-2*t0)))
                    value = (k0*(u-1)*(u-1)*(2*u+1) + k1*u*u*(3 - 2*u) + 
                         k0p*u*(u-1)*(u-1) + k1p*u*u*(u - 1));
        else:
            # the given param is past the end of our curve points, so
            # return the last value
            value = self.sortedData[len(self.sortedData)-1][1]

        if value < 0.0:
            value = 0.0
        elif value > 1.0:
            value = 1.0
        return value


class RampGraphicsView(QtGui.QGraphicsView):
    """This class overrides QGraphicsView so we can get resize events
    """

    def __init__(self):
        QtGui.QGraphicsView.__init__(self)

    resizeSignal = QtCore.Signal([int,int])

    def resizeEvent(self, event):
        self.resizeSignal.emit(event.size().width(), event.size().height())

# Derived Classes for the Graphic Items
# Helpful to put a break point on the descructor
#class RampEllipseItem(QtGui.QGraphicsEllipseItem):
#    def __init__(self, parent=None, scene=None):
#        QtGui.QGraphicsEllipseItem.__init__(self,parent,scene)
#    def __init__(self, rect, parent=None, scene=None):
#        QtGui.QGraphicsEllipseItem.__init__(self,rect,parent,scene)
#    def __init__(self, x, y, w, h, parent=None, scene=None):
#        QtGui.QGraphicsEllipseItem.__init__(self,x, y, w, h,parent,scene)
#    def __del__(self):
#        a=0
#class RampRectItem(QtGui.QGraphicsRectItem):
#    def __init__(self, parent=None, scene=None):
#        QtGui.QGraphicsRectItem.__init__(self,parent,scene)
#    def __init__(self, rect, parent=None, scene=None):
#        QtGui.QGraphicsRectItem.__init__(self,rect,parent,scene)
#    def __init__(self, x, y, w, h, parent=None, scene=None):
#        QtGui.QGraphicsRectItem.__init__(self,x, y, w, h,parent,scene)
#    def __del__(self):
#        a=0
#class RampPolygonItem(QtGui.QGraphicsPolygonItem):
#    def __init__(self, parent=None, scene=None):
#        QtGui.QGraphicsPolygonItem.__init__(self,parent,scene)
#    def __init__(self, polygon, parent=None, scene=None):
#        QtGui.QGraphicsPolygonItem.__init__(self,polygon,parent,scene)
#    def __del__(self):
#        a=0

class MouseState:
    kNoState    = 0
    kMoving     = 1
    kReleased   = 2

class CurveScene(QtGui.QGraphicsScene):
    """This class overrides QGraphicsScene so we can handle mouse
    press, drag and keyboard events
    """

    POLY_ZORDER=1
    POINTS_ZORDER=2
    SPLINEHINTS_ZORDER=3

    cvSelected = QtCore.Signal(float,float,int)
    pointAdded = QtCore.Signal(float,float,int)
    pointRemoved = QtCore.Signal(int)
    pointChanged = QtCore.Signal(int,float,float,int)
    pointMoving = QtCore.Signal()
    
    def __init__(self, rampCurve = None, width=320, height=170):
        QtGui.QGraphicsScene.__init__(self)
        self.width              = width                  # width of graphics scene
        self.height             = height                 # height of graphics scene
        self.defaultInterp      = InterpTypes.kLinear    # default interpolation
        self.circleObjects      = []                     # drawn cv points
        self.rectObjects        = []                     # drawn cv delete points
        self.crossLineObjects   = []
        self.selectedItem       = -1                     # selected cv index
        self.curvePoly          = 0                      # curve polygon
        self.baseRect           = 0                      # base outline rectangle
        self.tip                = 0                      # spline tip indicator
        self.root               = 0                      # spline root indicator
        self.lmb                = False                  # left mouse pressed (for moving points)
        self.lastState          = MouseState.kNoState
        
        #self.setBackgroundBrush(QtCore.Qt.lightGray)
        #self.setBackgroundBrush(QtGui.QBrush(QtGui.QColor(230,230,230)))

        # create a default curve
        if rampCurve == None:
            self.curve = RampCurve()
        else:
            self.curve = rampCurve   

        # setup a default size for the curve scene
        # self.resize(self.width, self.height)

    def drawScene(self):
        self.drawPoly()
        self.drawPoints()
        self.drawDeletePoints()
        self.drawSplineHints()

    def resize(self, width, height):
        # width and height already have the 8 px padding factored in
        self.width = width-16
        self.height = height-16
        self.setSceneRect(-9, -11, width, height)
        self.drawRect()
        self.drawScene()

    def numPoints(self):
        return self.curve.numPoints()

    def clear(self):
        self.curve.clear()
        self.drawScene()

    def removeItem(self,item):
        super(CurveScene,self).removeItem(item)


    # overloaded version of addEllipse that creates an item manually
    # The item was being deleted automatically it was causing refresh issues
    def addEllipse(self,x, y, w, h,pen=QtGui.QPen(), brush=QtGui.QBrush() ):
        item = QtGui.QGraphicsEllipseItem(x, y, w, h)
        item.setPen(pen)
        item.setBrush(brush)
        self.addItem(item)
        return item

    # overloaded version of addRect that creates an item manually
    # The item was being deleted automatically it was causing refresh issues
    def addRect(self,x, y, w, h,pen=QtGui.QPen(), brush=QtGui.QBrush() ):
        item = QtGui.QGraphicsRectItem(x, y, w, h)
        item.setPen(pen)
        item.setBrush(brush)
        self.addItem(item)
        return item

    # overloaded version of addPolygon that creates an item manually
    # The item was being deleted automatically it was causing refresh issues
    def addPolygon(self,polygon,pen=QtGui.QPen(), brush=QtGui.QBrush() ):
        item = QtGui.QGraphicsPolygonItem(polygon)
        item.setPen(pen)
        item.setBrush(brush)
        self.addItem(item)
        return item

    def addPoint(self, x, y, interp, select=True):
        if x < 0.0:
            x = 0.0
        if x > 1.0:
            x = 1.0
        if y < 0.0:
            y = 0.0
        if y > 1.0:
            y = 1.0

        if select:
            self.selectedItem = self.curve.addPoint(x, y, interp)
            self.cvSelected.emit(x, y, interp)
        else:
            self.curve.addPoint(x, y, interp)
        self.pointAdded.emit(x, y, interp)
        self.drawScene()
 

    def removePoint(self, id):
        self.curve.removePoint(id)
        self.selectedItem = -1
        self.pointRemoved.emit(id)
        self.drawScene()

    def mousePressEvent(self, mouseEvent):
        self.lmb = True
        pos = mouseEvent.scenePos()

        if pos.y() > 0 :
            # get items under mouse click
            itemList = self.items(pos)
        
            # find the first point in the list, previous code was sometimes picking the spline hints.
            firstPointItem = None
            for item in itemList:
                if item.zValue() == self.POINTS_ZORDER:
                    firstPointItem = item
                    break
            
            if not len(itemList):
                self.selectedItem = -1
                self.cvSelected.emit(-1, -1, self.defaultInterp)
                self.drawScene()
            elif firstPointItem != None:
                # getting here means we've selected a current point
                    for i in range(len(self.circleObjects)):
                        obj = self.circleObjects[i]
                        if obj == firstPointItem:
                            self.selectedItem = i
                            self.defaultInterp = self.curve.cv[i][2]
                            self.cvSelected.emit(self.curve.cv[i][0], self.curve.cv[i][1], self.curve.cv[i][2])
                    self.drawPoints()
                    self.drawDeletePoints()
            else:
                # getting here means we want to create a new point
                self.addPoint(pos.x()/self.width, pos.y()/self.height, self.defaultInterp)

        else:
            itemList = self.items(pos)

            # find the first point in the list, previous code was sometimes picking the spline hints.
            firstPointItem = None
            for item in itemList:
                if item.zValue() == self.POINTS_ZORDER:
                    firstPointItem = item
                    break
            if firstPointItem != None:
                if mouseEvent.buttons() == QtCore.Qt.LeftButton:
                    for i in range(len(self.rectObjects)):
                        obj = self.rectObjects[i]
                        if obj == firstPointItem:
                            self.selectedItem = i
                            self.removePoint(self.selectedItem)

    def mouseMoveEvent(self, mouseEvent):
        self.lastState = MouseState.kMoving
        if self.lmb:
            pos = mouseEvent.scenePos()
            if self.selectedItem >= 0:
                # clamp motion to inside curve area
                param = pos.x()/self.width
                value = pos.y()/self.height
                if param <= 0.0:
                    if self.curve.hasZeroPoint() and self.curve.cv[self.selectedItem][0] != 0.0:
                        param = 0.001
                    else:
                        param = 0.0
                if param >= 1.0:
                    if self.curve.hasOnePoint() and self.curve.cv[self.selectedItem][0] != 1.0:
                        param = 0.999
                    else:
                        param = 1.0
                if value < 0.0:
                    value = 0.0
                if value > 1.0:
                    value = 1.0
                self.curve.movePoint(self.selectedItem, param, value)
                self.cvSelected.emit(param, value, self.curve.cv[self.selectedItem][2])
                self.pointChanged.emit(self.selectedItem, param, value, self.curve.cv[self.selectedItem][2])
                self.drawScene()

    def mouseReleaseEvent(self, mouseEvent):
        self.lmb = False
        if self.lastState == MouseState.kMoving:
            self.pointMoving.emit()
        self.lastState = MouseState.kReleased

    def modifyPoint(self, id, param, value, interp):
        if param <= 0.0:
            if self.curve.hasZeroPoint() and self.curve.cv[id][0] != 0.0:
                param = 0.001
            else:
                param = 0.0
        if param >= 1.0 and self.curve.cv[id][0] != 1.0:
            if self.curve.hasOnePoint():
                param = 0.999
            else:
                param = 1.0
        if value < 0.0:
            value = 0.0
        if value > 1.0:
            value = 1.0

        self.curve.modifyPoint(id, param, value, interp)
        self.pointChanged.emit(id, param, value, interp)

    def interpChanged(self, val):
        # user selected a different interpolation type, redraw
        self.defaultInterp = val
        if self.selectedItem >= 0:
            self.curve.cv[self.selectedItem][2] = val
            self.pointChanged.emit(self.selectedItem, self.curve.cv[self.selectedItem][0], self.curve.cv[self.selectedItem][1], val)
            self.drawPoly()
            self.drawSplineHints()

    def selPosChanged(self, val):
        # user entered a different point position, redraw
        if self.selectedItem >= 0:
            param = float(val)
            if param <= 0.0:
                if self.curve.hasZeroPoint():
                    param = 0.001
                else:
                    param = 0.0
            if param >= 1.0:
                if self.curve.hasOnePoint():
                    param = 0.999
                else:
                    param = 1.0
            self.curve.cv[self.selectedItem][0] = param
            self.pointChanged.emit(self.selectedItem, param, self.curve.cv[self.selectedItem][1], self.curve.cv[self.selectedItem][2])
            self.drawScene()

    def selValChanged(self, val):
        # user entered a different point value, redraw
        if self.selectedItem >= 0:
            value = float(val)
            if value < 0.0:
                value = 0.0
            if value > 1.0:
                value = 1.0
            self.curve.cv[self.selectedItem][1] = value
            self.pointChanged.emit(self.selectedItem, self.curve.cv[self.selectedItem][0], value, self.curve.cv[self.selectedItem][2])
            self.drawScene()

    def drawRect(self):
        # draws the base gray outline rectangle
        if not self.baseRect:
            self.baseRect = self.addRect(-1, -1, self.width+2, self.height+2, QtGui.QPen(QtCore.Qt.black, 1.0), QtGui.QBrush(QtCore.Qt.gray))

        self.baseRect.setRect(-1, -1, self.width+2, self.height+2)

    def drawPoly(self):
        # draws the poly curve representation        
        if not self.curvePoly:
            self.curvePoly = self.addPolygon(QtGui.QPolygonF(), QtGui.QPen(QtCore.Qt.black, 1.0), QtGui.QBrush(QtCore.Qt.darkGray))

        self.poly = QtGui.QPolygonF()
        self.poly.append(QtCore.QPointF(self.width, 0))
        self.poly.append(QtCore.QPointF(0, 0))
        
        # Use something faster than hardcoded 1000
        subdi = (self.width)/3
        for i in range(0, subdi):
            x = float(i)/float(subdi-1)
            self.poly.append(QtCore.QPointF(self.width*x, self.height*self.curve.getValue(x)))
        self.poly.append(QtCore.QPointF(self.width, 0))
        self.curvePoly.setPolygon(self.poly)
        self.curvePoly.setZValue(self.POLY_ZORDER)

    def drawPoints(self):
        # draws the cv points
        for obj in self.circleObjects:
            self.removeItem(obj)

        self.circleObjects = []
        
        for i in range(len(self.curve.cv)):
            pt = self.curve.cv[i]
            if i == self.selectedItem:
                pen = QtGui.QPen(QtCore.Qt.white,1.0)
            else:
                pen = QtGui.QPen(QtCore.Qt.black,1.0)
            circle = self.addEllipse(pt[0]*self.width-2, pt[1]*self.height-4, 8, 8, pen, QtGui.QBrush())
            circle.setFlag(QtGui.QGraphicsItem.ItemIsMovable, True)
            circle.setZValue(self.POINTS_ZORDER)

            self.circleObjects.append(circle)

    def drawDeletePoints(self):
        
        # draws the cv points
        for obj in self.rectObjects:
            self.removeItem(obj)
        self.rectObjects = []
        for obj in self.crossLineObjects:
            self.removeItem(obj)
        self.crossLineObjects = []

        for i in range(len(self.curve.cv)):
            pt = self.curve.cv[i]
            if i == self.selectedItem:
                pen = QtGui.QPen(QtCore.Qt.white,1.0)
            else:
                pen = QtGui.QPen(QtCore.Qt.black,1.0)
            rect = self.addRect(pt[0]*self.width-4, -8, 8, 8, pen, QtGui.QBrush(QtCore.Qt.gray))
            rect.setFlag(QtGui.QGraphicsItem.ItemIsMovable, True)
            rect.setZValue(self.POINTS_ZORDER)

            Line1 = QtCore.QLineF(rect.rect().topLeft(), rect.rect().bottomRight())
            Line2 = QtCore.QLineF(rect.rect().topRight(), rect.rect().bottomLeft())
            crossLine1 = self.addLine(Line1, pen)
            crossLine1.setFlag(QtGui.QGraphicsItem.ItemIsMovable, True)
            crossLine1.setZValue(self.POINTS_ZORDER)
            crossLine2 = self.addLine(Line2, pen)
            crossLine2.setFlag(QtGui.QGraphicsItem.ItemIsMovable, True)
            crossLine2.setZValue(self.POINTS_ZORDER)
            
            self.rectObjects.append(rect)
            self.crossLineObjects.append(crossLine1)
            self.crossLineObjects.append(crossLine2)

    def drawSplineHints(self):
        """ draws indicator hints for the tip and root of the associated spline """
        if not self.root:
            self.root = self.addSplineHintItem( 'R' )
        self.root.setPos( 0, self.height/2+8 )

        if not self.tip:
            self.tip = self.addSplineHintItem( 'T' )
        self.tip.setPos( self.width-14, self.height/2+8 )

    def addSplineHintItem( self, text ):
        """ creates a new spline indicator """
        item = QtGui.QGraphicsTextItem( text )
        item.setFont( QtGui.QFont('Arial',9) )    
        item.font().setBold(True)
        item.setDefaultTextColor( QtCore.Qt.white )        
        item.setTransform(QtGui.QTransform().scale(1, -1))
        item.setZValue(self.SPLINEHINTS_ZORDER)
        self.addItem(item)
        return item



class xgRampWidget(QtGui.QWidget):

    pointAdded = QtCore.Signal(float,float,int)
    pointRemoved = QtCore.Signal(int)
    pointChanged = QtCore.Signal(int,float,float,int)
    pointMoving = QtCore.Signal()

    def __init__(self,pLabel=None,vLabel=None,iLabel=None, RampCurve = None,parent=None, FixEditSize = 320):
        QtGui.QWidget.__init__(self, parent)

        mainLayout = QtGui.QVBoxLayout()
        mainLayout.setSpacing(0)
        mainLayout.setContentsMargins(1,1,1,1)

        editor = QtGui.QWidget()
        editorLayout = QtGui.QHBoxLayout()
        editorLayout.setAlignment(QtCore.Qt.AlignTop|QtCore.Qt.AlignLeft)
        editorLayout.setSpacing(0)
        editorLayout.setContentsMargins(0,0,0,0)
        editor.setLayout(editorLayout)
         
        edits = QtGui.QWidget()
        editsLayout = QtGui.QHBoxLayout()
        editsLayout.setAlignment(QtCore.Qt.AlignTop|QtCore.Qt.AlignLeft)
        editsLayout.setSpacing(10)
        editsLayout.setContentsMargins(1,1,1,1)
        edits.setLayout(editsLayout)
        edits.setFixedWidth(FixEditSize)

        selPos = QtGui.QWidget()
        selPosLayout = QtGui.QHBoxLayout()
        selPosLayout.setSpacing(1)
        selPosLayout.setContentsMargins(1,1,1,1)
        selPos.setLayout(selPosLayout)
        self.selPosEdit = QtGui.QLineEdit()
        self.validatePos = QtGui.QDoubleValidator(0.0,1.0,6,self.selPosEdit)
        self.validatePos.fixup = self.myPosFixup
        self.selPosEdit.setValidator(self.validatePos)
        self.selPosEdit.setFixedWidth(36)
        if pLabel != None:
            selPosLayout.addWidget(QtGui.QLabel(pLabel))
        else:
            selPosLayout.addWidget(QtGui.QLabel(maya.stringTable[ 'y_xgRampWidget.kSelectedPosition'  ]))
        selPosLayout.addWidget(self.selPosEdit)
        
        self.PosSpacer = QtGui.QSpacerItem(1, 20, QtGui.QSizePolicy.Minimum, QtGui.QSizePolicy.Minimum) #Expanding
        selPosLayout.addItem(self.PosSpacer)
        
        selVal = QtGui.QWidget()
        selValLayout = QtGui.QHBoxLayout()
        selValLayout.setSpacing(1)
        selValLayout.setContentsMargins(1,1,1,1)
        selVal.setLayout(selValLayout)
        self.selValEdit = QtGui.QLineEdit()
        self.validateVal = QtGui.QDoubleValidator(0.0,1.0,6,self.selValEdit)
        self.validateVal.fixup = self.myValFixup
        self.selValEdit.setValidator(self.validateVal)
        self.selValEdit.setFixedWidth(36)
        if vLabel != None:
            selValLayout.addWidget(QtGui.QLabel(vLabel))
        else:
            selValLayout.addWidget(QtGui.QLabel(maya.stringTable[ 'y_xgRampWidget.kSelectedValue'  ]))
        selValLayout.addWidget(self.selValEdit)
        
        self.ValSpacer = QtGui.QSpacerItem(1, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum) #Expanding
        selValLayout.addItem(self.ValSpacer)

        spacer = QtGui.QWidget()
        
        interp = QtGui.QWidget()
        interpLayout = QtGui.QHBoxLayout()
        interpLayout.setSpacing(1)
        interpLayout.setContentsMargins(1,1,1,1)
        interp.setLayout(interpLayout)
        self.interpComboBox = _ComboBoxUI()
        self.interpComboBox.addItem(maya.stringTable[ 'y_xgRampWidget.kFlat'  ])
        self.interpComboBox.addItem(maya.stringTable[ 'y_xgRampWidget.kLinear'  ])
        self.interpComboBox.addItem(maya.stringTable[ 'y_xgRampWidget.kSmooth'  ])
        self.interpComboBox.addItem(maya.stringTable[ 'y_xgRampWidget.kSpline'  ])
        self.interpComboBox.setCurrentIndex(1)
        if vLabel != None:
            interpLayout.addWidget(QtGui.QLabel(iLabel))
        else:
            interpLayout.addWidget(QtGui.QLabel(maya.stringTable[ 'y_xgRampWidget.kInterpolation'  ]))
        interpLayout.addWidget(self.interpComboBox)

        self.interpSpacer = QtGui.QSpacerItem(1, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum) 
        interpLayout.addItem(self.interpSpacer)

        editsLayout.addWidget(interp)
        editsLayout.addWidget(selVal)
        editsLayout.addWidget(selPos)

        self.editorSpacer = QtGui.QSpacerItem(1, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)

        editorLayout.addWidget(edits)
        editorLayout.addItem(self.editorSpacer)

        curveFrame = QtGui.QFrame()
        curveFrame.setFrameShape( QtGui.QFrame.Panel )
        #curveFrame.setFrameShadow( QtGui.QFrame.Sunken )
        curveFrame.setLineWidth( 0 )
        curveFrameLayout = QtGui.QHBoxLayout()
        curveFrameLayout.setContentsMargins(1,1,1,1)
        curveView = RampGraphicsView()
        curveView.setFrameShape( QtGui.QFrame.Panel )
        #curveView.setFrameShadow( QtGui.QFrame.Sunken )
        curveView.setLineWidth( 0 )
        curveView.setVerticalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOff)
        curveView.setHorizontalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOff)
        if RampCurve == None:            
            self.scene = CurveScene()
        else:
            self.scene = CurveScene(RampCurve)
        curveView.setScene(self.scene)
        curveView.setTransform(QtGui.QTransform().scale(1, -1))
        curveView.setRenderHints(QtGui.QPainter.Antialiasing)
        curveFrameLayout.addWidget(curveView)
        curveFrame.setLayout(curveFrameLayout)

        mainLayout.addWidget(curveFrame)
        mainLayout.addWidget(editor)
        self.setLayout(mainLayout)

        # SIGNALS

        # when a user selects a cv, update the fields on left
        self.scene.cvSelected.connect(self.cvSelectedSlot)
        # when a user selects a different interp, the curve has to redraw
        self.connect(self.interpComboBox, QtCore.SIGNAL("activated(int)"),
            self.scene.interpChanged)
        # when a user types a different position, the curve has to redraw
        self.connect(self.selPosEdit, QtCore.SIGNAL("returnPressed()"),
            self.selPosChanged)
        # when a user types a different value, the curve has to redraw
        self.connect(self.selValEdit, QtCore.SIGNAL("returnPressed()"),
            self.selValChanged)
        # when the widget is resized, resize the curve widget
        curveView.resizeSignal.connect(self.scene.resize)
        
        # when a point is added/remove/changed, propagate the signal
        self.scene.pointAdded.connect  (self.emitPointAddedSlot)
        self.scene.pointRemoved.connect(self.emitPointRemovedSlot)
        self.scene.pointChanged.connect(self.emitPointChangedSlot)
        self.scene.pointMoving.connect(self.emitPointMovingSlot)

    def myPosFixup(self,value):
        if float(value)<=0.0:
            self.selPosEdit.setText(str(0.0))
        elif float(value)>=1.0:
            self.selPosEdit.setText(str(1.0))

    def myValFixup(self,value):
        if float(value)<=0.0:
            self.selValEdit.setText(str(0.0))
        elif float(value)>=1.0:
            self.selValEdit.setText(str(1.0))

    @QtCore.Slot(bool)
    def emitPointMovingSlot(self):
        self.pointMoving.emit()

    @QtCore.Slot(float,float,int)
    def emitPointAddedSlot(self, x, y, interp):
        self.pointAdded.emit(x, y, interp)

    @QtCore.Slot(int)
    def emitPointRemovedSlot(self, id):
        self.pointRemoved.emit(id)

    @QtCore.Slot(int,float,float,int)
    def emitPointChangedSlot(self, pt, x, y, interp):
        self.pointChanged.emit(pt, x, y, interp)

    @QtCore.Slot(float,float,int)
    def cvSelectedSlot(self, param, value, interp):
        """CV selected, update the user interface fields."""
        paramStr = ""
        valueStr = ""
        if param >= 0.0: paramStr = "%.3f" % param
        if value >= 0.0: valueStr = "%.3f" % value
        self.selPosEdit.setText(paramStr)
        self.selValEdit.setText(valueStr)
        self.interpComboBox.setCurrentIndex(interp)

    def selPosChanged(self):
        """User entered new position, round and send signal to redraw curve."""
        try:
            param = float(self.selPosEdit.text())
        except ValueError:
            return
        if param <= 0.0:
            if self.scene.curve.hasZeroPoint():
                param = 0.001
            else:
                param = 0.0
        if param >= 1.0:
            if self.scene.curve.hasOnePoint():
                param = 0.999
            else:
                param = 1.0
        paramStr = "%.3f" % param
        self.selPosEdit.setText(paramStr)
        self.scene.selPosChanged(paramStr)

    def selValChanged(self):
        """User entered new value, round and send signal to redraw curve."""
        try:
            value = float(self.selValEdit.text())
        except ValueError:
            return
        if value < 0.0:
            value = 0.0
        if value > 1.0:
            value = 1.0
        valueStr = "%.3f" % value
        self.selValEdit.setText(valueStr)
        self.scene.selValChanged(valueStr)

    # Convenience Functions
    def numPoints(self):
        return self.scene.numPoints()

    def clear(self):
        self.scene.clear()

    def addPoint(self, x, y, interp, select=False):
        self.scene.addPoint(x, y, interp, select)

    def removePoint(self, id):
        self.scene.removePoint(id)

    def getPoint(self, id):
        return self.scene.curve.getPoint(id)

    def modifyPoint(self, id, pos, value, interp):
        self.scene.curve.sortPoints()
        self.scene.modifyPoint(id, pos, value, interp)

    def getValueAtParam(self, param):
        return self.scene.curve.getValue(param)

    def refresh(self):
        self.scene.drawScene()

    def onAddPoint(self, x, y, interp, select=False):
        self.refresh()

    def onRemovePoint(self, id):
        self.refresh()

    def onModifyPoint( self ):
        self.refresh()
