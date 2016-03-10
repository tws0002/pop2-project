================================================
		  ABOUT
================================================

ZV Radial Blend Shape 3.0.1
Copyright © 2010 Paolo Dominici
Date: 2015/05/03
License: MIT
E-mail: paolodominici@gmail.com
Web: http://www.paolodominici.com


================================================
		INSTALLATION
================================================

1. Place "zvRadialBlendShape.py" in your script folder:

   Win XP: "C:\Documents and Settings\USERNAME\My Documents\maya\scripts"
   Win Vista/7/8: "C:\Users\USERNAME\Documents\maya\scripts"

2. Place the plugin "radialBlendShape.mll" in your plugin folder
   (create it if you don't have one):

   Win XP: "C:\Documents and Settings\USERNAME\My Documents\maya\MAYAVERSION\plug-ins"
   Win Vista/7/8: "C:\Users\USERNAME\Documents\maya\MAYAVERSION\plug-ins"

3. In Maya open the Script Editor and go to the Python tab, copy and paste these two lines below:

########################

import zvRadialBlendShape
zvRadialBlendShape.zvRadialBlendShape()

########################

4. Highlight it and click on "Save Script to Shelf...", specify a name and click "OK".


================================================
		    TRY IT!
================================================

To make sure the ZVRBS plugin is properly installed, start Maya and open the "rbs_demo.ma" scene file.


================================================
		     HELP
================================================

A full walkthrough is available at:

http://www.paolodominici.com/products/zvradialblendshape/


================================================
		RELEASE NOTES
================================================
3.0.1
- Minor UI fix to make it compatible with Maya 2016

3.0
- Removed curvature.
- Added control support.

2.0
- Changed from cylindrical to spherical coordinates.
- Added blink.
- Added follow.
- Added cornea deformation.

1.0
- First public version.
