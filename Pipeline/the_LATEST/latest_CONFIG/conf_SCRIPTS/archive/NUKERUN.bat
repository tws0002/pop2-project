set PROJECT_DIR=C:\Users\korinkite\Dropbox\Private\my_PROJECT\proj_POP2
set PIPELINE_DIR=%PROJECT_DIR%\Pipeline\the_LATEST
set APP_EXECUTABLE="C:\Program Files\Nuke9.0v8\Nuke9.0.exe"
set SOLIDARITY="True"
REM ('trace', 'debug', 'info', 'warning', 'error', 'exception', 'critical')
REM  highest													  lowest
REM		   	    <------ Number of messages (verbosity) ------>
set LOG_LEVEL=info
call %PIPELINE_DIR%\latest_NUKE\latest_NUKERUN.bat