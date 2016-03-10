#**************************************************************************/
# Copyright (c) 2013 Autodesk, Inc.
# All rights reserved.
#
# These coded instructions, statements, and computer programs contain
# unpublished proprietary information written by Autodesk, Inc., and are
# protected by Federal copyright law. They may not be disclosed to third
# parties or copied or duplicated in any form, in whole or in part, without
# the prior written consent of Autodesk, Inc.
#**************************************************************************/

import string
from PySide import QtGui, QtCore
from PySide.QtGui import QStyle
import xgenm as xg
from xgenm.ui.util.xgUtil import *


class ExpandUIHeader(QtGui.QWidget):
    """implements the clickable title part of collapsible frame
    """
    def __init__(self, expanded, text):
        QtGui.QWidget.__init__(self)
        self.setMinimumHeight(self.headerHeight())
        self.setMinimumWidth(32)
        self.expanded = expanded
        self.text = text

    def setExpanded(self, expanded):
        self.expanded = expanded
        self.update()
        
    def headerHeight(self):
        return 20

    def paintEvent(self,event):
        painter = QtGui.QStylePainter(self)
        rc = self.rect()
        
        # draw the background with a slightly ligher color
        brush =  QtGui.QBrush(Qt.SolidPattern)
        palette = QtGui.QApplication.palette()
        brush.setColor(palette.window().color().lighter(115))
        painter.fillRect( rc, brush)
        
        # draw a 3d frame
        penLight  = QtGui.QPen( palette.light().color() )
        penShadow = QtGui.QPen( palette.dark().color() )
        painter.setPen( penLight )
        painter.drawLine( rc.bottomLeft(), rc.topLeft() )
        painter.drawLine( rc.topLeft(), rc.topRight() )
        painter.setPen( penShadow)
        painter.drawLine( rc.topRight(), rc.bottomRight() )
        painter.drawLine( rc.bottomRight(), rc.bottomLeft() )

        # draw expand button
        arrowIcon = QStyle.PE_IndicatorArrowDown if self.expanded else QStyle.PE_IndicatorArrowRight

        option = QtGui.QStyleOptionButton()
        option.initFrom(self)
        option.rect.setHeight(self.headerHeight()-2)
        option.rect.setWidth(self.headerHeight()-2)
        option.rect.setLeft(self.style().pixelMetric(QStyle.PM_ButtonMargin))
        option.rect.setTop(1)
        painter.drawPrimitive(arrowIcon, option)

        # draw label
        rc.setLeft(32)
        penText  = QtGui.QPen( palette.color( QtGui.QPalette.Normal if self.isEnabled() else QtGui.QPalette.Disabled, QtGui.QPalette.WindowText ) )
        font = painter.font()
        font.setBold(True)
        painter.setFont(font)
        painter.setPen(penText)
        painter.drawText(rc, Qt.AlignLeft | Qt.AlignVCenter, self.text)

    def mouseReleaseEvent(self, mouseEvent):
        self.parentWidget().expandSlot(self.expanded)

class ExpandUI(QtGui.QWidget):
    """A widget for collapsible frames.
    """
    def __init__(self, text, expanded=True):
        QtGui.QWidget.__init__(self)
        self.expanded = expanded

        # Layout for expandable layout contents
        self.contents = QtGui.QFrame()
        self.contents.setFrameStyle( QtGui.QFrame.Panel | QtGui.QFrame.Raised)
        self.contentsLayout = QtGui.QVBoxLayout()
        self.contentsLayout.setSpacing(0)
        self.contentsLayout.setContentsMargins(2,2,2,2)
        self.contents.setLayout(self.contentsLayout)

        # maya has a sunken border around the raise border..
        self.blackFrame = QtGui.QFrame()
        self.blackFrame.setFrameStyle( QtGui.QFrame.Panel | QtGui.QFrame.Sunken)
        self.blackFrame.setLayout(QtGui.QVBoxLayout())
        self.blackFrame.layout().setContentsMargins(0,0,0,0)
        self.blackFrame.layout().addWidget(self.contents)

        # Pull it all together
        mainLayout = QtGui.QVBoxLayout()
        mainLayout.setSpacing(0)
        mainLayout.setContentsMargins(0,0,0,0)
        self.header = ExpandUIHeader(self.expanded,text)
        mainLayout.addWidget(self.header)
        mainLayout.addWidget(self.blackFrame)
        self.setLayout(mainLayout)

        self.setExpanded(expanded)

    def refresh(self):
        return

    def addWidget(self, widget):
        self.contentsLayout.addWidget(widget)
        if not self.expanded:
            self.blackFrame.hide()
            
    def addSpacing(self, s):
        self.contentsLayout.addSpacing(s)
        if not self.expanded:
            self.blackFrame.hide()

    def expandSlot(self, checked):
        self.setExpanded(not self.expanded)

    def setExpanded(self, expand):
        if self.expanded == expand:
            return
        self.header.setExpanded(expand)
        if expand:
            self.blackFrame.show()
        else:
            self.blackFrame.hide()
        self.expanded = expand

    def cleanScriptJob(self):        
        for i in range( self.contentsLayout.count() ):  
            try:
                self.contentsLayout.itemAt(i).widget().cleanScriptJob()
            except:
                pass            