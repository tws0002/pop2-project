Final Folder
********************************************************************
This is the main page where i talk about the final folder and everything related
to what goes in it. To sum it up, there are two main sections for the Final
folder.



.. _finalassets:

Final Assets
=================================================================
Basically, if what you're saving isn't a .exr (an image file), it's going to go
in this folder

The rules for the Final/Assets folder are as follows:
 #. Only FOLDERS go in this directory. Files/assets can go in those folders but
    there should be nothing in the top-level
 #. Only one finalized asset (and its dependencies) in a single folder. If
    you're saving a model and it requires texture files and the like, ONE .ma
    file is permitted in that folder + any of the other files it needs. If you
    have variants on a finalized asset, just make another folder.
 #. Name your folder exactly the same name as the scene file you plan to save.
    A scene asset called ckenne24_barrel24_FIN.ma should be within a folder
    called ckenne24_barrel24_FIN. That way it's easy to search for the asset in
    any given folder.
 #. All of the names that you make must have _FIN either at the end of it or
    before the file extension. This is another layer of precaution.
 #. Don't reupload final.0001, final.0002, final.0003. It's just going to
    complicate things for people later on
 #. Use descriptive file names when you're naming your final assets

Final Footage
===================================================================
When exporting footage, the rules are dead simple:
 #. EXRs only, please
 #. Have _FIN at the end of every file
 #. use the scene/shot name in the beginning of the file (like you do with
    filenames)
 #. Have an increment of padding 4 (like you're already used to)

 So an example EXR file would be s001AA.0700.exr. Is that simple or what?
