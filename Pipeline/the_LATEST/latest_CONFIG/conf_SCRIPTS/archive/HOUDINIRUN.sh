#!/bin/bash

export PROJECT_DIR=/home/$USER/mount/collaborative/portal-origins-part-2
# export PROJECT_DIR=/home/$USER/Dropbox/Private/my_PROJECT/proj_POP2
export PIPELINE_DIR=$PROJECT_DIR/Pipeline/the_LATEST
# export APP_EXECUTABLE=/opt/hfs15.0.347/bin/houdinifx
export APP_EXECUTABLE=/opt/hfs15.0.244.16/bin/houdinifx
export SOLIDARITY="True"
export LOG_LEVEL=debug
# sh /home/selecaotwo/Dropbox/Private/my_PROJECT/proj_POP2/Pipeline/the_LATEST/latest_HOUDINI/latest_HOUDINIRUN.sh
sh $PIPELINE_DIR/latest_HOUDINI/latest_HOUDINIRUN.sh
# source $PIPELINE_DIR/latest_HOUDINI/latest_HOUDINIRUN.sh
