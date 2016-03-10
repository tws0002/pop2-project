# Malcolm Kesson
# 21 October 2012
#
# Workflow
# 1	 Create a curve and use mel "rebuildCurve".
# 2	 Transform tab, Attribute->RenderMan->Add Custom Shading Group.
# 3  InitialShadingGroup, Attribute->RenderMan->Add Ribbox.
# 4  Ribbox dropdown menu change "None" to "TCL".
# 5  Copy and paste the following command into the Ribbox,
#    don't forget the opening and closing square brackets.
#         [chain $OBJNAME 20 0.5 0.2]
# This will put 20 links along the path of the curve with a link
# width to link length ratio (proportions) of 0.5 and a link 
# thickness of 0.2.
# Revisions:
#   Jan 26 2014 proc now adds links upto a curves max_u value.
proc chain { OBJNAME numchains hr thick} {	
	# In the case of a rebuilt curve u_max will be 1.0, otherwise,
	# is will be a larger value, say, 4.
	set u_max [mel "getAttr $OBJNAME.maxValue"]
	set u_step [expr double($u_max)/($numchains - 0)]	
	
	set rib ""
	set flip 0
	for {set u 0} {$u < $u_max} {set u [expr $u + $u_step] } {
		set next_u [expr $u + $u_step]
		set pnt 	 [mel "pointOnCurve -pr $u -p $OBJNAME"]
		set next_pnt [mel "pointOnCurve -pr $next_u -p $OBJNAME"]
	
		# Get the transformations to position and orientate a link
		set vec [vector $pnt $next_pnt]
		# The proc "aimY" is implemented in VectorUtils.tcl. Consequently, 
		# VectorUtils.tcl must also be in the same directory as this script.
		set rot [aimY $vec]
		set xrot [lindex $rot 0]
		set zrot [lindex $rot 1]
		set x   [lindex $pnt 0]
	    set y   [lindex $pnt 1]
	   	set z   [lindex $pnt 2]	
		# Link lengths may vary depending on the uniformity of the curve
		set linklen [length $vec]
		
		append rib "AttributeBegin # $u\n"
		append rib "  Identity\n"
		append rib "  Translate $x $y $z\n"
		append rib "  Rotate $zrot 0 0 1\n"
		append rib "  Rotate $xrot 1 0 0\n"
		if {$flip} {
			append rib "  Rotate 90 0 1 0\n"
			set flip 0
		} else {
			set flip 1
			}
		append rib "  [linkgen $linklen $hr $thick]\n"
		append rib "AttributeEnd\n"
		}
	return $rib
	}

# This proc is used internally to create a single link constructed
# from two quadric torii and two quadric cylinders.
proc linkgen {L ratio thick} {
	set W [expr $L * $ratio]
	set R [expr double($W) / 2]
	set r [expr double($thick)/2]
	# delta is used to shift the torii to avoid gaps in the chain.
	set delta [expr $R - $r]
	
	# Because the distance between the two torii has been reduced
	# the length of the cylinders must also be reduced.
	set linklen [expr $L - 2.0 * $delta]
	set rib "AttributeBegin\n"
	append rib "    Translate 0 $delta 0\n"
	append rib "    TransformBegin\n"
	append rib "        Rotate 180.0 0 0 1\n"
	append rib "        Torus $R $r 0 360 180.0\n"
	append rib "    TransformEnd\n"
	append rib "    TransformBegin\n"
	append rib "        Translate 0.0 $linklen 0.0\n"
	append rib "        Torus $R $r 0.0 360 180.0\n"
	append rib "    TransformEnd\n"
	append rib "    Rotate -90.0  1 0 0\n"
	append rib "    TransformBegin\n"	
	append rib "        Translate $R 0 0\n"
	append rib "        Cylinder $r 0.0 $linklen  360.0\n"
	append rib "        Translate [expr -2.0 * $R] 0 0\n"
	append rib "        Cylinder $r 0.0 $linklen  360.0\n"
	append rib "    TransformEnd\n"
	append rib "AttributeEnd\n"
	return $rib
	}
::RMS::LogMsg INFO "Custom TCL procs in ChainUtils.tcl loaded"
