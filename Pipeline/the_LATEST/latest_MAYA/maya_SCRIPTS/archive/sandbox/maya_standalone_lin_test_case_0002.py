import os, sys

sys.path.append('/usr/autodesk/maya/lib/python2.7/site-packages')
# sys.path.append('/usr/autodesk/mentalrayForMaya2016')

"""

os.environ["MAYA_LOCATION"] = "C:\Program Files\Autodesk\Maya2014"
os.environ["PYTHONHOME"] = "C:\Program Files\Autodesk\Maya2014\Python"
os.environ["PATH"] = "C:\\Program Files\\Autodesk\\Maya2014\\bin;" + os.environ["PATH"]

sys.path.append("C:\Program Files\Autodesk\Maya2014\Python\lib\site-packages\setuptools-0.6c9-py2.6.egg")
sys.path.append("C:\Program Files\Autodesk\Maya2014\Python\lib\site-packages\pymel-1.0.0-py2.6.egg")
sys.path.append("C:\Program Files\Autodesk\Maya2014\Python\lib\site-packages\ipython-0.10.1-py2.6.egg")
sys.path.append("C:\Program Files\Autodesk\Maya2014\Python\lib\site-packages\ply-3.3-py2.6.egg")
sys.path.append("C:\Program Files\Autodesk\Maya2014\\bin\python26.zip")
sys.path.append("C:\Program Files\Autodesk\Maya2014\Python\DLLs")
sys.path.append("C:\Program Files\Autodesk\Maya2014\Python\lib")
sys.path.append("C:\Program Files\Autodesk\Maya2014\Python\lib\plat-win")
sys.path.append("C:\Program Files\Autodesk\Maya2014\Python\lib\lib-tk")
sys.path.append("C:\Program Files\Autodesk\Maya2014\\bin")
sys.path.append("C:\Program Files\Autodesk\Maya2014\Python")
sys.path.append("C:\Program Files\Autodesk\Maya2014\Python\lib\site-packages")

import maya.standalone
maya.standalone.initialize(name='python')

################################################################ 
"""
import maya.standalone
import maya.OpenMaya as OpenMaya

def main( argv = None ):
    maya.standalone.initialize("Python")
    import maya.cmds as cmds

    # cmds.pluginInfo( query=True, listPlugins=True )

    # cmds.loadPlugin("Mayatomr")  # load any required plugs here
    file_h = [r"/home/ckenne24/mount/stuhome/portal-origins-part-2/temp/test_maya_standalone_file_delete_me_later_0001.ma"]

    if 'file' in dir(cmds):
    	print "True"
    # opened_file = cmds.file(file_h)

    maya.standalone.uninitialize()

if __name__ == "__main__":
    main()