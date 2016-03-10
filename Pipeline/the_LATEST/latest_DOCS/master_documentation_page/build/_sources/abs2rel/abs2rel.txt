Absolute To Relative Paths
************************************************************************
An issue on our latest version of RfM, Renderman For Maya, forces environment
hdr maps and .tex mipmap textures to absolute path upon save, even if the user
inputs a relative path in Maya. My solution is to create an standalone script
that reverts paths automatically.

If you're looking for the full documentation, you just missed it. The link is
over in the absolute to relative path documentation section :doc:`abs2reldocumentation`.
Otherwise that, if you're a user, head to :doc:`abs2reluser`.

.. toctree::
  :maxdepth: 1
  :hidden:

  abs2rel User Guide <abs2reluser>
  abs2rel Documentation <abs2reldocumentation>

Goals
===============================================================================
To make a path like C:\\example\\path\\s001A_v2\\maya_project\\scenes\\example_file.ma
into ..\\scenes\\example_file.ma, the following must be done:

  - Automate the process of changing absolute paths into relative paths
  - If the file acquired is a valid file for changing to relative paths, add it
    to a list of files to execute after the current file is finished and iterate
    through its contents recursively
  - Recursively search for files in folder(s)/subfolder(s)
  - Validate existing relative paths

Outline
===============================================================================
To change absolute paths to relative paths, the following must be determined

  1. get each line of the file
  2. determine if the file can be proven to be absolute or relative
  3. if it cannot be proven to be either, assume the path is relative and attempt to resolve an absolute path automatically
  4. if a file is found, in any case, return its line number and the match contents
  5. Now that the matches are all found, iterate through the read file and write over lines that found valid matches and save the file

Interfaces
===============================================================================

.. image:: src/abs2rel_path_interface.png
  :align: center

Final Usage
===============================================================================
The default settings outline how the tool will be used most of the time but
advanced options can also be specified. More often than not, the user will

  - input a file or folder path to make relative
  - add/remove fields as needed for file(s)/folder(s)
  - Press OK to run the script

And the script does the rest

Important Topics
===============================================================================
https://docs.python.org/2/library/os.path.html

References Consulted
===============================================================================
https://stackoverflow.com/questions/4579908

https://stackoverflow.com/questions/600268

https://stackoverflow.com/questions/31748617
