# 1 	Create spotlight.
# 2 	Set its position, press 'T', set its target.
# 3 	RMS 18 Ignore steps 3 and 4
#		Choose the shape tab ("spotLightShape1") and select,
#			Attributes->RenderMan->Add Shadow Attrs
#			Attributes->RenderMan->Add Custom Deep Shadow Map
# 4 	Open RenderMan Controls and set rmanDeepShadowPass,
#			Resolution to 256
#			Shading Rate to 5
# 5 	Open slim, create a base volume node. Right mouse
#		click on the node and choose "Add to Scene".
# 6 	Choose the transform tab ("spotLight1") and select,
#			Attributes->RenderMan->Add Custom Shading Group
# 7 	Open the "Extra RenderMan Attributes" panel.Right 
#		mouse click in "Custom ShadingGroup" text field and
#		choose "BaseVolumeSG".
# 8 	Select BaseVolumeSG tab and select,
#			Attributes->RenderMan->Add RIB Box
# 9 	Select RIB Box Interpolation "TCL".
# 10 	Enter the following code in the Rib Box,
#			[volumespot]
# 11	RMS 4 Only.
#		To calculate deep shadow detail in the volume use,
#			[volumespot 10 1]
#		where "10" is the voxalization of the Volume "cone"
# Malcolm Kesson
# 29 Jan 2012
# 23 Apr 2012 Works now with environment light
# 25 Jan 2014 Added two Attributes and test for RMS18
# 			  pass_class "preview".
proc volumespot {  { voxels 10 } { deep_shd_vis 0} } {
	# Link our local variable tnode (ie. name of the transform
	# node) to the pre-defined variable created by RfM.
	upvar OBJPATH tnode 
	set snode [mel "listRelatives -shapes $tnode"]
	
	set cone [mel "getAttr $snode.coneAngle"]
	set penum [mel "getAttr $snode.penumbraAngle"]
	set cone [expr $cone + ($penum * 2) + 2.0]
	set angle [expr $cone * 0.75 * 0.01745]
	set zdist [mel "getAttr $snode.centerOfIllumination"]
	# Find the xy bounds
	set xy [expr tan($angle) * $zdist]
	set cmnt "#"
	if {$deep_shd_vis} {
		set cmnt ""
		}

	# We assume 0.05 is a reasonable minlength for the final render pass
	set rib    "IfBegin \"\$user:pass_class == 'Final'\"\n"
	append rib  "    Attribute \"dice\" \"float minlength\" 0.05\n"
	append rib "Else\n"
	append rib  "    Attribute \"dice\" \"float minlength\" 0.1\n"
	append rib "IfEnd\n"
	
	set dice_space "Attribute \"dice\" \"string minlengthspace\" \"world\""
	set geo_volume "Volume \"cone\" \[-$xy $xy -$xy $xy -$zdist 0\] \[$voxels $voxels $voxels\]"
	
	append rib "IfBegin \"\$user:pass_class == 'Final' || \$user:pass_class == 'Preview'\"\n"
	append rib "    $dice_space\n"
	append rib "    $geo_volume\n"
	append rib "Else\n"
	append rib "    $cmnt$dice_space\n"
	append rib "    $cmnt$geo_volume\n"
	append rib "IfEnd"
	return $rib
	}

proc volumebox { name } {
	set type "box"
	
	if {[string match "*Sphere*" $name]}  {
		set type "ellipsoid"
		}
	if {[string match "*Cone*" $name]}  {
		set type "cone"
		}
	if {[string match "*Cylinder*" $name]}  {
		set type "cylinder"
		}		
	set bb [mel "getAttr $name.boundingBoxSize"]	
	set w [expr double([lindex $bb 0])/2]
	set h [expr double([lindex $bb 1])/2]
	set d [expr double([lindex $bb 2])/2]
			
	set rib "Rotate -90 1 0 0 \n"
	if {[string equal $type "box"]} {
		set rib ""
		}
	append rib "IfBegin \"\$user:pass_class == 'Final'\" \n"
	append rib "    Volume \"$type\" \[-$w $w -$h $h -$d $d\] \[20 20 20\] \n"
	append rib "IfEnd\n"
	append rib "Attribute \"visibility\" \"camera\" 0 \n"
	return $rib
	}
