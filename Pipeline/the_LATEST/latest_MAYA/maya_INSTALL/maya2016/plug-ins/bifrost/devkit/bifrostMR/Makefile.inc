#-
# ==========================================================================
# Copyright (c) 2014 Autodesk, Inc.
# All rights reserved.
# 
# These coded instructions, statements, and computer programs contain
# unpublished proprietary information written by Autodesk, Inc., and are
# protected by Federal copyright law. They may not be disclosed to third
# parties or copied or duplicated in any form, in whole or in part, without
# the prior written consent of Autodesk, Inc.
# ==========================================================================
#+

# MENTALRAY_LOCATION = /usr/autodesk/mentalray
ifeq ($(MENTALRAY_LOCATION),)
    $(error The MENTALRAY_LOCATION environment variable does not point to the \
        directory where Mentalray for Maya is installed)
endif

bifrostMR_EXTRA_INCLUDES = -I$(MENTALRAY_LOCATION)/devkit/include -I$(MAYA_LOCATION)/plug-ins/bifrost/include/common \
    -I$(MAYA_LOCATION)/plug-ins/bifrost/include/modules/aminomath/api \
    -I$(MAYA_LOCATION)/plug-ins/bifrost/include/modules/bifrostcore/api \
    -I$(MAYA_LOCATION)/plug-ins/bifrost/include/modules/bifrostapi/api
bifrostMR_EXTRA_C++FLAGS = -g -std=c++11
bifrostMR_EXTRA_LFLAGS   = -L$(MAYA_LOCATION)/plug-ins/bifrost/lib

CXX = g++
LFLAGS = $(C++FLAGS) -g -Wl,-Bsymbolic -shared -Wl,--version-script=bifrostMR.map


