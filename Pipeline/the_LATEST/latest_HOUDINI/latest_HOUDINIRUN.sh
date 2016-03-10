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
# Make symlinks for Houdini auto-startup
export HOU_SCRIPT_DIR=/home/$USER/houdini15.0/scripts
if [ ! -d "$HOU_SCRIPT_DIR" ]; then
    mkdir $HOU_SCRIPT_DIR
fi

export HOU_SCRIPT_INIT_123=$HOU_SCRIPT_DIR/123.py
if [ ! -L $HOU_SCRIPT_INIT_123 ] && [ ! -e $HOU_SCRIPT_INIT_123 ]; then
    ln -s  $PIPELINE_DIR/latest_HOUDINI/123.py $HOU_SCRIPT_INIT_123
elif [ -e $HOU_SCRIPT_INIT_123 ]  && [ ! -L $HOU_SCRIPT_INIT_123 ]; then
    echo -n "The path $HOU_SCRIPT_INIT_123 exists, should we overwrite it? Y/n[Enter]"
    read response
    echo $response
    if [ "$response" = "Y" ] || [ "$response" = "y" ]; then
	echo "Removing $HOU_SCRIPT_INIT_123 and adding symlink..."
	rm $HOU_SCRIPT_INIT_123
	ln -s  $PIPELINE_DIR/latest_HOUDINI/123.py $HOU_SCRIPT_INIT_123
    else
	echo $"Please consider appending the information in $PIPELINE_DIR/latest_HOUDINI/123.py to $HOU_SCRIPT_INIT_123 or removing $HOU_SCRIPT_INIT_123"
	exit
    fi
fi

# Make symlinks to node preset binaries

# GLOB ENV VARS
echo "=> PROJECT_DIR has been export to ($PROJECT_DIR)"
echo "=> PIPELINE_DIR has been export to ($PIPELINE_DIR)"
# export PYTHONHOME=/usr/local/python-2.7/bin/python2.7

# HOUDINI ENV VARS
# export HOUDINI_PATH=$PIPELINE_DIR/latest_HOUDINI:$HOUDINI_PATH
# export HOUDINI_PATH=/home/ckenne24
# export HSITE=$PIPELINE_DIR/latest_HOUDINI/hou_PY:$HSITE
# export HOUDINI_USER_PREF_DIR=$PIPELINE_DIR/latest_HOUDINI/hou_PRESETS:$HOUDINI_USER_PREF_DIR
# export HOUDINI_USER_PREF_DIR=$PIPELINE_DIR/latest_HOUDINI/hou_PRESETS
export SYSMODULES=$PIPELINE_DIR/sys_PY/py_MODULES
export PYTHONPATH=$SYSMODULES:$PYTHONPATH

# EXECUTE FROM PATH
$APP_EXECUTABLE

