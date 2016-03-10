simplepreset - |project_long_name|
*****************************
Originally, the tool was imagined as a GUI that could load preset files which
would be JSON files and create them in a tree as relative paths. Added
functionality would make it possible to create presets within presets, but
unfortunately the tool didn't get far enough for that.

simplepreset is currently as simple as it can get. It's two tools packaged
together, one which will look at an existing directory and "copy" it to a JSON
dictionary file and the other reads dictionary files creates them as
file(s)/folder(s) under a root directory that the user specifies.

External Dependencies
==========
fileio.controller.paths

Directory to JSON
=================
.. automodule:: simplepreset.simplepreset_dir_to_json
 :members:
 :undoc-members:

JSON to Directory
=================
.. automodule:: simplepreset.simplepreset_json_to_dir
 :members:
 :undoc-members:

Implements
==============
.. automodule:: simplepreset.controller.engine_0004
 :members:

.. automodule:: simplepreset.controller.factory
 :members:

