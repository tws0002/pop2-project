The Definitive User Guide  - |project_long_name|
************************************************
This document was made to help the users of the project. It'll have the most
updated information so please check back once in a while if you're stuck. And
also, I just want to thank you again for being a part of the project and also
for using my tools. I hope they come in handy!

Past information
================
I can't start this post without mentioning that this builds off of previous
information stated in our group documents and powerpoints. Give those a
look-through before you read any more of this. (Don't worry, the reading is
light)

`Project Welcome Page`_

`Project Beginning Powerpoint`_

So from here on out, consider everything to be the most recent, most up-to-date
info. If you have additional questions, hit me up on our Slack page, my handle
is `Administrator1 Slack Handle`_.

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
`Administrator1 Slack Handle`_ or message me directly using my contact info on
the crewsheet under Google Drive
