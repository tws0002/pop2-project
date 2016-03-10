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
all : thirdPartyPlugins

endif

#
# Variable definitions
#

SRCDIR := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenArnoldProcedural
DSTDIR := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenArnoldProcedural

xgenArnoldProcedural_SOURCES  := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenArnoldProcedural/XgArnoldProcedural.cpp
xgenArnoldProcedural_OBJECTS  := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenArnoldProcedural/XgArnoldProcedural.o
xgenArnoldProcedural_PLUGIN   := $(DSTDIR)/xgenArnoldProcedural.$(EXT)
xgenArnoldProcedural_MAKEFILE := $(DSTDIR)/Makefile

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

$(xgenArnoldProcedural_OBJECTS): CFLAGS   := $(CFLAGS)   $(xgenArnoldProcedural_EXTRA_CFLAGS)
$(xgenArnoldProcedural_OBJECTS): C++FLAGS := $(C++FLAGS) $(xgenArnoldProcedural_EXTRA_C++FLAGS)
$(xgenArnoldProcedural_OBJECTS): INCLUDES := $(INCLUDES) $(xgenArnoldProcedural_EXTRA_INCLUDES)

depend_xgenArnoldProcedural:     INCLUDES := $(INCLUDES) $(xgenArnoldProcedural_EXTRA_INCLUDES)

$(xgenArnoldProcedural_PLUGIN):  LFLAGS   := $(LFLAGS) $(xgenArnoldProcedural_EXTRA_LFLAGS) 
$(xgenArnoldProcedural_PLUGIN):  LIBS     := $(LIBS)   -lai -lAdskXGen $(xgenArnoldProcedural_EXTRA_LIBS) 

#
# Rules definitions
#

.PHONY: depend_xgenArnoldProcedural clean_xgenArnoldProcedural Clean_xgenArnoldProcedural


$(xgenArnoldProcedural_PLUGIN): $(xgenArnoldProcedural_OBJECTS) 
	-rm -f $@
	$(LD) -o $@ $(LFLAGS) $^ $(LIBS)

depend_xgenArnoldProcedural :
	makedepend $(INCLUDES) $(MDFLAGS) -f$(DSTDIR)/Makefile $(xgenArnoldProcedural_SOURCES)

clean_xgenArnoldProcedural:
	-rm -f $(xgenArnoldProcedural_OBJECTS)

Clean_xgenArnoldProcedural:
	-rm -f $(xgenArnoldProcedural_MAKEFILE).bak $(xgenArnoldProcedural_OBJECTS) $(xgenArnoldProcedural_PLUGIN)


thirdPartyPlugins: $(xgenArnoldProcedural_PLUGIN)
depend:	 depend_xgenArnoldProcedural
clean:	 clean_xgenArnoldProcedural
Clean:	 Clean_xgenArnoldProcedural

