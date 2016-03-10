#!/bin/sh

# This script is expected to run on both Linux and MacOS
darwin=false

case "`uname`" in
Darwin*) darwin=true;;
esac

# Resolve soft links
PRG="$0"

while [ -h "$PRG" ]; do
    ls=`ls -ld "$PRG"`
	link=`expr "$ls" : '.*-> \(.*\)$'`
	if expr "$link" : '/.*' > /dev/null; then
	    PRG="$link"
	else
	    PRG=`dirname "$PRG"`/"$link"
	fi
done

PRGDIR=`dirname "$PRG"`

# Make a guess of MAYA_LOCATION based on relative path
# Only set if MAYA_LOCATION is not manually defined
if $darwin; then
	[ -z "$MAYA_LOCATION" ] && MAYA_LOCATION=`cd "$PRGDIR/../../../../../Maya.app/Contents" >/dev/null; pwd`
else
	[ -z "$MAYA_LOCATION" ] && MAYA_LOCATION=`cd "$PRGDIR/../../../../.." >/dev/null; pwd`
fi

# Check if we have a valid MAYA_LOCATION
if $darwin; then
    if [ ! -r "$MAYA_LOCATION"/../../plug-ins/bifrost/bin/libbifrostapi.dylib ]; then
        echo "MAYA_LOCATION should point to your Maya Runtime folder"
    	exit 1
    fi
else
    if [ ! -r "$MAYA_LOCATION"/plug-ins/bifrost/lib/libbifrostapi.so ]; then
        echo "MAYA_LOCATION should point to your Maya Runtime folder"
    	exit 1
    fi
fi

# Append to LD_LIBRARY_PATH or DYLD_LIBRARY_PATH
if $darwin; then
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$MAYA_LOCATION/MacOS:$MAYA_LOCATION/../../plug-ins/bifrost/bin
else
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MAYA_LOCATION/lib:$MAYA_LOCATION/plug-ins/bifrost/lib
fi

# Execute bif2prt
exec "$PRGDIR"/bif2prt "$@"
