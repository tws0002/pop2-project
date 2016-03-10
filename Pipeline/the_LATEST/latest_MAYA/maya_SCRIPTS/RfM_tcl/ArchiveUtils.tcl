# Useage in a ribbox
# [cycle $F "C:/walk/pot" 24]
#
# The specified directory should contain ribs,
# pot.0001.rib to pot.0024.rib
# The rib will "loop" or "cycle".
proc cycle { frame path count } {
	set num [expr $frame % $count]
	if {$num == 0} { 
		set num $count
		}
	if {$num < 10} {
		set f "000$num"
	} elseif {$num < 100} {
		set f "00$num"
	} else {
		set f "0$num"
		}	
	set result "ReadArchive \"$path.$f.rib\"\n"
	append result "Attribute \"visibility\" \"camera\" 0\n"
	return $result
	}
::RMS::LogMsg INFO "Custom TCL procs in ArchiveUtils.tcl loaded"
