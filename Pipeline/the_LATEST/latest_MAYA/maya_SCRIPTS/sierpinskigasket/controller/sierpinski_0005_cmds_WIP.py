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


def main():
    seed = [0, 0, 0]
    try:
        verts = get_tetrahedron_points('pPyramid1')
    except pm.MayaNodeError:
        verts = init_tetrahedron_points()
        
    reps = 10000
    pointList = sierpinski(seed, verts, reps)
    grp = cmds.group(em=True, n="sierpinski_grp")
    # [make_and_set_objs(x, [0.01, 0.01, 0.01], grp) for x in pointList]
    make_and_set_objs(pointList, [0.01, 0.01, 0.01], grp)
# end main


if __name__ == "__main__":
    print('\n\n\n')
    import cProfile
    cProfile.run('main()')
    # import time
    # t0 = time.time()
    # main()
    # d=time.time()-t0
    # print "duration is %s" % d
