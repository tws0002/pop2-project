#
# Copyright 2015 Autodesk, Inc. All rights reserved.
#
# Use of this software is subject to the terms of the Autodesk license
# agreement provided at the time of installation or download, or which
# otherwise accompanies this software in either electronic or hard copy form.
#

##
# @file xgComboBox.py
# @brief Customized combo box for xgen. Ignore wheel event and keep
#        the same behavior with Maya.
#
# @version Created 01/05/2015
#

from PySide import QtGui, QtCore
import xgenm as xg
import xgenm.xgGlobal as xgg
from xgenm.xgUtil import *


class _ComboBoxUI(QtGui.QComboBox):
    """  Customized combo box for xgen. Ignore wheel event and keep
         the same behavior with Maya.
    """
    def __init__(self):
        QtGui.QComboBox.__init__(self)

    def wheelEvent(self, event):
        event.ignore()
        return
