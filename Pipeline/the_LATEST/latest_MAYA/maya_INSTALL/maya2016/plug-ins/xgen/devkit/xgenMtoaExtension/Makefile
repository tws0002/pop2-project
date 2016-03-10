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

SRCDIR := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenMtoaExtension
DSTDIR := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenMtoaExtension

xgenMtoaExtension_SOURCES  := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenMtoaExtension/XgMtoaExtension.cpp
xgenMtoaExtension_OBJECTS  := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenMtoaExtension/XgMtoaExtension.o
xgenMtoaExtension_PLUGIN   := $(DSTDIR)/xgenMtoaExtension.$(EXT)
xgenMtoaExtension_MAKEFILE := $(DSTDIR)/Makefile

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

$(xgenMtoaExtension_OBJECTS): CFLAGS   := $(CFLAGS)   $(xgenMtoaExtension_EXTRA_CFLAGS)
$(xgenMtoaExtension_OBJECTS): C++FLAGS := $(C++FLAGS) $(xgenMtoaExtension_EXTRA_C++FLAGS)
$(xgenMtoaExtension_OBJECTS): INCLUDES := $(INCLUDES) $(xgenMtoaExtension_EXTRA_INCLUDES)

depend_xgenMtoaExtension:     INCLUDES := $(INCLUDES) $(xgenMtoaExtension_EXTRA_INCLUDES)

$(xgenMtoaExtension_PLUGIN):  LFLAGS   := $(LFLAGS) $(xgenMtoaExtension_EXTRA_LFLAGS) 
$(xgenMtoaExtension_PLUGIN):  LIBS     := $(LIBS)   -lai -lmtoa_api $(xgenMtoaExtension_EXTRA_LIBS) 

#
# Rules definitions
#

.PHONY: depend_xgenMtoaExtension clean_xgenMtoaExtension Clean_xgenMtoaExtension


$(xgenMtoaExtension_PLUGIN): $(xgenMtoaExtension_OBJECTS) 
	-rm -f $@
	$(LD) -o $@ $(LFLAGS) $^ $(LIBS)

depend_xgenMtoaExtension :
	makedepend $(INCLUDES) $(MDFLAGS) -f$(DSTDIR)/Makefile $(xgenMtoaExtension_SOURCES)

clean_xgenMtoaExtension:
	-rm -f $(xgenMtoaExtension_OBJECTS)

Clean_xgenMtoaExtension:
	-rm -f $(xgenMtoaExtension_MAKEFILE).bak $(xgenMtoaExtension_OBJECTS) $(xgenMtoaExtension_PLUGIN)


thirdPartyPlugins: $(xgenMtoaExtension_PLUGIN)
depend:	 depend_xgenMtoaExtension
clean:	 clean_xgenMtoaExtension
Clean:	 Clean_xgenMtoaExtension

