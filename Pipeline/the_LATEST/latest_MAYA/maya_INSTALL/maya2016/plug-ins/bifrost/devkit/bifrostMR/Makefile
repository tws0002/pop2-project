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

SRCDIR := $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR
DSTDIR := $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR

bifrostMR_SOURCES  := $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostChannelLookup.cpp $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostDensityVolume.cpp $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostHelpers.cpp $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostIf.cpp $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostIllumFlat.cpp $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostIsosurfaceGeo.cpp $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostIsosurfaceParticleVolume.cpp $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostIsosurfaceVolume.cpp $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostMixVorticityVelocities.cpp $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostObjectUserData.cpp $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostParticleGeo.cpp $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostParticleVolume.cpp $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostRemap.cpp $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostSimpleScatter.cpp $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostVolumeGeo.cpp $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostVoxelSamplerPool.cpp
bifrostMR_OBJECTS  := $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostChannelLookup.o $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostDensityVolume.o $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostHelpers.o $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostIf.o $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostIllumFlat.o $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostIsosurfaceGeo.o $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostIsosurfaceParticleVolume.o $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostIsosurfaceVolume.o $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostMixVorticityVelocities.o $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostObjectUserData.o $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostParticleGeo.o $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostParticleVolume.o $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostRemap.o $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostSimpleScatter.o $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostVolumeGeo.o $(TOP)/../../../../runTime/plug-ins/bifrost/devkit/bifrostMR/bifrostVoxelSamplerPool.o
bifrostMR_PLUGIN   := $(DSTDIR)/bifrostMR.$(EXT)
bifrostMR_MAKEFILE := $(DSTDIR)/Makefile

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

$(bifrostMR_OBJECTS): CFLAGS   := $(CFLAGS)   $(bifrostMR_EXTRA_CFLAGS)
$(bifrostMR_OBJECTS): C++FLAGS := $(C++FLAGS) $(bifrostMR_EXTRA_C++FLAGS)
$(bifrostMR_OBJECTS): INCLUDES := $(INCLUDES) $(bifrostMR_EXTRA_INCLUDES)

depend_bifrostMR:     INCLUDES := $(INCLUDES) $(bifrostMR_EXTRA_INCLUDES)

$(bifrostMR_PLUGIN):  LFLAGS   := $(LFLAGS) $(bifrostMR_EXTRA_LFLAGS) 
$(bifrostMR_PLUGIN):  LIBS     := $(LIBS)   -lbifrostapi $(bifrostMR_EXTRA_LIBS) 

#
# Rules definitions
#

.PHONY: depend_bifrostMR clean_bifrostMR Clean_bifrostMR


$(bifrostMR_PLUGIN): $(bifrostMR_OBJECTS) 
	-rm -f $@
	$(LD) -o $@ $(LFLAGS) $^ $(LIBS)

depend_bifrostMR :
	makedepend $(INCLUDES) $(MDFLAGS) -f$(DSTDIR)/Makefile $(bifrostMR_SOURCES)

clean_bifrostMR:
	-rm -f $(bifrostMR_OBJECTS)

Clean_bifrostMR:
	-rm -f $(bifrostMR_MAKEFILE).bak $(bifrostMR_OBJECTS) $(bifrostMR_PLUGIN)


plugins: $(bifrostMR_PLUGIN)
depend:	 depend_bifrostMR
clean:	 clean_bifrostMR
Clean:	 Clean_bifrostMR

