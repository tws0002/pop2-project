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

SRCDIR := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenSampleModules
DSTDIR := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenSampleModules

xgenSampleModules_SOURCES  := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenSampleModules/XgGravityFXModule.cpp $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenSampleModules/XgCrossGenerator.cpp $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenSampleModules/XgOFFRenderer.cpp
xgenSampleModules_OBJECTS  := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenSampleModules/XgGravityFXModule.o $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenSampleModules/XgCrossGenerator.o $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenSampleModules/XgOFFRenderer.o
xgenSampleModules_PLUGIN   := $(DSTDIR)/xgenSampleModules.$(EXT)
xgenSampleModules_MAKEFILE := $(DSTDIR)/Makefile

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

$(xgenSampleModules_OBJECTS): CFLAGS   := $(CFLAGS)   $(xgenSampleModules_EXTRA_CFLAGS)
$(xgenSampleModules_OBJECTS): C++FLAGS := $(C++FLAGS) $(xgenSampleModules_EXTRA_C++FLAGS)
$(xgenSampleModules_OBJECTS): INCLUDES := $(INCLUDES) $(xgenSampleModules_EXTRA_INCLUDES)

depend_xgenSampleModules:     INCLUDES := $(INCLUDES) $(xgenSampleModules_EXTRA_INCLUDES)

$(xgenSampleModules_PLUGIN):  LFLAGS   := $(LFLAGS) $(xgenSampleModules_EXTRA_LFLAGS) 
$(xgenSampleModules_PLUGIN):  LIBS     := $(LIBS)   -lXGen -lAdskXGen -ltbb $(xgenSampleModules_EXTRA_LIBS) 

#
# Rules definitions
#

.PHONY: depend_xgenSampleModules clean_xgenSampleModules Clean_xgenSampleModules


$(xgenSampleModules_PLUGIN): $(xgenSampleModules_OBJECTS) 
	-rm -f $@
	$(LD) -o $@ $(LFLAGS) $^ $(LIBS)

depend_xgenSampleModules :
	makedepend $(INCLUDES) $(MDFLAGS) -f$(DSTDIR)/Makefile $(xgenSampleModules_SOURCES)

clean_xgenSampleModules:
	-rm -f $(xgenSampleModules_OBJECTS)

Clean_xgenSampleModules:
	-rm -f $(xgenSampleModules_MAKEFILE).bak $(xgenSampleModules_OBJECTS) $(xgenSampleModules_PLUGIN)


prebuiltPlugins: $(xgenSampleModules_PLUGIN)
depend:	 depend_xgenSampleModules
clean:	 clean_xgenSampleModules
Clean:	 Clean_xgenSampleModules

