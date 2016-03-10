set POP2_PROJECT_DIR=C:\Users\SelecaoOne\Dropbox\Private\my_PROJECT
echo "=> POP2_PROJECT_DIR has been set to C:\Users\SelecaoOne\Dropbox\Private\my_PROJECT (%POP2_PROJECT_DIR%)"

set POP2_PIPELINE_DIR=C:\Users\SelecaoOne\Dropbox\Private\my_PIPELINE\the_LATEST
echo "=> POP2_PIPELINE_DIR has been set to C:\Users\SelecaoOne\Dropbox\Private\my_PIPELINE\the_LATEST (%POP2_PIPELINE_DIR%)"

REM project-wide vars
REM for linux, it's set RMANTREE/lib to LD_LIBRARY_PATH - for win, it's PATH, on OSX, it's DYLD_LIBRARY_PATH
set PATH=%RMANTREE%/lib;%PATH%;
set RMSTREE="C:\Program Files\Pixar\RenderManStudio-20.0-maya2016";
set RMANTREE="C:\Program Files\Pixar\RenderManProServer-20.0";

set PYTHONPATH=%POP2_PROJECT_DIR%\Pipeline\the_LATEST\sys_PY\py_MODULES;
REM NUKE_PATH=%POP2_PROJECT_DIR%\Pipeline\the_LATEST\latest_NUKE
REM set NUKE_PATH=%POP2_PROJECT_DIR%\Pipeline\the_LATEST\latest_NUKE
REM set NUKE_PATH=%POP2_PROJECT_DIR%\Pipeline\the_LATEST\latest_NUKE;
set NUKE_PATH=%POP2_PIPELINE_DIR%\latest_NUKE
"C:\Program Files\Nuke9.0v8\Nuke9.0.exe" --nukex --nc
