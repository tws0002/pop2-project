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

SRCDIR := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenRendermanProcedural
DSTDIR := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenRendermanProcedural

xgenRendermanProcedural_SOURCES  := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenRendermanProcedural/XgRendermanProcedural.cpp
xgenRendermanProcedural_OBJECTS  := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenRendermanProcedural/XgRendermanProcedural.o
xgenRendermanProcedural_PLUGIN   := $(DSTDIR)/xgenRendermanProcedural.$(EXT)
xgenRendermanProcedural_MAKEFILE := $(DSTDIR)/Makefile

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

$(xgenRendermanProcedural_OBJECTS): CFLAGS   := $(CFLAGS)   $(xgenRendermanProcedural_EXTRA_CFLAGS)
$(xgenRendermanProcedural_OBJECTS): C++FLAGS := $(C++FLAGS) $(xgenRendermanProcedural_EXTRA_C++FLAGS)
$(xgenRendermanProcedural_OBJECTS): INCLUDES := $(INCLUDES) $(xgenRendermanProcedural_EXTRA_INCLUDES)

depend_xgenRendermanProcedural:     INCLUDES := $(INCLUDES) $(xgenRendermanProcedural_EXTRA_INCLUDES)

$(xgenRendermanProcedural_PLUGIN):  LFLAGS   := $(LFLAGS) $(xgenRendermanProcedural_EXTRA_LFLAGS) 
$(xgenRendermanProcedural_PLUGIN):  LIBS     := $(LIBS)   -lprman -lAdskXGen $(xgenRendermanProcedural_EXTRA_LIBS) 

#
# Rules definitions
#

.PHONY: depend_xgenRendermanProcedural clean_xgenRendermanProcedural Clean_xgenRendermanProcedural


$(xgenRendermanProcedural_PLUGIN): $(xgenRendermanProcedural_OBJECTS) 
	-rm -f $@
	$(LD) -o $@ $(LFLAGS) $^ $(LIBS)

depend_xgenRendermanProcedural :
	makedepend $(INCLUDES) $(MDFLAGS) -f$(DSTDIR)/Makefile $(xgenRendermanProcedural_SOURCES)

clean_xgenRendermanProcedural:
	-rm -f $(xgenRendermanProcedural_OBJECTS)

Clean_xgenRendermanProcedural:
	-rm -f $(xgenRendermanProcedural_MAKEFILE).bak $(xgenRendermanProcedural_OBJECTS) $(xgenRendermanProcedural_PLUGIN)


thirdPartyPlugins: $(xgenRendermanProcedural_PLUGIN)
depend:	 depend_xgenRendermanProcedural
clean:	 clean_xgenRendermanProcedural
Clean:	 Clean_xgenRendermanProcedural

