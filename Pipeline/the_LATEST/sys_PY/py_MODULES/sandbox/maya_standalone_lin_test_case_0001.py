import sys
sys.path.append('/usr/autodesk/maya/lib/python2.7/site-packages')
sys.path.append('/usr/autodesk/mentalrayForMaya2016')

import maya.standalone
import maya.OpenMaya as OpenMaya


maya.standalone.initialize("Python")
import maya.cmds as cmds  # must be imported in-line, after initialization

try:
        maya.standalone.initialize( name='python' )
except:
        sys.stderr.write( "Failed in initialize standalone application" )
        raise


file_h = "/home/ckenne24/mount/stuhome/portal-origins-part-2/temp/test_maya_standalone_file_delete_me_later_0001.ma"

opened_file = cmds.file(maya_file_to_open, o=True)
print
print
#print cmds.getAttr("pSphere1.translateX")
print
print
# sys.stderr.write( "Hello world! (script output)\n" )
# OpenMaya.MGlobal().executeCommand( "print \"Hello world! (command script output)\\n\"" )        

#cmds.loadPlugin("Mayatomr")  # load any required plugs here
# Open your file
#opened_file = cmds.file(self.fullPath, o=True)
maya.standalone.uninitialize()

