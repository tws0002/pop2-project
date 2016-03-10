Changelog - |project_long_name|
*********************************

Date: 2016-01-29 14:21:00
=========================

All
+++++++
- Ported my documentation online using Sphinx
- Adapted documentation to RTD
- Added Google-Style documentation support with Napoleon
- Created project-wide dialog box
- Began twisted/potroast implementation over network
- Created project folder structure
- Applications not in consts.SUPPORTED_APPLICATIONS are now rejected, on startup 
- Added USER_OVERRIDE to environment to allow for logging in as another user
- Added ADMIN_MODE to allow users to gain admin permissions to the project

Nuke
+++++++
- Fixed X_Tesla

Misc
++++
- The google docs sheet now automatically updates columns depending on if the
  asset being queried is project-wide or shot-specific

Date: 2016-01-22 14:21:00
=========================

All
+++
- Unified Open/Load/Save into a single, agnostic function and applied it
  site-wide
- Added SOLIDARITY as an officially supported environment variable
- Created a system that allows for the latest file to be queried, based upon
  version and increment version/type in the current naming convention

Nuke
++++
- Automatically get project information using python, called via TCL in StickyNote 
- Created watermark node for projects for communicating between compositors
- Added TTT

Maya
++++
- Maya UI is now green


Date: 2016-01-15 14:21:00
=========================

All
+++
- Scene number is no longer a required arg in save files
- Users can now opt-out/opt-in to plugins from their personal preferences
- Locking files now records room number and time/date
- Information in locked files now include ip address and machine number
- LOG_LEVEL as been added as environment variable - controls how verbose my
  tool are on execution

Maya
++++
- mayamanager.checkout_write_render_before(filePath) is now leveraged through a
  metadata node that is instantiated on startup. Older files are adopted into
  the environment automatically
- Added custom error display messages on error

Nuke
++++
- Write/WriteGeo node will create folders if that do not already exist on render

Date: 2016-01-08 14:21:00
=========================

All
+++
- File Naming convention now supports number padding (####), TCL expressions
  (%04d), and Houdini-Style frame padding ($F4)
- Segmentation faults and general crashes no longer break the file lock/unlock system
- First iteration of file lock/unlock fileIO system created. The system
  currently is written per-application and will be changed to be more agnostic
  in the future
- Scene names now allow for letter suffixes
