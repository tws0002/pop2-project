Maya Camera Plus
*******************************************************************************
Maya Camera Plus is a utility for Autodesk Maya for organizing and moving
between series of cameras in a Maya scene.

.. toctree::
  :maxdepth: 1
  :hidden:

  Maya Camera Plus User Guide <mayacameraplususer>
  Maya Camera Plus Documentation <mayacameraplusdocumentation>

Links
===============================================================================
The `Camera Plus Script <https://github.com/ColinKennedy/maya-camera-plus>`_ is
available `here <https://github.com/ColinKennedy/maya-camera-plus>`_ for download over at my GitHub page but if you're just looking for
:ref:`Camera Plus's User Guide <maya-camera-plus-user-guide>`, see that link.
Camera Plus also has some basic :ref:`docs
<maya-camera-plus-documentation>`, as well.

Goals
===============================================================================
  - Toggle between cameras and set their settings without needing to physically
    select the cameras in Maya's viewport
  - Create an interactive GUI that responds to each camera and updates to the
    active camera in-scene
  - Export notes with renders, like with Pixar's Renderman "it" image tool
  - Automatically populate notes with scene data
  - Visualize each Maya's camera with an exact frustum, to replace Maya's
    built-in frustum
  - Create a visualization of front, back, and in-focus depth-of-field in Maya

The Frustum
===============================================================================
One of the nice consequences of the frustum being actual geometry in the
scene, is that it can be used as a kill object in simulation and help
prioritize where objects need to be placed. For more information on how the
camera frustum works, check out the frustum's explanation in the :ref:`Maya
Camera Plus Frustum Docs <maya_camera_frustum_docs>`

Important Topics
===============================================================================
https://en.wikipedia.org/wiki/3D_projection

References Consulted
===============================================================================
  `3D to 2D Camera Projection - Georgia Tech <http://users.ece.gatech.edu/lanterma/mpg10/mpglecture04f10_3dto2dproj.pdf>`_

  `Overscan Calculation Reference <http://www.creativecrash.com/maya/script/kr_renderoverscan>`_

  `Scratch A Pixel's Main Webpage <scratchapixel.com>`_
    * `Scratch A Pixel Focal Lengths Lesson <http://www.scratchapixel.com/lessons/3d-advanced-lessons/cameras-advanced-techniques/film-aperture-focal-length/>`_
    * `Scratch A Pixel - Bounding Projection Overview <http://www.scratchapixel.com/lessons/3d-advanced-lessons/cameras-advanced-techniques/projecting-a-bounding-box-onto-the-screen>`_
    * `Scratch A Pixel - Perspective Project Matrix <http://www.scratchapixel.com/lessons/3d-advanced-lessons/perspective-and-orthographic-projection-matrix/perspective-projection-matrix>`_
