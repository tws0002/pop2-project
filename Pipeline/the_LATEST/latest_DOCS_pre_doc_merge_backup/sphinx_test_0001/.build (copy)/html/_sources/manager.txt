Manager - |project_long_name|
=============================

Checks to allow access
----------------------
 If you're reading this, please check the list below to make sure your file
 is in agreeance with everything written below. Also note that the logger
 is very verbose about problems in filenames. If your file cannot be
 accessed but passes every check, please write a bug report. :ref:`bug_report_page`

 1. Is the file being accessed locally or over the network
   .. AUTHOR NOTE::
    Local saves are currently always allowed but they will be disallowed
    once a proper way to reference local files against their network
    counterparts is established.

 2. Is the user working remotely or from within the SCAD network
 3. Is the file locked by someone other than an administrator or by themselves
 4. Is the file within the proper scene/edit directory or is it being saved improperly
 5. Is the filename the latest version (latest letter and number) in the
    folder that the user is attempting to save into
 6. Is the scene/shot pair a match with the current file
    .. Note::
     Scene/Shot name is not a required argument on filenames currently. If
     none are specified, this check will simply pass through safely

 7. Check the suggested file's naming convention for missing arguments

 At this point, if the file has gotten through all of these checks, it is
 deemed "safe" and can now be accessed. The last step is to lock the file
 from edits import by other users.

 1. if the file is not locked, create a locked version of file
 2. save the file
 3. If the file that was just saved is not the current session, (aka, are they
    iterated and are not still working on the original file) unlock the file
