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
# DIRECTORY LOCATIONS
set PROJECT_DIR=/home/$USER/mount/collaborative/portal-origins-part-2
set PIPELINE_DIR=$PROJECT_DIR/Pipeline/the_LATEST
set PYTHONPATH=$PIPELINE_DIR/sys_PY/py_MODULES:$PYTHONPATH

# EXECUTE SCRIPT
echo $PIPELINE_DIR/sys_PY/py_MODULES/shotSelection/shotSelection.py
$PIPELINE_DIR/latest_MAYA/maya_INSTALL/maya2016/bin/mayapy /home/$USER/mount/collaborative/portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/shotselection.py
# $PIPELINE_DIR/sys_PY/py_MODULES/shotSelection/shotSelection.py
