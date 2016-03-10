#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Makes sierpinski pattern from a polyPyramid in Maya
"""

# IMPORT STANDARD LIBRARIES
import sys
import random

# IMPORT THIRD PARTY LIBRARIES
# import pymel.core as pm
# import maya.cmds as cmds

# IMPORT LOCAL LIBRARIES
import sierpinski_0005_cmds_WIP as sierpin

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


if __name__ == "__main__":
    print('\n\n\n')
    import cProfile
    cProfile.run('main()')
    # import time
    # t0 = time.time()
    # main()
    # d=time.time()-t0
    # print "duration is %s" % d
