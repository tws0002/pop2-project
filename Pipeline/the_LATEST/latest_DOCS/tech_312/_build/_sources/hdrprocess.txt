.. _hdrprocess:

HDR Batch Processor
************************************************************************
A Python script to batch-merge a variety of images into beautiful HDR images.


.. toctree::
  :maxdepth: 1
  :hidden:

  HDR Batch Process User Guide <hdrprocessuser>
  HDR Batch Process Documentation <hdrprocessdocumentation>

Links
===============================================================================
Get the script `here <http://github.com/ColinKennedy/hdrprocess>`_.
To look at HDR Batch Processor's documentation, head over to the

:ref:`HDR Batch Processor documentation <hdrprocessdocumentation>`.

If you're a user looking to use the script itself, go here:

:ref:`HDR Batch Processor User Guide <hdrprocess-user-guide>`

Synopsis
===============================================================================
I'm an avid fan of HDRs and panoramas in general and I recently purchased the
skywalker Merlin/Orion and modded it using papywizard to make it into an
automatic panorama head. It supports bracketing from my Canon Rebel T3i as well
as My nightly build of Magic Lantern. The only problem is, a single 1.3
Gigapixel pan is 940 images x the number of brackets I need to take. So if I did
5 x 2 EV brackets per HDR, that's just shy of 5000 images to process. Yikes.

My solution is between 8x-13x faster than leading industry standards, like
Photomatix, Fusion, Adobe Lightroom CC, and HDR Studio. The speed varies
depending on the number of HDR images there are to create. The more images to
process, the better the speed

Goals
===============================================================================
  - Create a HDR batch stitcher that is very fast
  - Extend the script's features leveraging existing software in order to avoid
    high maintainence proprietary issues in the script.

Outline
===============================================================================
For this stitcher to work, I will use mkhdri.exe as my base. mkhdri.exe is a
binary executable that ships as a part of Picturenaut, a free HDR program. In
order to sort the hdr images according, I have my T3i + Magic Lantern output a
sidecar file for every bracketed image sequence. The text file it creates keeps
a list of the groupings of HDR images. From there, my process for handling the
images are as follows

  1. Get images from my SD card
  2. Using the sidecar .txt files from Magic Lantern, I get the HDR groups
  3. For each sequence of HDR groups, pass the user args to mkhdri.exe
  4. Assign a sequence of HDR groups to batch per-allowed user thread
  5. Confirm at the merge was successfu

Interfaces
===============================================================================

.. image:: src/hdrprocess_interface.png
  :align: center

Final Usage
===============================================================================
If a user has a customized .crv camera curve (I mean, who doesn't, right?),
the first thing they'll do is input it under the "Curve Settings". They'll set
the stops from their camera (F-Num) and the number of brackets for each HDR
goes into the sequence interval. For those working with text files that contain
their brackets such as Magic Lantern users, the sequence is only used as a
fall-back if the script encounters image sequences with no accompanying text.

Image-alignment is recommended to turn on if the camera was unstable during the
length that the photograph was taken, ghost removal should be enabled if there
where moving objects in the exposures, exposure correction and color balancing
are good to enable if lighting conditions changed during the shoot.

From there, the user can input files/folders and sidecar text files in the
bottom field.

The script also has a command-line version, to automate the process further

Final Note
===============================================================================
While my script works very fast, it's speed comes in part at the expense of some 
of the the bells and whistles that other HDRi software uses. I retained some
features but this setup won't tolerate shooting styles where the photographer
is holding the camera, instead of on a monopod or tripod.

Ultimately, I'd like to automate the process of stithing panoramas completely,
from start to finish. I can do that fairly easily, because papywizard outputs
XMP data which represents the rotation of the camera at the time of the
photograph, making stitching via positioning possible. More on that later.

Important Topics
===============================================================================
https://docs.python.org/2/library/os.path.html

http://www.hdrlabs.com/picturenaut/

References Consulted
===============================================================================
https://stackoverflow.com/questions/4579908

https://stackoverflow.com/questions/600268

https://stackoverflow.com/questions/31748617

https://stackoverflow.com/questions/2422050/raw-image-processing-in-python

https://stackoverflow.com/questions/3397157/how-to-read-a-raw-image-using-pil
