.. _fileio:

fileio - |project_long_name|
*******************************************************************************
All of the methods for determining read/write permission, constructing and
modifying paths, directory listings, and any general file-level operations
are contained within this package. A great deal of the entire environment is
contained within these modules and are referenced in nearly every tool used.
Be VERY cautious before editing.

paths
===============================================================================
.. automodule:: fileio.controller.paths
 :members:

.. _checkout:

checkout
===============================================================================
.. automodule:: fileio.controller.checkout
 :members:

manager
===============================================================================
.. automodule:: fileio.controller.manager
 :members:

.. _fileio#checks_to_allow_access:

Checks to allow access
-------------------------------------------------------------------------------
 If you're reading this because you're trying to run/save/load a file
 and it isn't working, please check the list below to make sure your file
 is in agreeance with everything written below. Also note that the logger
 is very verbose about problems in filenames. If your file cannot be
 accessed but passes every check, please write a bug report at the `Bug Report Page <https://docs.google.com/spreadsheets/d/1PC98Qsx79s4hxRaap3m9U0cKT1TLpHDCvMtDsZAQ6ZA/edit>`_

 1. Is the file being accessed locally or over the network
   .. AUTHORNOTE::
    Local saves are currently always allowed but they will be disallowed
    once a proper way to reference local files against their network
    counterparts is established.

 2. Is the user working remotely or from within the SCAD network
 3. Is the file locked by someone other than an administrator or by themselves
 4. Is the file within the proper scene/edit directory or is it being saved
    improperly
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

.. automodule:: fileio.controller.manager
 :members:

omnibus
===================
.. automodule:: fileio.controller.omnibus
 :members:

.. _exceptions:

globerror
===================
.. automodule:: fileio.controller.globerror
 :members:

filesequencer
===================
.. automodule:: fileio.controller.filesequencer
 :members:
