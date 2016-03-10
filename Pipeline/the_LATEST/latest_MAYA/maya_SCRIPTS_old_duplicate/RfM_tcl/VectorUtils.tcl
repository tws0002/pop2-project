# Malcolm Kesson
# 21 October 2012

proc vector { pnt1 pnt2 } {
	set x [expr [lindex $pnt2 0] - [lindex $pnt1 0]]
	set y [expr [lindex $pnt2 1] - [lindex $pnt1 1]]
	set z [expr [lindex $pnt2 2] - [lindex $pnt1 2]]
	return [list $x $y $z]
	}

proc length { vec } {
	set x [lindex $vec 0]
	set y [lindex $vec 1]
	set z [lindex $vec 2] 
	return [expr sqrt($x * $x + $y * $y + $z * $z)]
	}

proc aimY {vec} {
	set x [lindex $vec 0]
	set y [lindex $vec 1]
	set z [lindex $vec 2]
	set xyLength [expr sqrt(($x * $x) + ($y * $y))]
	set vecLength [expr sqrt(($x * $x) + ($y * $y) + ($z * $z))]
  
	if {$xyLength == 0} {
		if {$x > 0} {
			set zAngle [expr 90.0 * (3.14159/180)]
		} else {
			set zAngle [expr -90.0 * (3.14159/180)]
			}
	} else {
		set zAngle [expr acos($y/$xyLength)]
		}
	set xAngle [expr acos($xyLength/$vecLength)]
	if {$z > 0}  { 
		set xAngle $xAngle
	} else {
		set xAngle -$xAngle
		}
	if {$x > 0} { 
		set zAngle -$zAngle
	} else {
		set zAngle $zAngle
		}
	set out [list [expr $xAngle / (3.14159/180)] [expr $zAngle / (3.14159/180)]]
	return $out
	}

::RMS::LogMsg INFO "Custom TCL procs in VectorUtils.tcl loaded"
