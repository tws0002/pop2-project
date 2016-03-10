.. _hdrprocess-user-guide:

HDR Batch Processor User Guide
*******************************************************************************

If you're looking for HDR Batch Processor's full docuementation, you'll find it
over in the
:ref:`HDR Batch Processor Documentation Page <hdrprocessdocumentation>`.

HDR Batch Processor also has a synopsis page so you can
:ref:`see what it's all about here <hdrprocess>`

Requirements
===============================================================================

Python Libraries
-------------------------------------------------------------------------------
`PyQt4 <https://www.riverbankcomputing.com/software/pyqt/download>`_ or
`PySide <https://pypi.python.org/pypi/PySide/1.2.4>`_.

OS
-------------------------------------------------------------------------------
Windows or Linux with WINE equivalent

Supported Image Formats
-------------------------------------------------------------------------------
HDR Batch Process, which uses
`Picturenaut's <http://www.hdrlabs.com/picturenaut/faq.html>`_
open-source merge binary, mkhdr, handles the following image formats as of
writing February, 2016:

HDR Formats
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  * PFM (Portable Float Map)
  * HDR (Radiance)
  * EXR (OpenEXR)
  * TIFF (32-bit Floating Point)
  * TIFF (LogLuv)

LDR Formats
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  * JPEG
  * TIFF (only RGB color space)
  * TGA (Targa)
  * RAW (all flavors)

Installation and Dependencies
===============================================================================
  - The package must in the PYTHONPATH, as well as any of the listed required
    python packages

Usage
===============================================================================
The default setting of HDR Batch Process is to use all of the available power
of the current machine (go big or go home!). By default, the output names of
HDRis will be set to the first file in a bracket sequence, given the extension
.hdr. If you'd like to automate the process of renaming HDR files, you have the
option to supply text files as well as images to your projects.

A text file by the name of "outdoor_park_red_barn.txt" may look like so:

  IMG_5108.cr2, IMG_5109.cr2, IMG_5110.cr2, IMG_5111.cr2, IMG_5112.cr2

When the script is run, the text file will be read, each filename will be
considered as bracket images to a single HDR, and the filename of the .txt file
will then become the name of the HDR file.

If you're a Canon user like myself,
`Magic Lantern <http://www.magiclantern.fm>`_ has the ability to output these
text files automatically while you're shooting so at that point all you have to
do is rename the text files to the name you want and drop them in directly.

.. important::
  Using text files will ignore both automatic and manual sequence intervals for
  any image detected through reading the text file. After all, if you went to
  the trouble of including the sequences for HDRs in that explicit detail, it
  makes sense to give that priority when batch merging.
