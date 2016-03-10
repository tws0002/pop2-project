#
#  Makefile to Build the bif2prt converter sample
#
#  % make all
#

CC=             g++
TARGET=         ./bif2prt
SRCS=           ./bif2prt.cpp
OBJS=           ./bif2prt.o
INCLUDES=       -I. -I$(MAYA_LOCATION)/plug-ins/bifrost/include/common -I$(MAYA_LOCATION)/plug-ins/bifrost/include/modules/bifrostcore/api -I$(MAYA_LOCATION)/plug-ins/bifrost/include/modules/aminomath/api -I$(MAYA_LOCATION)/plug-ins/bifrost/include/modules/bifrostapi/api
LFLAGS=         -L$(MAYA_LOCATION)/lib -L$(MAYA_LOCATION)/plug-ins/bifrost/lib -Wl,-rpath-link=$(MAYA_LOCATION)/lib:$(MAYA_LOCATION)/plug-ins/bifrost/lib -Wl,-rpath='$$ORIGIN/../../lib:$$ORIGIN/../../../../lib' -Wl,-rpath=$(MAYA_LOCATION)/lib:$(MAYA_LOCATION)/plug-ins/bifrost/lib
CFLAGS=         -O -std=gnu++0x
LIBS=           -lbifrostapi -lz

all : $(TARGET)

clean:
	rm -f $(TARGET) $(OBJS) make.out core

$(OBJS): $(SRCS)
	$(CC) -c $(CFLAGS) $(INCLUDES) $(SRCS)

$(TARGET): $(OBJS)
	$(CC) -o $(TARGET) $(CFLAGS) $(LFLAGS) $(LIBS) $(OBJS)
