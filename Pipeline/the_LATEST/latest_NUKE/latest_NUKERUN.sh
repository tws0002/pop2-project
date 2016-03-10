#!/bin/bash

###############################################################################
# Copyright (c) 2016 Colin Kennedy                                            #
#                                                                             #
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

# GLOB ENV VARS
# for linux, it's set RMANTREE/lib to LD_LIBRARY_PATH - 
# for win, it's PATH, on OSX, it's DYLD_LIBRARY_PATH
#
echo "=> PROJECT_DIR has been set to ($PROJECT_DIR)"
echo "=> PIPELINE_DIR has been set to ($PIPELINE_DIR)"
echo "=> APP_EXECUTABLE has been set to ($APP_EXECUTABLE)"
export PATH=$RMANTREE/lib;$PATH

# NUKE ENV VARS
export NUKE_GIZMO_PATH=$PIPELINE_DIR/latest_NUKE/nuke_GIZMOS
echo "=> NUKE_GIZMO_PATH has been set to ($NUKE_GIZMO_PATH)"
export RMSTREE=/opt/pixar/RenderManStudio-20.0-maya2016
echo "=> RMSTREE has been set to ($RMSTREE)"
export RMANTREE=/opt/pixar/RenderManProServer-20.0
echo "=> RMANTREE has been set to ($RMANTREE)"
export PYTHONPATH=$PIPELINE_DIR/sys_PY/py_MODULES:$PYTHONPATH
export NUKE_PATH=$PIPELINE_DIR/latest_NUKE

# EXECUTE FROM PATH
$APP_EXECUTABLE --nukex
