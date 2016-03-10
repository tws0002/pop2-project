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
set PATH=%RMANTREE%\lib;%PATH%;

:: NUKE ENV VARS
set RMSTREE="C:\Program Files\Pixar\RenderManStudio-20.0-maya2016"
echo "=> RMSTREE has been set to (%RMSTREE%)"
set RMANTREE="C:\Program Files\Pixar\RenderManProServer-20.0"
echo "=> RMANTREE has been set to (%RMANTREE%)"
set PYTHONPATH=%PIPELINE_DIR%\sys_PY\py_MODULES
set NUKE_PATH=%PIPELINE_DIR%\latest_NUKE

:: EXECUTE FROM PATH
%APP_EXECUTABLE% --nukex