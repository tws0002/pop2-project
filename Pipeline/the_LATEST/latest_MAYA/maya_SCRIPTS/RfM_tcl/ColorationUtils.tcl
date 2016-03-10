
# Useage in a ribbox
# [getRandomColor $OBJNAME]
#
# Sets a random color based on the all the digits 
# in the name of the shape node.
proc getRandomColor { shapeName } {
	# grab ALL the digits in the name
	regsub -all {[^0-9]} $shapeName "" n
	if {$n == "" || [string is integer $n] == 0} {
		set n 1
		}
	set ignore_me [expr srand($n)]
	set r [expr rand()]
	set g [expr rand()]
	set b [expr rand()]
	return "Color $r $g $b"
	}
		
# Useage in a ribbox
# [getColor $OBJNAME]
#
# Sets a random color based on the last digit at 
# the end of the shape node name.
proc getColor { shapeName } {
	set n [string range $shapeName end end]
	if {[string is integer $n] == 0} {
	    set n 1
	    }
	set ignore_me [expr srand($n)]
	set r [expr rand()]
	set g [expr rand()]
	set b [expr rand()]
	return "Color $r $g $b"
	}	
	
# Useage in a ribbox
# [getLeafColor $OBJNAME]
#
# Sets a color from the lookup table based on the 
# digit at the end of the shape node name.
proc getLeafColor { shapeName } {
	set LUT {
		{0.611 0.796 0.545} 
		{0.521 0.764 0.431} 
		{0.521 0.745 0.443} 
		{0.552 0.694 0.501} 
		{0.490 0.701 0.415} 
		{0.317 0.396 0.294} 
		{0.396 0.713 0.282} 
		{0.403 0.458 0.384} 
		{0.250 0.376 0.207} 
		{0.321 0.545 0.239} }
	# grab ONLY the last digit at the end of the name
	set n [string range $shapeName end end]
	set comps [lindex $LUT $n]
	return "Color $comps"
	}	
::RMS::LogMsg INFO "Custom TCL procs in ColorationUtils.tcl loaded"
