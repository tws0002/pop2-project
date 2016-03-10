#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
###############################################################################
# The MIT License (MIT) Copyright (c) 2016 Colin Kennedy                      #
#                                                                             #
# Permission is hereby granted, free of charge, to any person obtaining a     #
# copy of this software and associated documentation files (the "Software"),  #
# to deal in the Software without restriction, including without limitation   #
# the rights to use, copy, modify, merge, publish, distribute, sublicense,    #
# and/or sell copies of the Software, and to permit persons to whom the       #
# Software is furnished to do so, subject to the following conditions:        #
#                                                                             #
# The above copyright notice and this permission notice shall be included in  #
# all copies or substantial portions of the Software.                         #
#                                                                             #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE #
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      #
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     #
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         #
# DEALINGS IN THE SOFTWARE.                                                   #
###############################################################################

Description
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Pickrunner creates a way to define arbitrary relationships between nodes in
Autodesk Maya using PyMEL/python. It has a GUI and GUI-less mode and can be
sourced into rigs/scriptJobs/scriptNodes for added automation

.. considerations::
    The scriptJob that lives and dies with the current window instance could
    be more efficiently created if it were created/kill depending on assign
    mode and not simply with the current window instance (like it is now)

Filename
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
macromaker.py
"""

# IMPORT THIRD-PARTY LIBRARIES
try:
    import PyQt4.QtCore as QtCore
    import PyQt4.QtGui as QtGui
except ImportError:
    import PySide.QtCore as QtCore
    import PySide.QtGui as QtGui
except:
    raise

# IMPORT LOCAL LIBRARIES
import model.header as header
import view.basegui as basegui


__author__ = header.__author__
__copyright__ = header.__author__
__license__ = header.__license__
__version__ = header.__version__
__email__ = header.__email__
__status__ = header.__status__


class Window(QtGui.QMainWindow, basegui.Ui_MainWindow):
    """
    The window that creates the main GUI, which provides the user an interface
    """
    def __init__(self, parent=None):
        """
        Separate calls are used to define default data in the __init__, as well
        as UI default elements and triggers (aka interactivity)

        Args:
            parent (QtGui.QApplication): The current window
                                         instance/application, if applicable
        """
        super(Window, self).__init__(parent)
        self.setupUi(self)
    # end __init__

    def init(self):
    	"""
    	"""
    	pass
   	# end init
# end Window


def main():
	"""
	Main execution of the script
	"""
	pass
# end main


if __name__ == "__main__":
	main()