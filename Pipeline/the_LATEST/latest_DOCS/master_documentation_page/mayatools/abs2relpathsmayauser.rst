Maya - Absolute To Relative Paths User Guide
*******************************************************************************

Installation
===============================================================================
The abs2rel module is broken into two sections, "scripts" which can be placed
in the user's script directory and "icons", which are simply a couple icons
used for the shelf buttons used by the scripts.

If you're on Linux and your Maya install is "default", your path is:
/home/$USER/maya/maya_year/scripts

userSetup.mel
-------------------------------------------------------------------------------
Simply place all files/folders in abs2rel's script directory there. If you have
a userSetup.mel file in this location or elsewhere already, simply add the
lines of this one to that and you'll be good to go.

Usage
===============================================================================
The abs2rel script automatically attaches to your Maya session when you open a
new Maya scene file and deletes itself when you close Maya. By default, the
script will automatically backup original files with the suffix "_backup" and
will replace absolute paths to relative paths without you doing anything. If
you'd like to toggle one or both of these behaviors, just click the shelf
button for that feature.
