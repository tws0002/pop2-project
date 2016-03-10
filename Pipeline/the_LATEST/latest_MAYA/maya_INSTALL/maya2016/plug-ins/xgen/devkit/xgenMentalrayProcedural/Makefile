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
all : plugins

endif

#
# Variable definitions
#

SRCDIR := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenMentalrayProcedural
DSTDIR := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenMentalrayProcedural

xgenMentalrayProcedural_SOURCES  := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenMentalrayProcedural/XgMentalrayProcedural.cpp $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenMentalrayProcedural/XgHairUtil.cpp $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenMentalrayProcedural/XgSeExpr.cpp
xgenMentalrayProcedural_OBJECTS  := $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenMentalrayProcedural/XgMentalrayProcedural.o $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenMentalrayProcedural/XgHairUtil.o $(TOP)/../../../../runTime/plug-ins/xgen/devkit/xgenMentalrayProcedural/XgSeExpr.o
xgenMentalrayProcedural_PLUGIN   := $(DSTDIR)/xgenMentalrayProcedural.$(EXT)
xgenMentalrayProcedural_MAKEFILE := $(DSTDIR)/Makefile

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

$(xgenMentalrayProcedural_OBJECTS): CFLAGS   := $(CFLAGS)   $(xgenMentalrayProcedural_EXTRA_CFLAGS)
$(xgenMentalrayProcedural_OBJECTS): C++FLAGS := $(C++FLAGS) $(xgenMentalrayProcedural_EXTRA_C++FLAGS)
$(xgenMentalrayProcedural_OBJECTS): INCLUDES := $(INCLUDES) $(xgenMentalrayProcedural_EXTRA_INCLUDES)

depend_xgenMentalrayProcedural:     INCLUDES := $(INCLUDES) $(xgenMentalrayProcedural_EXTRA_INCLUDES)

$(xgenMentalrayProcedural_PLUGIN):  LFLAGS   := $(LFLAGS) $(xgenMentalrayProcedural_EXTRA_LFLAGS) 
$(xgenMentalrayProcedural_PLUGIN):  LIBS     := $(LIBS)   -lAdskXGen -lAdskSeExpr -ltbb $(xgenMentalrayProcedural_EXTRA_LIBS) 

#
# Rules definitions
#

.PHONY: depend_xgenMentalrayProcedural clean_xgenMentalrayProcedural Clean_xgenMentalrayProcedural


$(xgenMentalrayProcedural_PLUGIN): $(xgenMentalrayProcedural_OBJECTS) 
	-rm -f $@
	$(LD) -o $@ $(LFLAGS) $^ $(LIBS)

depend_xgenMentalrayProcedural :
	makedepend $(INCLUDES) $(MDFLAGS) -f$(DSTDIR)/Makefile $(xgenMentalrayProcedural_SOURCES)

clean_xgenMentalrayProcedural:
	-rm -f $(xgenMentalrayProcedural_OBJECTS)

Clean_xgenMentalrayProcedural:
	-rm -f $(xgenMentalrayProcedural_MAKEFILE).bak $(xgenMentalrayProcedural_OBJECTS) $(xgenMentalrayProcedural_PLUGIN)


plugins: $(xgenMentalrayProcedural_PLUGIN)
depend:	 depend_xgenMentalrayProcedural
clean:	 clean_xgenMentalrayProcedural
Clean:	 Clean_xgenMentalrayProcedural

