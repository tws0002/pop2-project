.. _sierpinski_documentation:

Sierpinski Gasket Full Documentation
*******************************************************************************
This page outlines the methods used for create the sierpinski fractals. If
you're looking for the project summary, check out :doc:`sierpinski`.

Sierpinski Main Module
===============================================================================

.. automodule:: sierpinski.sierpinski
  :members:

Sierpinski - PRMan Integration
===============================================================================

.. automodule:: sierpinski.ribsierpinski
  :members:

Sierpinski - PRMan Particles
===============================================================================
For the particle implementation of the script, which takes full advantage of
the RIS path tracer and RIB archives to avoid scene load and to simply let the
machine cache on render-time:

.. automodule:: sierpinski.ribparticle
  :members:

Wrapper
===============================================================================
To facilitate wrapping the generated objects to a deforming mesh, I created
another tool to very quick-and-dirty wrap and connect all of the objects
together under a single interface (the wrapperCtl)

.. automodule:: sierpinski.wrapper
 :members:
