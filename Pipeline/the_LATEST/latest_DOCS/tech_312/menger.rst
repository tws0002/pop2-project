.. VSFX 312 - Advanced Application Scripting documentation master file, created by
   sphinx-quickstart on Thu Feb  4 17:41:34 2016.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

VSFX 312 - Menger Fractal
*******************************************************************************

.. toctree::
  :maxdepth: 1

  Menger Documentation <tech_312/mengerdocumentation>

.. _`menger zip file`: _images/menger_zip_archive.zip

.. image:: img/menger_city_full.jpeg
 :align: center

Project Definition
===============================================================================

The menger fractal is constructed by subdividing a single cube X number of
times, while randomly deleting specific inner parts of the cube. Menger
fractals exist in 2D and 3D variants as long as the math is adjusted
accordingly.

For full project documentation, see this link :doc:`mengerdocumentation`

Goals
==============================================================================
Create a random menger city automatically, with quick iterations between
versions.

.. image:: img/menger_stepped_highQ.jpg
 :align: center

Here I was experimenting with isolating patches of the menger fractal. Given
certain section numbers, the menger fractal can be controlled before subdivision
occurs

.. image:: img/menger_eagle_highQ.jpg
 :align: center

Testing out a sine wave through the menger fractal

.. image:: img/menger_2SPOT5D_highQ.jpg
 :align: center

When a the 4th vertex is pulled down, it makes a 2d menger fractal stretch with
a jagged look which is not unlike it's full 3D counterpart (see below)

Automatic City Generation
==============================================================================

.. raw:: html

        <object width="480" height="385"><param name="movie"
        value="_images/menger_city_generation.mp4"></param><param
        name="allowFullScreen" value="true"></param><param
        name="allowscriptaccess" value="always"></param><embed
        src="_images/menger_city_generation.mp4"
        allowscriptaccess="always"
        allowfullscreen="true" width="700"
        height="385"></embed></object>
        </br></br>

Creating a field of menger cubes works like so:
  * create a field of cubes in the X and Z direction

    * Keep cubes from intersecting by getting the object-space bounding box
    * Expand the cubes upwards in the Y direction for height
    * initialize menger-related attributes for cube
    * randomize the values of the attributes

  * get the current scene name, move up to the project directory
  * navigate to the data folder and place files there
    * the file name is automatically generated using the scene and object name

  * simulate the rib files for every cube (for one or multiple frames)
  * render the menger

Which, altogether, lets the user create some really fast, rapid prototyping
of different scenes. It also has the added bonus of scaling with the size

of a given scene input and could be extended to follow the normal of a ground
plane with very little additional effort.

.. raw:: html

  <pre style='color:#000000;background:#ffffff;'><span style='color:#800000; font-weight:bold; '>def</span> create_menger<span style='color:#808030; '>(</span><span style='color:#400000; '>object</span><span style='color:#808030; '>)</span><span style='color:#808030; '>:</span>
      <span style='color:#696969; '>"""</span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;Creates the menger</span>
  <span style='color:#696969; '></span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;.. important::</span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;This script communicates which rib file to render as the current shape </br> by using the variable outputPath</span>
  <span style='color:#696969; '></span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;.. note::</span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;Currently, file frame padding has been hard-coded to 4. May need to add a variable for</span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;this in the future, if necessary</span>
  <span style='color:#696969; '></span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;.. note::</span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;This function does not expect arguments but the following attributes must be</span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;passed through the maya object's shape node..</span>
  <span style='color:#696969; '></span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;Args:</span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;object (&lt;pm.nodetypes.Mesh>): The object to create a menger from</span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;rootDir (str): The output path of the menger</span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;depth (int): The number of recursions created before the menger is drawn</span>
  <span style='color:#696969; '></span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;.. note::</span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;freq will not have any effect if amp is 0</span>
  <span style='color:#696969; '></span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;animation (bool): Enables/Disables writing/reading .rib files with</span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;frame numbers, which allows for deforming animation</span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;allowRibWrite (bool): Lets the user save by frame number</span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;holes (list): A list of integers to of which indices (1-27) to remove</span>
  <span style='color:#696969; '></span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;Returns:</span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;str: The resulting (read) file path of the .rib file</span>
  <span style='color:#696969; '>&#xa0;&#xa0;&#xa0;&#xa0;"""</span>
      shapeNode <span style='color:#808030; '>=</span> pm<span style='color:#808030; '>.</span>PyNode<span style='color:#808030; '>(</span><span style='color:#400000; '>object</span><span style='color:#808030; '>)</span>  <span style='color:#696969; '># cast to PyMEL object</span>
      <span style='color:#696969; '># check to make sure the user wants to write the rib</span>
  
      <span style='color:#696969; '># attrs = get_attributes(object)</span>
      depth <span style='color:#808030; '>=</span> pm<span style='color:#808030; '>.</span><span style='color:#400000; '>getAttr</span><span style='color:#808030; '>(</span><span style='color:#400000; '>object</span> <span style='color:#44aadd; '>+</span> <span style='color:#0000e6; '>'.depth'</span><span style='color:#808030; '>)</span>
      holes <span style='color:#808030; '>=</span> pm<span style='color:#808030; '>.</span><span style='color:#400000; '>getAttr</span><span style='color:#808030; '>(</span><span style='color:#400000; '>object</span> <span style='color:#44aadd; '>+</span> <span style='color:#0000e6; '>'.holes'</span><span style='color:#808030; '>)</span>
      renderStyle <span style='color:#808030; '>=</span> pm<span style='color:#808030; '>.</span><span style='color:#400000; '>getAttr</span><span style='color:#808030; '>(</span><span style='color:#400000; '>object</span> <span style='color:#44aadd; '>+</span> <span style='color:#0000e6; '>'.renderStyle'</span><span style='color:#808030; '>)</span>
      <span style='color:#800000; font-weight:bold; '>if</span> renderStyle <span style='color:#44aadd; '>==</span> <span style='color:#008c00; '>0</span><span style='color:#808030; '>:</span>
          renderStyle<span style='color:#808030; '>=</span><span style='color:#0000e6; '>"menger"</span>
      <span style='color:#800000; font-weight:bold; '>elif</span> renderStyle <span style='color:#44aadd; '>==</span> <span style='color:#008c00; '>1</span><span style='color:#808030; '>:</span>
          renderStyle <span style='color:#808030; '>=</span> <span style='color:#0000e6; '>"retained"</span>
      <span style='color:#800000; font-weight:bold; '>elif</span> renderStyle <span style='color:#44aadd; '>==</span> <span style='color:#008c00; '>2</span><span style='color:#808030; '>:</span>
          renderStyle <span style='color:#808030; '>=</span> <span style='color:#0000e6; '>"both"</span>
  
      enableWrite <span style='color:#808030; '>=</span> pm<span style='color:#808030; '>.</span><span style='color:#400000; '>getAttr</span><span style='color:#808030; '>(</span><span style='color:#400000; '>object</span> <span style='color:#44aadd; '>+</span> <span style='color:#0000e6; '>'.allowRibWrite'</span><span style='color:#808030; '>)</span>
      animation <span style='color:#808030; '>=</span> pm<span style='color:#808030; '>.</span><span style='color:#400000; '>getAttr</span><span style='color:#808030; '>(</span><span style='color:#400000; '>object</span> <span style='color:#44aadd; '>+</span> <span style='color:#0000e6; '>'.animation'</span><span style='color:#808030; '>)</span>
  
      <span style='color:#800000; font-weight:bold; '>global</span> OUTPUT_PATH
      fullPath <span style='color:#808030; '>=</span> cmds<span style='color:#808030; '>.</span><span style='color:#400000; '>file</span><span style='color:#808030; '>(</span>q<span style='color:#808030; '>=</span><span style='color:#074726; '>True</span><span style='color:#808030; '>,</span> sceneName<span style='color:#808030; '>=</span><span style='color:#074726; '>True</span><span style='color:#808030; '>)</span>
      OUTPUT_PATH <span style='color:#808030; '>=</span> fullPath
      <span style='color:#800000; font-weight:bold; '>if</span> animation<span style='color:#808030; '>:</span>
          OUTPUT_PATH <span style='color:#808030; '>=</span> get_output_path<span style='color:#808030; '>(</span>OUTPUT_PATH<span style='color:#808030; '>)</span>
  
      writePath <span style='color:#808030; '>=</span> os<span style='color:#808030; '>.</span>path<span style='color:#808030; '>.</span>join<span style='color:#808030; '>(</span><span style='color:#44aadd; '>*</span>os_path_split_asunder<span style='color:#808030; '>(</span>OUTPUT_PATH<span style='color:#808030; '>)</span><span style='color:#808030; '>[</span><span style='color:#808030; '>:</span><span style='color:#44aadd; '>-</span><span style='color:#008c00; '>2</span><span style='color:#808030; '>]</span><span style='color:#808030; '>)</span>
      fileName <span style='color:#808030; '>=</span> os_path_split_asunder<span style='color:#808030; '>(</span>OUTPUT_PATH<span style='color:#808030; '>)</span><span style='color:#808030; '>[</span><span style='color:#44aadd; '>-</span><span style='color:#008c00; '>1</span><span style='color:#808030; '>]</span>
      writePath <span style='color:#808030; '>=</span> os<span style='color:#808030; '>.</span>path<span style='color:#808030; '>.</span>join<span style='color:#808030; '>(</span>writePath<span style='color:#808030; '>,</span> <span style='color:#0000e6; '>"data"</span><span style='color:#808030; '>,</span> fileName<span style='color:#808030; '>)</span>
      pathShapeName <span style='color:#808030; '>=</span> shapeNode<span style='color:#808030; '>.</span>dagPath<span style='color:#808030; '>(</span><span style='color:#808030; '>)</span><span style='color:#808030; '>.</span>replace<span style='color:#808030; '>(</span><span style='color:#0000e6; '>"|"</span><span style='color:#808030; '>,</span> <span style='color:#0000e6; '>"_"</span><span style='color:#808030; '>)</span>
      writePath <span style='color:#808030; '>=</span> os<span style='color:#808030; '>.</span>path<span style='color:#808030; '>.</span>splitext<span style='color:#808030; '>(</span>writePath<span style='color:#808030; '>)</span><span style='color:#808030; '>[</span><span style='color:#008c00; '>0</span><span style='color:#808030; '>]</span> <span style='color:#44aadd; '>+</span> <span style='color:#0000e6; '>"_{}.rib"</span><span style='color:#808030; '>.</span>format<span style='color:#808030; '>(</span>pathShapeName<span style='color:#808030; '>)</span>
      OUTPUT_PATH <span style='color:#808030; '>=</span> writePath
      
      <span style='color:#800000; font-weight:bold; '>if</span> <span style='color:#800000; font-weight:bold; '>not</span> enableWrite<span style='color:#808030; '>:</span>
          <span style='color:#800000; font-weight:bold; '>return</span>  OUTPUT_PATH    
      
      <span style='color:#800000; font-weight:bold; '>if</span> <span style='color:#400000; '>isinstance</span><span style='color:#808030; '>(</span>shapeNode<span style='color:#808030; '>,</span> pm<span style='color:#808030; '>.</span>nodetypes<span style='color:#808030; '>.</span>Transform<span style='color:#808030; '>)</span><span style='color:#808030; '>:</span>
          transformNode <span style='color:#808030; '>=</span> shapeNode
          shapeNode <span style='color:#808030; '>=</span> shapeNode<span style='color:#808030; '>.</span>getShape<span style='color:#808030; '>(</span><span style='color:#808030; '>)</span>
      <span style='color:#800000; font-weight:bold; '>else</span><span style='color:#808030; '>:</span>
          transformNode <span style='color:#808030; '>=</span> shapeNode<span style='color:#808030; '>.</span>getParent<span style='color:#808030; '>(</span><span style='color:#808030; '>)</span>
  
      boundingBox <span style='color:#808030; '>=</span> transformNode<span style='color:#808030; '>.</span>getBoundingBoxInvisible<span style='color:#808030; '>(</span><span style='color:#808030; '>)</span>
      boundingBox <span style='color:#808030; '>=</span> get_bounding_box_local<span style='color:#808030; '>(</span><span style='color:#808030; '>)</span>
      <span style='color:#696969; '># bbMinX, bbMinY, bbMinZ, bbMaxX, bbMaxY, bbMaxZ = boundingBox</span>
  
      holes <span style='color:#808030; '>=</span> <span style='color:#808030; '>[</span><span style='color:#400000; '>int</span><span style='color:#808030; '>(</span>x<span style='color:#808030; '>.</span>strip<span style='color:#808030; '>(</span><span style='color:#808030; '>)</span><span style='color:#808030; '>)</span> <span style='color:#800000; font-weight:bold; '>for</span> x <span style='color:#800000; font-weight:bold; '>in</span> holes<span style='color:#808030; '>.</span>split<span style='color:#808030; '>(</span><span style='color:#0000e6; '>','</span><span style='color:#808030; '>)</span><span style='color:#808030; '>]</span>
  
      menger <span style='color:#808030; '>=</span> Menger3D<span style='color:#808030; '>(</span>boundingBox<span style='color:#808030; '>,</span> depth<span style='color:#808030; '>,</span> holes<span style='color:#808030; '>)</span>
      menger<span style='color:#808030; '>.</span>writeAsCubes<span style='color:#808030; '>(</span>OUTPUT_PATH<span style='color:#808030; '>,</span> cube_type<span style='color:#808030; '>=</span>renderStyle<span style='color:#808030; '>)</span>
      <span style='color:#800000; font-weight:bold; '>return</span> OUTPUT_PATH
  <span style='color:#696969; '># end create_menger</span>
  </pre>

Code Links
==============================================================================
All of the used files can be downloaded on my `GitHub repo <https://github.com/ColinKennedy/tech_312_menger_city>`_.

Conclusion
==============================================================================
I wish that I had more time to properly write this code to be just a single
rib file with various rib archive reads. I had a hard time battling Maya's GUI,
which only supported roughly a few thousand cubes before my script started
experience serious slowdowns. Now that I have exposure to Maya's OpenMaya
Python API 2.0, it'd be nice to also go back and make the more expensive calls
to various functions more efficient

Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

