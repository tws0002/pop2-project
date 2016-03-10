REM project-wide vars
REM for linux, it's set RMANTREE/lib to LD_LIBRARY_PATH - for win, it's PATH, on OSX, it's DYLD_LIBRARY_PATH
set PATH=%RMANTREE%/lib;%PATH%;
set POP2_PROJECT_DIR=I:\Savannah\CollaborativeSpace\portal-origins-part-2;
set RMSTREE="C:\Program Files\Pixar\RenderManStudio-20.0-maya2016";
set RMANTREE="C:\Program Files\Pixar\RenderManProServer-20.0";

set PYTHONPATH=%POP2_PROJECT_DIR%\Pipeline\the_LATEST\sys_PY\py_MODULES;
REM NUKE_PATH=%POP2_PROJECT_DIR%\Pipeline\the_LATEST\latest_NUKE
REM set NUKE_PATH=%POP2_PROJECT_DIR%\Pipeline\the_LATEST\latest_NUKE
REM set NUKE_PATH=%POP2_PROJECT_DIR%\Pipeline\the_LATEST\latest_NUKE;
set NUKE_PATH=I:\Savannah\CollaborativeSpace\portal-origins-part-2\Pipeline\the_LATEST\latest_NUKE
"C:\Program Files\Nuke9.0v6\Nuke9.0.exe" --nukex
