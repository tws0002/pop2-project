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

:: DIRECTORY LOCATIONS
set PROJECT_DIR=I:\Savannah\CollaborativeSpace\portal-origins-part-2
set PIPELINE_DIR=%PROJECT_DIR%\Pipeline\the_LATESTDEV
set APP_EXECUTABLE="C:\Program Files\Autodesk\Maya2016\bin\maya.exe"

:: PROJECT CONFIGURATION SETTINGS
::              <------ Number of messages (verbosity) ------>
::  ('trace', 'debug', 'info', 'warning', 'error', 'exception', 'critical')
::   highest                                                      lowest
set LOG_LEVEL=debug
set SOLIDARITY=True

:: APPLICATION EXECUTION
call %PIPELINE_DIR%\latest_MAYA\latest_MAYARUN.bat
