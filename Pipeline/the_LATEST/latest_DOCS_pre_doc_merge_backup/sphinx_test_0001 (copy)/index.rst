.. Portal: Origins [Part 2] documentation master file, created by
   sphinx-quickstart on Tue Jan 26 16:46:05 2016.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.


.. _`Portal Origins: [Part 2]`: https://www.kickstarter.com/projects/msmmotionpictures/portal-origins-part-2

.. _`short film`: https://www.youtube.com/watch?v=yNBYWQyOiYg

.. _`Project Welcome Page`: https://docs.google.com/document/d/19bjAD9Nq190hvqbCdXudxDCte7qnt1gpsmjxw5LhhZI/edit

.. _`Project Beginning Powerpoint`: https://drive.google.com/file/d/0B4ooNq2grXwNM0ppck12QTBXZzA/view?usp=sharing

.. _`Administrator1 Slack Handle`: @colinkennedy

.. Reference here https://stackoverflow.com/questions/19686897

|project_long_name| Documentation
====================================================
.. image:: img/banner.jpg
   :align:   center

`Portal Origins: [Part 2]`_ is a collaborated `short film`_ produced at SCAD
(Savannah College of Art and Design). The following page serves as a reference
for TDs on the project as well as a log of changes to the system.

**User Help:**

.. toctree::
 :maxdepth: 1

 Changelog <changelog>
 Userguide <userguide>
 Project File Naming Convention <nameconvention>
 Explanation of ITYP - Item types in file names <ityp>

**Administrative Documentation:**

.. toctree::
 :maxdepth: 1

 Constants <constants>
 Commons <changelog>
 Logger <logger>
 Network <network>
 News <news>
 Simplepreset <simplepreset>

.. toctree::
 :maxdepth: 2

 FileIO <fileio>
 .. Checkout <checkout> INCLUDE THIS IN FILEIO
 **Syncmeister <syncmeister>**

.. index::
 single: changelog
 single: constants

Getting Started
---------------
For the newest updates and specifics, :strong: bookmark this page for safe-keeping.
There's a variety of documents online that already do a good job of explaining
how to get up and running on the project but this is where the absolute newest
information will be changed. This webpage is documentation for me and
explanations about the project for you.

That said, if you have share permissions to the Project Google Drive, go
to `Project Welcome Page`_ and make sure to follow the instructions listed there.

Further Reading (Please)
------------------------
In the interest of avoiding confusion, please have a look at the
`Project Beginning Powerpoint`_. The information there is more dense but
the good news is that some of it is old or has been updated. Just read through
it with a grain of salt and come back here for clarification. For the most
updated information, head over to :doc:`userguide`. 

Exceptions
----------
.. automodule:: fileio.controller.globerror
 :members:
 :undoc-members:
.. :show-inheritance:
.. :inherited-members:

Indices
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
.. * :ref:`Models`
.. * :ref:`Exceptions`
.. * :ref:`Internal Modules`
