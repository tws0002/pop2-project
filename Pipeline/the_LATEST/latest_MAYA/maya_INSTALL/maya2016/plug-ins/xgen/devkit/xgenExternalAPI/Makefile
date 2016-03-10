#-
# ==========================================================================
# Copyright (c) 2011 Autodesk, Inc.
# All rights reserved.
# 
# These coded instructions, statements, and computer programs contain
# unpublished proprietary information written by Autodesk, Inc., and are
# protected by Federal copyright law. They may not be disclosed to third
# parties or copied or duplicated in any form, in whole or in part, without
# the prior written consent of Autodesk, Inc.
# ==========================================================================
#+

ifndef INCL_BUILDRULES

#
# Include platform specific build settings
#
TOP := ../../../../../Extra/devkitBase/devkit/plug-ins
include $(TOP)/buildrules


#
# Always build the local plug-in when make is invoked from the
# directory.
#
all : prebuiltPlugins

endif

#
# Variable definitions
#

SRCDIR := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenExternalAPI
DSTDIR := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenExternalAPI

xgenExternalAPI_SOURCES  := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenExternalAPI/testXgExternalAPI.cpp $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenExternalAPI/testCreateDescription.cpp
xgenExternalAPI_OBJECTS  := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenExternalAPI/testXgExternalAPI.o $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenExternalAPI/testCreateDescription.o
xgenExternalAPI_PLUGIN   := $(DSTDIR)/xgenExternalAPI.$(EXT)
xgenExternalAPI_MAKEFILE := $(DSTDIR)/Makefile

#
# Include the optional per-plugin Makefile.inc
#
#    The file can contain macro definitions such as:
#       {pluginName}_EXTRA_CFLAGS
#       {pluginName}_EXTRA_C++FLAGS
#       {pluginName}_EXTRA_INCLUDES
#       {pluginName}_EXTRA_LIBS
-include $(SRCDIR)/Makefile.inc


#
# Set target specific flags.
#

$(xgenExternalAPI_OBJECTS): CFLAGS   := $(CFLAGS)   $(xgenExternalAPI_EXTRA_CFLAGS)
$(xgenExternalAPI_OBJECTS): C++FLAGS := $(C++FLAGS) $(xgenExternalAPI_EXTRA_C++FLAGS)
$(xgenExternalAPI_OBJECTS): INCLUDES := $(INCLUDES) $(xgenExternalAPI_EXTRA_INCLUDES)

depend_xgenExternalAPI:     INCLUDES := $(INCLUDES) $(xgenExternalAPI_EXTRA_INCLUDES)

$(xgenExternalAPI_PLUGIN):  LFLAGS   := $(LFLAGS) $(xgenExternalAPI_EXTRA_LFLAGS) 
$(xgenExternalAPI_PLUGIN):  LIBS     := $(LIBS)   -lOpenMaya -lFoundation -lXGen -lAdskXGen -ltbb $(xgenExternalAPI_EXTRA_LIBS) 

#
# Rules definitions
#

.PHONY: depend_xgenExternalAPI clean_xgenExternalAPI Clean_xgenExternalAPI


$(xgenExternalAPI_PLUGIN): $(xgenExternalAPI_OBJECTS) 
	-rm -f $@
	$(LD) -o $@ $(LFLAGS) $^ $(LIBS)

depend_xgenExternalAPI :
	makedepend $(INCLUDES) $(MDFLAGS) -f$(DSTDIR)/Makefile $(xgenExternalAPI_SOURCES)

clean_xgenExternalAPI:
	-rm -f $(xgenExternalAPI_OBJECTS)

Clean_xgenExternalAPI:
	-rm -f $(xgenExternalAPI_MAKEFILE).bak $(xgenExternalAPI_OBJECTS) $(xgenExternalAPI_PLUGIN)


prebuiltPlugins: $(xgenExternalAPI_PLUGIN)
depend:	 depend_xgenExternalAPI
clean:	 clean_xgenExternalAPI
Clean:	 Clean_xgenExternalAPI

