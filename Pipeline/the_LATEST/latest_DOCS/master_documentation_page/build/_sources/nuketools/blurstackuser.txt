.. _blurstack-user:

blurStack User Guide
*******************************************************************************

.. image:: src/blurStack_comparison_web.jpg
  :align: center

Nuke's default blur node is very basic. This node makes it better by
stacking blur nodes together on top of each other, incrementally at different
blur levels. With a few added user controls to adjust attributes like
fringe color, gamma, contrast, and levels, blurStack adds more to what you can
do when you blur objects.

blurStack's main strength is blurring elements that are pre-multiplied or a
sub-section of the entire composite image.

Installation
===============================================================================
Place the *blurStack.gizmo* file in a folder that's under your NUKE_PATH
environment variable

Documentation
===============================================================================
For documentation on the gizmo, head to :doc:`blurstack`.

Usage
===============================================================================
blurStack, when quality is set to one, is essentially just a blur node but once
you put quality equal to or above 4, blurStack gives you very fine edge
control.

Usage Note
-------------------------------------------------------------------------------
Every attribute in blurStack is interactive except for the quality value. Any
time the quality needs to be changed, press "Update" and blurStack will
recalculate the node with your current settings.

How to Contribute
===============================================================================

Ask Questions
-------------------------------------------------------------------------------
The best way to get an answer to a question is to ask me directly. My email is
colinvfx@gmail.com

Report Issues
-------------------------------------------------------------------------------
Please report bugs and suggest features via the `GitHub Issues
<https://github.com/ColinKennedy/blurStack/issues>`_

Before opening an issue, search the tracker for possible duplicates. If you
find a duplicate, please add a comment saying that you encountered the problem as well.

Contribute code
-------------------------------------------------------------------------------
* Check the `GitHub Issues <https://github.com/ColinKennedy/blurStack/issues>`_
  for open issues that need attention.
* Follow the Contributing to `Open Source <https://guides.github.com/activities/contributing-to-open-source>`_ Guide.
