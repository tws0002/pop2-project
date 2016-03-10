PickRunner
************************************************************************

.. toctree::
  :maxdepth: 1
  :hidden:

  PickRunner User Guide <pickrunneruser>
  PickRunner Documentation <pickrunnerdocumentation>

.. raw:: html

  <iframe width="700" height="393" src="https://www.youtube.com/embed/K3vCaNfyafY" frameborder="0" allowfullscreen></iframe>
  </br>
  </br>

This is the **PickRunner Project Abstract** page. If you're looking for
PickRunner's documentation, you can find the PickRunner Documentation here:
:doc:`pickrunnerdocumentation`. If you're a user looking to get started, follow
the PickRunner User Guide :doc:`pickrunneruser`

Project Problem Definition
===============================================================================
One of the greatest frustrations of Maya is that, although it has very powerful
context tools for using the mouse, the keyboard is discouraged for navigation.
Other animation software packages give the user tools to arbitrarily link
objects to make navigating scenes easier. Maya does have a system called
PickWalking, but that only applies to objects that are directly parented
together and, more often than not, directly parenting nodes into a hierarchy is
impossible.

With PickRunner, Maya has a brand new way to navigate scenes using 100% Python
and Maya metadata. This script works not only objects that draw in Maya's
viewport but all non-DAG nodes, as well.

Goals
===============================================================================
  To replicate an arbitrary system for relating objects together, the following
  needs for the tool must be met:

General
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  - All objects to be considered by the scene must be reprensented, either in
    data or in nodes
  - The user should be able to use PickRunner both with the GUI and without
  - hotkeys should be unintrusive and not disable any of Maya's default behaviors 
  - Replace Maya's default key-setup so that holding down keys will repeat
    commands at approx. 2-3 times a second (note: Not completed yet)
  - The system must be has fast and as responsive as PickWalking
  - Connections should be two-way by default but should also have the ability
    to do one-way connections

GUI
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  - There should be two main modes - one for assigning/deleting the relationship
    between objects and another for reviewing the entire scene
  - The scene view should be styled like Maya's outliner
  - Because I'm going to the trouble of creating a new system, add some extra
    features such as being able to skip every nth element instead of moving one
    object at a time
  - Toggle the ability to do two-way or one-way connections

Code Outline
===============================================================================
  Classes are designed at different level of exposures to PickRunner. The
  highest level of interaction is the engine.Motor/engine.MotorMaya classes,
  which interface directly with Maya nodes passed from PyMEL.

  Below MotorMaya is PickNodeGeneric, which instantiates and wraps around
  class information. This class has the awareness of a metadata node and other
  metadata nodes that are directly around it in its proximity
  (up/left/down/right). It also doubles as the way to interface with metadata,
  as most of its methods either deal with safely setting information and
  managing the locks/connections between that metadata node and the master node,
  which links together every node regardless of how a scene is laid out

  The final main class is the MetadataObjectMaya class, which is simply the
  metadata's configuration settings, preferences, and initialization info.
  Metadata nodes have no understanding of other nodes around them or connected
  from them. If that information is needed, the metadata class should be
  promoted to PickNodeGeneric.

  There is one variant of metadata classes called the MasterMetadataObjectMaya,
  which contains no special information about itself but it built and connects
  with every MetadataObjectMaya node that gets created in the scene. The node
  that MasterMetadataObjectMaya creates is used to query and update PickRunner's
  interface in GUI mode

Interfaces
===============================================================================

.. image:: src/pickrunner_interface_0001.png
  :align: left

.. image:: src/pickrunner_interface_0002.png
  :align: left

Final Usage
===============================================================================
For information on how to use the script, head over to the PickRunner User
Guide, :doc:`pickrunneruser`

Important Topics
===============================================================================
UUIDs - The lifeblood of the entire script:
https://docs.python.org/2/library/uuid.html
https://knowledge.autodesk.com/search-result/caas/CloudHelp/cloudhelp/2016/ENU/Maya-SDK/cpp-ref/class-m-uuid-html.html
