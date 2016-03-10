#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Writes to rib file
"""

# IMPORT STANDARD LIBRARIES
import os

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
        verts = get_tetrahedron('pPyramid1')
    except pm.MayaNodeError:
        tetra = init_tetrahedron()
        verts = tetra.getPoints()
        bb = tetra.getBoundingBox()
        bbMinX = bb[0]
        bbMaxX = bb[1]
        bbMinY = bb[2]
        bbMaxY = bb[3]
        bbMinZ = bb[4]
        bbMaxZ = bb[5]              
        
    reps = 1000
    pointList = sierpin.sierpinski(seed, geometryVerts, reps)
    pointList = [str(item) for sublist in pointList for item in sublist]
    pointList = ' '.join(pointList)

    # get file and write
    ribTemplate = os.path.dirname(os.path.realpath(__file__))  # pwd
    writeOut = os.path.join(ribTemplate, 'model', 'rib_output.rib')
    ribTemplate = os.path.join(ribTemplate, 'model', 'rib_template.rib')
    ribOut = ribparticle.RibOutput()
    ribOut.get_file(ribTemplate)
    outputData = ribOut.ribData[0].format(points=pointList, constwidth=0.01, 
                                          minX=bbMinX, minY=bbMinY, minZ=bbMinZ,
                                          maxX=bbMaxX, maxY=bbMaxY, maxZ=bbMaxZ)                                        
    with open(writeOut, 'w') as f:
        f.write(outputData)
# end main


if __name__ == "__main__":
    main()
