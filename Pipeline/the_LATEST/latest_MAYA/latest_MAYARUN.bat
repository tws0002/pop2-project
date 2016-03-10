goto comment
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
:comment

:: GLOB ENV VARS
echo "=> PROJECT_DIR has been set to (%PROJECT_DIR%)"
echo "=> PIPELINE_DIR has been set to (%PIPELINE_DIR%)"
echo "=> APP_EXECUTABLE has been set to (%APP_EXECUTABLE%)"

set SYSMODULES=%PIPELINE_DIR%\sys_PY\py_MODULES
echo "=> SYSMODULES has been set to (%SYSMODULES%)"

set PYTHONPATH=%SYSMODULES%;%PYTHONPATH%
echo "=> PYTHONPATH has been set to (%PYTHONPATH%)"

set MAYA_APP_NET_DIR=%PIPELINE_DIR%\latest_MAYA\maya_DEFAULTPROJECT
echo "=> MAYA_APP_NET_DIR has been set to (%MAYA_APP_NET_DIR%)"

:: MAYA ENV VARS
set MAYA_APP_DIR=%PIPELINE_DIR%\latest_MAYA\maya_DEFAULTPROJECT
:: set MAYA_PLUG_IN_PATH=%PIPELINE_DIR%\latest_MAYA\maya_PLUGINS
set MI_CUSTOM_SHADER_PATH=%PIPELINE_DIR%\latest_MAYA\maya_SHADERS
set MAYA_SCRIPT_PATH=%PIPELINE_DIR%\latest_MAYA\maya_SCRIPTS
set XBMLANGPATH=%PIPELINE_DIR%\latest_MAYA\maya_ICONS
set PYTHONPATH=%MAYA_SCRIPT_PATH%;%PYTHONPATH%
set LOG_CFG=%PIPELINE_DIR%\latest_MAYA\maya_LOGS

:: EXECUTE FROM PATH
start "Autodesk Maya 2016" %APP_EXECUTABLE%