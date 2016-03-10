PickRunner Documentation
*******************************************************************************
This is the full code documentation page for the PickRunner script. If you're
looking for its userguide, head to the PickRunner User Guide
:doc:`pickrunneruser`. For a more general description of PickRunner, head to the
PickRunner Project Abstract Page :doc:`pickrunner`.

Using in ScriptJobs/ScriptNodes
===============================================================================

Setting/Getting information about individual nodes in PickRunner is fairly
simple if you have the name of the object.

If you have two objects that are connected, say a controller for a rig's left
arm, "shoulder_l_CTL", and another for the rig's hand called "arm_l_CTL",
getting/using the hand control's name would be fairly straightforward

.. code-block:: python

  objectNode = "shoulder_l_CTL"
  >>> motor = engine.MotorMaya(objectNode)
  >>> leftObject = motor.members.left
  >>> leftObject.nodeName
  "arm_l_CTL"

Setting the direction of objects programmatically is a nearly identical process.

.. code-block:: python

  objectToConnectFrom = "shoulder_l_CTL"
  objectToConnectFrom = "neck_CTL"
  >>> motorFrom = engine.MotorMaya(objectToConnectFrom)
  >>> motorTo = engine.MotorMaya(objectToConnectTo)
  >>> motorFrom.members.right = motorTo

When connections are set, PickRunner handles setting up the metadata connections
between two objects on behalf of the user when both motors are instantiated


Getting Values Not In Direct Proximity
===============================================================================
If you weren't interested in the object directly related to the current object
but instead one or more objects several connections away, PickRunner can
skip nodes and return the one you want. In the next example, we'll keep with
"shoulder_l_CTL" but instead have it skip "arm_l_CTL" and move to the rig's hand
which will be called "hand_l_CTL" that is located some 5 objects away

.. code-block:: python

  objectNode = "shoulder_l_CTL"
  >>> motor = engine.MotorMaya(objectNode)
  >>> handObject = motor.walk("left", 5)
  >>> handObject.nodeName
  "hand_l_CTL"

Referencing Other Class-Types
===============================================================================
In the Motor classes, if you need an instance of the motor as a PickNode, simply
run get_pick_node().

.. code-block:: python

  motor.get_pick_node()

Within PickNodes, metadata is queriable by using

.. code-block:: python

  pickNode.metadataNode

The structure of the classes are such that one can easily move down to lower
levels but they cannot move up because doing so is dangerous in many scenarios.
I decided this from the script's outset because the most common scenario where
promotion could be a problem if the user renamed a node after creating metadata
for it. Currently, the safest way to promote a PickNodeGeneric or
MetadataObjectMaya higher up is to use get_name_from_uuid and recasting it as a
MotorMaya object.

Modules
===============================================================================

MotorMaya
-------------------------------------------------------------------------------
Located in pickrunner/controller/engine.py

.. automodule:: pickrunner.controller.engine
  :members: MotorMaya
  :show-inheritance:
  :undoc-members:

PickNodeGeneric
-------------------------------------------------------------------------------
Located in pickrunner/controller/engine.py

.. automodule:: pickrunner.controller.engine
  :members: PickNodeGeneric
  :show-inheritance:
  :undoc-members:

MasterMetadataObjectMaya
-------------------------------------------------------------------------------
Located in pickrunner/model/membership.py

.. automodule:: pickrunner.model.membership
  :members: MasterMetadataObjectMaya
  :show-inheritance:
  :undoc-members:

MetadataObjectMaya
-------------------------------------------------------------------------------
Located in pickrunner/model/membership.py

.. automodule:: pickrunner.model.membership
  :members: MetadataObjectMaya
  :show-inheritance:
  :undoc-members:
