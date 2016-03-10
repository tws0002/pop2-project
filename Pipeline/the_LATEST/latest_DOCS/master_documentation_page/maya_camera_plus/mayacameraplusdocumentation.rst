.. _maya-camera-plus-documentation:

Maya Camera Plus Documentation
*******************************************************************************
This page is strictly for code reference, head to ther :ref:`Maya Camera Plus User Guide
<maya-camera-plus-user-guide>`, for a guide on how to use the camera plus
script or to the :doc:`mayacameraplus` Project Page for more info
on the script.

Requirements
===============================================================================
  * Maya 2014+

Installation
===============================================================================
Place camerasplus.py somewhere in the *MAYA_SCRIPT_PATH* environment variable
or in your environment's *PYTHONPATH* environment variable so that you can
source it while working.

In Maya's Script Editor, you can call the script by writing

.. code-block:: python

  import cameraplus
  camerasplus.UI()

And that will set camera plus up as a docked window in the current GUI

.. _maya_camera_frustum_docs:

The Camera Frustum
===============================================================================
The camera frustum makes up over 1000 lines of the script because it is made
using only Maya built-in nodes and its settings must be set to be efficient
when it draws in the Maya Viewport.

After all of the relevant info about each camera is acquired and connected
(film aspect ratio, horizontal/vertical film aperture, the resolution
width/height/ratio of the final output image, overscan, camera shake overscan),
the script needs to creat 4 main cases, depending on what variant the camera's
film fit is set to.

Film fit is "Fill"
-------------------------------------------------------------------------------
The camera's visual aperture (laymen term for what creates the visual aspect
ratio) must be obtained by horizontal aperture / resolution aspect ratio *
**25.4** (conversion for inches to mm) but only if the film aspect ratio is
less than resolution aspect ratio. film aspect > resolution aspect, vertical
aperture * resolution aspect ratio.

Film fit == horizontal aspect ratio
-------------------------------------------------------------------------------
If the condition is true, then we need to account for a horizontal offset for
when we apply this value as scale to the back-end of the frustum. As a result,
this value is multiplied by 0.5 * 2.54 (half because we draw the length of the
film-back as a scale attribute, 2.54 to put it in cm scene scale). If the
condition is not equal as we expected, we simply use a vertical offset, rather
than a horizontal one.

Film fit == vertical aspect ratio
-------------------------------------------------------------------------------
The vertical condition is the same as the horizontal condition, only reversed.
The horizontal offset is even compared to the same output condition.

Film fit == "Overscan"
-------------------------------------------------------------------------------
Overscan was by far the most difficult to set up. I found a reference on
drawing overscan in a Maya frustum `here <http://www.creativecrash.com/maya/script/kr_renderoverscan>`_ by `raffile.k <http://www.creativecrash.com/users/raffile-k>`_.

Frustum
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
From there, all of the cases are combined and the camera's view scale is
applied to account for camera pre-scale and then final view translate is
applied to account for translation offset in the viewport. This section is what
supports the zoom/offset feature in the camera script. Shake values are applied
shortly after and after a unit conversion to get horizontal and vertial field
of view and the values are transformed based on the camera's near/far clip
plane and that's the full frustum.

One of the nice consequences of the frustum being actual geometry in the
scene, is that it can be used as a kill object in simulation and help
prioritize where objects need to be placed.

Module
===============================================================================

Cameraplus
-------------------------------------------------------------------------------
Located in cameraplus/cameraplus.py


.. automodule:: cameraplus.cameraplus
  :members:
  :undoc-members:

