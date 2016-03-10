.. _hdrprocessdocumentation:

HDR Batch Processor Documentation
*******************************************************************************
This is the full back-end documentation for hdrprocess. Unless you're a
developer, chances are you're looking for the
:ref:`HDR Batch Process User Guide <hdrprocess-user-guide>` or a
:ref:`General Overview of HDR Batch Process <hdrprocess>`. Otherwise that,
here's the docs.

Requirements
===============================================================================

Python Libraries
-------------------------------------------------------------------------------
`PyQt4 <https://www.riverbankcomputing.com/software/pyqt/download>`_ or
`PySide <https://pypi.python.org/pypi/PySide/1.2.4>`_.

OS
-------------------------------------------------------------------------------
Windows or Linux with WINE equivalent

Installation
===============================================================================
Get the latest repo `here <https://github.com/ColinKennedy/hdrprocess>`_ if you
haven't already and place it anywhere within your PYTHONPATH.

Source the root hdrprocess folder as well as any of its dependencies and then
one could simply call the GUI using

.. code-block:: python

  hdrprocess.hdrprocess.show_gui()

Command-Line Mode
===============================================================================

.. note::
  The Command-line version of the utility is no longer functional, do to a major 
  refactoring of the code. GUI version only for now!

GUI Mode
===============================================================================

.. image:: src/hdrprocess_interface.png
  :align: center

When the GUI is loaded, the main screen is displayed. On the left are all of
the user settings for the merge project, the right is for output messages about
the current job once it is running, and the bottom section is for
adding/removing images, text files, and folders

Modules
===============================================================================

Engine
-------------------------------------------------------------------------------
Located at hdrprocess/controller/engine.py

Engine is the main interface to mkhdr. It handles all of the command-line/GUI
specific methods and args to wrap command-line calls around mkhdr, effectively
managing the process of automating the command-line tools.

.. automodule:: hdrprocess.controller.engine
  :members:
  :undoc-members:

Routine
-------------------------------------------------------------------------------
Located at hdrprocess/controller/engine.py

OS-dependent file(s)/folder(s) getting and sorting. I debated putting this
module in model but since most of its methods sort and filter, rather than
acquire and configure data made it feel more like a controller.

.. automodule:: hdrprocess.controller.routine
  :members:
  :undoc-members:

