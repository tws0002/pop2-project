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

SRCDIR := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenSeExpr
DSTDIR := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenSeExpr

xgenSeExpr_SOURCES  := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenSeExpr/register.cpp $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenSeExpr/xgTex2DFunc.cpp
xgenSeExpr_OBJECTS  := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenSeExpr/register.o $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenSeExpr/xgTex2DFunc.o
xgenSeExpr_PLUGIN   := $(DSTDIR)/xgenSeExpr.$(EXT)
xgenSeExpr_MAKEFILE := $(DSTDIR)/Makefile

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

$(xgenSeExpr_OBJECTS): CFLAGS   := $(CFLAGS)   $(xgenSeExpr_EXTRA_CFLAGS)
$(xgenSeExpr_OBJECTS): C++FLAGS := $(C++FLAGS) $(xgenSeExpr_EXTRA_C++FLAGS)
$(xgenSeExpr_OBJECTS): INCLUDES := $(INCLUDES) $(xgenSeExpr_EXTRA_INCLUDES)

depend_xgenSeExpr:     INCLUDES := $(INCLUDES) $(xgenSeExpr_EXTRA_INCLUDES)

$(xgenSeExpr_PLUGIN):  LFLAGS   := $(LFLAGS) $(xgenSeExpr_EXTRA_LFLAGS) 
$(xgenSeExpr_PLUGIN):  LIBS     := $(LIBS)   -lOpenImageIO -lAdskXGen -lAdskSeExpr $(xgenSeExpr_EXTRA_LIBS) 

#
# Rules definitions
#

.PHONY: depend_xgenSeExpr clean_xgenSeExpr Clean_xgenSeExpr


$(xgenSeExpr_PLUGIN): $(xgenSeExpr_OBJECTS) 
	-rm -f $@
	$(LD) -o $@ $(LFLAGS) $^ $(LIBS)

depend_xgenSeExpr :
	makedepend $(INCLUDES) $(MDFLAGS) -f$(DSTDIR)/Makefile $(xgenSeExpr_SOURCES)

clean_xgenSeExpr:
	-rm -f $(xgenSeExpr_OBJECTS)

Clean_xgenSeExpr:
	-rm -f $(xgenSeExpr_MAKEFILE).bak $(xgenSeExpr_OBJECTS) $(xgenSeExpr_PLUGIN)


thirdPartyPlugins: $(xgenSeExpr_PLUGIN)
depend:	 depend_xgenSeExpr
clean:	 clean_xgenSeExpr
Clean:	 Clean_xgenSeExpr

