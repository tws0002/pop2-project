# M.Kesson
# Oct 2011

#--------------------------------------------------------------------
# Useage in a shadinggroup ribbox assigned to a polymesh
# [getBlobby $OBJNAME 0.5]
#
# "size" is a uniform scaling factor for each "blob".
# The mesh is marked as invisible to the camera.
proc getBlobby { objname size } {
	set tnode [mel "stringArrayToString `listRelatives -parent $objname` \"\""]
	set n [mel "polyEvaluate -v $tnode"]
	set n [lindex $n 0]
	set out ""
	# Setup the initial definition of the blobby
	append out "Blobby $n \[\n"
			
	# Make each an ellipsoid and provide its array index
	# The array indices monotonously increment by 16
	for {set i 0} {$i < $n} {incr i} {
	    append out "1001 [expr $i * 16]\n"
	    }
	# Specify the blending code "0" and the number of blobs
	append out "0 $n "
			
	# Followed by a list of the indices from the first
	# to the last blob
	for {set i 0} {$i < $n} {incr i} {
	    append out " $i"
	    }
	append out "\]\n"
			
	# Now specify the transformations of each blob
	append out "\[\n"		
	for {set i 0} {$i < $n} {incr i} {
	    set str $tnode
	    append str ".vtx\[$i\]"
	    set pnt [mel "pointPosition -local $str"]
	    set blobdata "$size 0 0 0 0 $size 0 0 0 0 \
	$size 0 $pnt 1\n"
	    append out $blobdata
	    }
	append out "\]\n"
	append out "\[\"\"\]\n"
	append out "Attribute \"visibility\" \"int camera\" 0\n"
	return $out
	}
::RMS::LogMsg INFO "Custom TCL procs in BlobbyUtils.tcl loaded"
