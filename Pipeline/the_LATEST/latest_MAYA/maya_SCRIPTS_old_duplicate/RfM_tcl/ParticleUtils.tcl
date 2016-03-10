# M.Kesson
# Oct 2011
#
# "addLight" and "activateLights" must be used in two shadinggroup
# ribboxes. The first is assigned to a particle system. The second
# should be assigned to a surface or surfaces that will be illuminated
# by the lights that "addLight" will instance for each particle
# in the system.
# The shadinggroup ribbox assigned to the particles should have the
# following command,
#   [addLight $OBJNAME 0.005]	
proc addLight { tnode { intensity 0.1 } } {
	global ::count
	set ::count 0
	set num  [mel "particle -q -ct $tnode"]
	set out ""
	for {set n 1} {$n <= $num} {incr n} {
		set str $tnode
	    append str ".pt\[$n\]"
	    set pnt [mel "getParticleAttr -at position $str"]
		set x   [lindex $pnt 0]
    set y   [lindex $pnt 1]
    set z   [lindex $pnt 2]
	    append out "TransformBegin\n"
	    append out "    Translate $x $y $z\n"
	    append out "    LightSource \"pointlight\" $n \"intensity\" $intensity \"from\" \[0 0 0\]\n"
		append out "    Illuminate $n 0\n"
	    append out "TransformEnd\n"
		incr ::count
		}
	append out "Attribute \"visibility\" \"int camera\" 0\n"
	return $out
	}
	
# The shadinggroup ribbox assigned to the surface(s) to be illuminated
# by the particle lights should have the following command in its ribbox.
#   [activateLights]	
proc activateLights { } {
	global ::count
	set out ""
	for {set a 1} {$a <= $count} {incr a} {
		append out "Illuminate $a 1\n"
		}
	return $out
	}
::RMS::LogMsg INFO "Custom TCL procs in ParticleUtils.tcl loaded"
