#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Writes to rib file
"""


















################################################################################
# START SIERPINSKI
################################################################################

#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Makes sierpinski pattern from a polyPyramid in Maya
"""

# IMPORT STANDARD LIBRARIES
import sys
import random

# IMPORT THIRD PARTY LIBRARIES
try:
    import pymel.core as pm
    import maya.cmds as cmds
except ImportError:
    print("Not currently in a Maya environment")


def midpoint_3d(p1, p2):
    midpoint = [(value + p2[index]) / 2 for index, value in enumerate(p1)]
    return midpoint
# end midpoint_3d


def init_tetrahedron():
    pyPyramid = pm.polyPyramid()[0]
    pyPyramidShape = pyPyramid.getShape()
    return pyPyramidShape
# init_tetrahedron


def get_tetrahedron(node='pPyramid1'):
    pyPyramid = pm.PyNode(node)
    pyPyramidShape = pyPyramid.getShape()
    return pyPyramidShape
# end get_tetrahedron


def sierpinski(seed, verts, reps):
    """
    Creates sierpinski pattern from a at least 3 points
    """
    if len(verts) < 4:
        sys.exit("Please provide at least 4 points")
        
    for n in xrange(reps):
        randPoint = random.choice(verts)
        midPnt = [(value + seed[index]) / 2 for index, value in enumerate(randPoint)]
        seed = midPnt
        yield midPnt
# end sierpinski


def make_and_set_objs(points, scl, grp=None):
    for pos in points:
        loc = cmds.spaceLocator(p=pos)[0]
        # loc.translate.set(pos)
        # loc.scale.set(scl)
        
        if grp != None:
            cmds.parent(loc, grp)

################################################################################
# END SIERPINSKI
################################################################################





################################################################################
# START RIBPARTICLE
################################################################################

# IMPORT STANDARD LIBRARIES
import sys
import random

# IMPORT THIRD PARTY LIBRARIES
# import pymel.core as pm
# import maya.cmds as cmds

# IMPORT LOCAL LIBRARIES
# import sierpinski_0005_cmds_WIP as sierpin

class RibOutput(object):
    def __init__(self):
        super(RibOutput, self).__init__()
        self.ribData = ''
    # end __init__
    
    def get_file(self, path):
        with open(path, 'r') as f:
            data = f.readlines()
        self.ribData = data
    # end get_file
# end RipOutput


def main():
    seed = [0, 0, 0]
    try:
        verts = get_tetrahedron('pPyramid1')
    except pm.MayaNodeError:
        verts = init_tetrahedron()
        
    reps = 10000
    pointList = sierpinski(seed, verts, reps)
    ribOut = RibOutput()
    # grp = cmds.group(em=True, n="sierpinski_grp")
    # [make_and_set_objs(x, [0.01, 0.01, 0.01], grp) for x in pointList]
    # make_and_set_objs(pointList, [0.01, 0.01, 0.01], grp)
# end main


################################################################################
# END RIBPARTICLE
################################################################################







# IMPORT STANDARD LIBRARIES
import os

# IMPORT THIRD-PARTY LIBRARIES
import pymel.core as pm

# IMPORT LOCAL LIBRARIES
import sierpinskigasket.controller.sierpinski_0005_cmds_WIP as sierpin
import sierpinskigasket.controller.ribparticle as ribparticle


def main():
    # generate sierpinski gasket data
    seed = [0, 0, 0]
    # geometryVerts = [[1.155, 0.0, -2.0],
    #          [-1.155, 0.0, 2.0],
    #          [2.309, 0.0, 0.0],
    #          [0.0, 3.266, 0.0]]
    try:
        tetra = pm.PyNode('pPyramid1')
    except pm.MayaNodeError:
        tetra = pm.polyPyramid()[0]
    finally:
        verts = tetra.getShape().getPoints()
        bbMax = tetra.getBoundingBoxMax()
        bbMin = tetra.getBoundingBoxMin()
        bbMinX = bbMin[0]
        bbMinY = bbMin[1]
        bbMinZ = bbMin[2]
        bbMaxX = bbMax[0]
        bbMaxY = bbMax[1]
        bbMaxZ = bbMax[2]        

    reps = 1000
    pointList = sierpinski(seed, verts, reps)
    pointList = [str(item) for sublist in pointList for item in sublist]
    pointList = ' '.join(pointList)

    # get file and write
    # ribTemplate = os.path.dirname(os.path.realpath(__file__))  # pwd
    ribTemplate = r"/home/ckenne24/mount/stuhome/tech312/python/sierpinskigasket"
    writeOut = os.path.join(ribTemplate, 'model', 'rib_output.rib')
    ribTemplate = os.path.join(ribTemplate, 'model', 'rib_template.rib')
    ribOut = ribparticle.RibOutput()
    with open(ribTemplate) as f:
        data = f.readlines()
    data = ''.join(data)
    print data

    outputData = data.format(points=pointList, constwidth=0.01, 
                             minX=bbMinX, minY=bbMinY, minZ=bbMinZ,
                             maxX=bbMaxX, maxY=bbMaxY, maxZ=bbMaxZ)
    print outputData
    with open(writeOut, 'w') as f:
        f.write(outputData)
    
    # delete the pyramid for now. :::TO DO::: :::AUTHOR NOTE::: COMMENT OUT LATER
    pm.delete(tetra)
    print 'DONE'
# end main


if __name__ == "__main__":
    main()
