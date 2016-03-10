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
#                                                                             #
# ..Notes::                                                                   #
#  The original maya2016.sh file that is used to execute Maya contained       #
#  setenv commands at the top of the script which were overriding my          #
#  env vars. Because I don't have admin permissions, I was forced to copy     #
#  the entire maya2016 install directory to                                   #
#  $PROJECT_DIR/Pipeline/my_MAYA/maya_INSTALL                                 #
#                                                                             #
#  I removed the setenv commands and made export equivalents with the         # 
#  bash script below. The maya2016 command is written in tsch but             #
#  this bash script will play nice with the maya2016 bin                      #
#                                                                             #
#  See maya2016_orig for an unaltered version of the maya2016 file            #
#                                                                             #
#  Author Edit 2015/11/6 :: Added POP2 Maya 2016 Linux Shell script fix       #
#  directly to the .sh file                                                   #
###############################################################################

# MAYA 2016 FIX - LINUX
if [[ ! -e $HOME/maya ]]; then
    rm -rf $HOME/maya
elif [[ ! -d $dir ]]; then
    echo "$HOME/maya already exists but is not a directory" 1>&2
fi

if [ -d $HOME/maya ]; then
    mkdir -rf $HOME/maya
fi

if [ -d $NETHOME/maya/2016 ]; then
    mkdir -rf $NETHOME/maya/2016
fi

# for x in `ls $NETHOME/maya | grep -v synColor`; do ln -s $NETHOME/maya/$x $HOME/maya/$x; done
for x in `ls $MAYA_APP_NET_DIR | grep -v synColor`; do ln -s $MAYA_APP_NET_DIR/$x $HOME/maya/$x; done
export MAYA_APP_DIR=$HOME/maya
echo "MAYA_APP_DIR set to \$HOME/maya"

# GLOB ENV VARS
echo "=> PROJECT_DIR has been set to ($PROJECT_DIR)"
echo "=> PIPELINE_DIR has been set to ($PIPELINE_DIR)"
echo "=> APP_EXECUTABLE has been set to ($APP_EXECUTABLE)"
export RMANTREE=/opt/pixar/RenderManStudio-20.0-maya2016
export RMSTREE=/opt/pixar/RenderManStudio-20.0-maya2016

# MAYA ENV VARS
export MAYA_LOCATION=/usr/autodesk/maya2015-x64
# export MAYA_LOCATION=/usr/autodesk/maya2016
export RATTREE=/opt/pixar/RenderManStudio-20.0-maya2016
export MAYA_MODULE_PATH=$RMSTREE/etc
export MAYA_SCRIPT_PATH=$RMSTREE/scripts
export MAYA_PLUG_IN_PATH=$RMSTREE/plug-ins
export XBMLANGPATH=$RMSTREE/icons/%B:$XBMALANGPATH
export PYTHONPATH=$RMSTREE/scripts:$PYTHONPATH
export SYSMODULES=$PROJECT_DIR/Pipeline/the_LATEST/sys_PY/py_MODULES
export MAYA_APP_NET_DIR=$PROJECT_DIR/Pipeline/the_LATEST/latest_MAYA/maya_DEFAULTPROJECT
export SYSMODULES=$PROJECT_DIR/Pipeline/the_LATEST/sys_PY/py_MODULES:$SYSMODULES
export MAYA_SCRIPT_PATH=$PROJECT_DIR/Pipeline/the_LATEST/latest_MAYA/maya_SCRIPTS:$MAYA_SCRIPT_PATH
export PYTHONPATH=$MAYA_SCRIPT_PATH:$PYTHONPATH
export MAYA_PLUG_IN_PATH=$PROJECT_DIR/Pipeline/the_LATEST/latest_MAYA/maya_PLUGINS:$MAYA_PLUG_IN_PATH
export MI_CUSTOM_SHADER_PATH=$PROJECT_DIR/Pipeline/the_LATEST/latest_MAYA/maya_SHADERS
export XBMLANGPATH=$PROJECT_DIR/Pipeline/the_LATEST/latest_MAYA/maya_ICONS:$XBMLANGPATH
export LOG_CFG=$PROJECT_DIR/Pipeline/the_LATEST/latest_MAYA/maya_LOGS

# EXECUTE FROM PATH
$APP_EXECUTABLE
