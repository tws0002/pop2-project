Syncmeister - |project_long_name| 
*********************************
.. Danger::
 Update: Syncmeister now kicks even more ass!

.. Warning::
 Syncmeister is still working with maya.py, which should be deprecated in
 favor of the project's new file locking mechanisms (located in 
 fileio.controller.manager[_newestNumber]). 

.. TODO::
 Remove this once Syncmeister has been rewritten

Syncmeister assists in syncing files from network to local locations and is 
used in several other projects throughout the environment. In general, it's
methods are used for interpretting and fixing file paths

Main Interface
==============

GUI Mode
++++++++
The GUI will look something like this (May be updated in the future)

.. image:: http://placehold.it/550x850

The main thing that you need to know about the GUI is that the default fields,
checkboxes, and settings will be set according to how 90% of people will use 
the tool. In most usage case scenarios, just put the path to your 
Maya/Nuke/Houdini file in along with your preferred root path and syncmeister can run.

Command-Line Mode
+++++++++++++++++
An example execution of syncmeister would be:

.. code-block:: html
 :linenos:

 $ syncmeister -i /path/to/project/scenes/s001_ckenne24_010_MODEL.0001.ma -rp
 /path/to/project -di -do -sr -e -ec

Which will take a scene file from Maya and
 1. Look up its dependencies recursively (-di + -do)
 2. Set all paths relative to the new copy location (-sr)
 3. Evaluates/checks for absolute and relative paths (-e)
 4. If the dependencies Maya required are empty, they will still be copied (-ec)

The full documentation for the GUI and command-line utility is below:

.. automodule:: syncmeister.syncmeister_0003
 :members: main
 :platform: Unix, Windows
 :synopsis: The main executable that runs either the GUI or command-line

Models
======

Internal Modules
================

