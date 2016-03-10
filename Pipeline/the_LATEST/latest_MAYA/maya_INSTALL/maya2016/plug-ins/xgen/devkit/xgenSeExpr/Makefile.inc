#-
# ==========================================================================
# Copyright (c) 2012 Autodesk, Inc.
# All rights reserved.
# 
# These coded instructions, statements, and computer programs contain
# unpublished proprietary information written by Autodesk, Inc., and are
# protected by Federal copyright law. They may not be disclosed to third
# parties or copied or duplicated in any form, in whole or in part, without
# the prior written consent of Autodesk, Inc.
# ==========================================================================
#+

xgenSeExpr_EXTRA_INCLUDES = -I$(OPENIMAGEIO_PATH)/include -I$(MAYA_LOCATION)/plug-ins/xgen/include
xgenSeExpr_EXTRA_LFLAGS   = -L$(OPENIMAGEIO_PATH)/lib -L$(MAYA_LOCATION)/plug-ins/xgen/lib

# Turn on debug flags
# SeExprXgen_EXTRA_CFLAGS   = -g 
# SeExprXgen_EXTRA_C++FLAGS = -g 

# Overwrite the default maya plugin LFLAGS 
# since We don't want the linux_plugin.map
LFLAGS = $(C++FLAGS) -shared
#LFLAGS  += -Wl,--version-script=$(TOP)/linux_plugin.map
