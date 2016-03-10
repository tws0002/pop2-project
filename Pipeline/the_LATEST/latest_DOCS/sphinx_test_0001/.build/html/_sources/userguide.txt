The Definitive User Guide
************************************************
This document was made to help the users of the project. It'll have the most
updated information so please check back once in a while if you're stuck. And
also, I just want to thank you again for being a part of the project and also
for using my tools. I hope they come in handy!

If you're just here for the item list as reference, here's a like to the
:ref:`item-list`

.. toctree::
 :maxdepth: 2
 :hidden:

 Finalized Work Folder Information <finalfolder>

Getting Started
=================================================
For the newest updates and specifics, :strong: bookmark this page for safe-keeping.
There's a variety of documents online that already do a good job of explaining
how to get up and running on the project but this is where the absolute newest
information will be changed. This webpage is documentation for me and
explanations about the project for you.

That said, if you have share permissions to the Project Google Drive, go
to `Project Welcome Page <https://docs.google.com/document/d/19bjAD9Nq190hvqbCdXudxDCte7qnt1gpsmjxw5LhhZI/edit>`_ and make sure to follow the instructions listed there.

Further Reading (Please)
------------------------
In the interest of avoiding confusion, please have a look at the
`Project Powerpoint <https://drive.google.com/file/d/0B4ooNq2grXwNM0ppck12QTBXZzA/view?usp=sharing>`_. 
The information there is more dense but
the good news is that some of it is old or has been updated. Just read through
it with a grain of salt and come back here for clarification. For the most
updated information, head over to :doc:`userguide`. 

Past information
================
I can't start this post without mentioning that this builds off of previous
information stated in our group documents and powerpoints. Give those a
look-through before you read any more of this. (Don't worry, the reading is
light)

So from here on out, consider everything to be the most recent, most up-to-date
info. If you have additional questions, hit me up on our Slack page, my handle
is |Administrator1 Slack Handle|.

File Name Convention Explanation
================================
This come up a couple times in the forums so I want to just copy/paste my
responses here for safe keeping

Take the given filename, s001_ckenne24_001_MODEL_just_started.0001.ma. While I
work on the file, I might update the description and increment to
s001_ckenne24_001_MODEL_addingNutsAndBolts.0002.ma.

Once I move to the texturing aspect, I call it
s001_ckenne24_002_MODEL_texturingFront.0001.ma

So notice the version number goes up, the item-type, MODEL, stays the same
(because we're still working on the one asset, just a different part), and the
increment resets or 0 or 1.

The idea is that every time an aspect of your asset, in this case some model,
has to change, you increment the version. Changing the increment happens on a
case-by-case basis. I like to increment every 15 minutes if the filesize is
small.

Anyway, that's the intended use for the filename convention for scene files.
You don't have to work that way but I think being really verbose helps ID our
files faster. Our naming convention is extremely flexible so you are free to
follow/deviate as much as you like as long as you include username, version #,
and iteration # (those are the only required args by my environment <3).

.. _item-list:

Item Types
==========
I've had trouble finding the right outlet to let people know what is most list
of allowed tags. Thank goodness we have a website now so I can host it. Here's
the full list:

 ITYP (Last updated 2016-02-03)
  Compositing Related
   - 'COMP'
   - 'OUTPT'
   - 'PASS'
   - 'PLTBG'
   - 'PLTFG'
   - 'VFX'
   - 'VFXA'
  Agnostic
   - 'BOARD'
   - 'REF'
   - 'TEX'
   - 'MOCAP'
   - 'MODEL'
   - 'LIGHT'
   - 'MATTE'
  Production
   - 'DOC'
  Sound
   - 'FOLEY'
   - 'SFX'
   - 'MUSIC'

Note that everything is in CAPS, this is required by my automated parsers

If you think this list is missing something, hit me up using my
|Administrator1 Slack Handle| or message me directly using my contact info on
the crewsheet under Google Drive


FAQ
=========================================================
 #. **Why can't we save Maya files as .mb? Aren't they better/faster/stronger?**
      Actually no, .mb files aren't automatically better just because they're
      a smaller filesize, Maya's .mb format stands for **Maya Binary** and .ma
      stands for **Maya ASCII**. Binary formats are much smaller because they
      use a more concise saving structure based on Maya node's hex values but
      they also make it impossible to edit after the fact.

      ASCII files are still human readable and sane, so for my text parser scripts 
      that need to read stuff, it just makes life a lot easier. Just ask IT for
      more space on the collab, they'll give it to us.

 #. **Colin, how can you be so awesome all of the time?**
      Vodka

 #. **If I have a problem, what should I do?**
      Message me on Slack immediately (don't wait, someone else could be having
      the problem too!). My handle is |Administrator1 Slack Handle|. Also, submit
      a bug report too if you have an error message at the `Bug Report Page <https://docs.google.com/spreadsheets/d/1PC98Qsx79s4hxRaap3m9U0cKT1TLpHDCvMtDsZAQ6ZA/edit>`_

 #. **You item list is too short and I want to add something to it. How do?**
      See the previous answer

 #. **I can't save anything but my filename is right**
      Nah, it's not. You're just tired and that's okay. Here's what you should do

      - Remove the scene/shot information (ex: s001AA or whatever) and try again.
      - Remove your description
      - Save your file

      If it then works, it means you messed up one of the optional arguments.

      If the problem still persists, you may have a bad number padding
      (version takes 3 numbers), or you put in a bad item type. Check the
      `item-list` to see all of the possible choices. Beyond that, just look at
      other similar files you've saved in the past and compare their differences
      and I bet you it will work.

      If it doesn't after all of that, I owe you a beer and an apology.
      Message me on slack and write a `bug report <https://docs.google.com/spreadsheets/d/1PC98Qsx79s4hxRaap3m9U0cKT1TLpHDCvMtDsZAQ6ZA/edit>`_.

 #. **Something changed in my application but I'm not sure if it's an error
    your scripts made or if it was my mistake. How am I to know the difference?**
      Every application has some type of script editor (a place where my
      scripts live in). In Maya, it's under Windows, General Editors, Script
      Editor (at the bottom). In Nuke you can right-click any panel and go to
      the bottom Windows > Script Editor

      If the last message before the error has a line that says POP2 in it,
      then it's my script's fault (all of my messages are prefixed as POP2).

      If you want to know what I've changed or did differently, check out the
      latest changelog entry, :ref:`changelog` for the project
 #. **I have a file/project that's final. Where do I put it?**
      Go look at the :doc:`finalfolder` for more information on that
