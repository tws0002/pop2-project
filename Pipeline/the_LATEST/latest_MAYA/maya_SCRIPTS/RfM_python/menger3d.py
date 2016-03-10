#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Project
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
TECH312 - Menger Fractal

Description
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Implements a recursive subdivision of a cube into 27 sub
cubes - three "layers" each with nine cubes. The indices
in the "holeLUT" are used to delete specific cubes from
each layer.
Malcolm Kesson Jan 16 2013
Converted to a class: Feb 9 2016

Filename
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
menger3d.py
"""

# IMPORT STANDARD LIBRARIES
from math import sqrt

# IMPORT LOCAL LIBRARIES
import ri_utils


class Menger3D:
    def __init__(self, bbox, depth, listOfHoles):
        """
        Inits a 3D menger fractal (shape of a cube)

        Args:
            bbox (list of lists): contains the min/max bounding box of the mesh
            depth (int): The number of recursions created before the menger is
                         drawn
            listOfHoles (list of ints): A flat list of indices (numbered from 1
                                        27) which is every inner menger cube
                                        when depth is 3
        """
        self.deletedCubes = []
        self.retainedCubes = []
        self.holeLUT = listOfHoles
        self.bbox = bbox            # minx,miny,minz, maxx,maxy,maxz
        self.depth = depth
        self.divide(bbox, depth)    # the recursive routine
    # end __init__

    def row(self, x0,y0,z0, w,h,d):
        """
        Given the minimum x,y,z and maximum x,y,z coordinates
        of a bounding box this proc returns the bouding box
        coordinates of a "row" of three cubes.

        Args:
            x0 (float): The x position of one end of the bounding box of a
                        menger row
            y0 (float): The y position of one end of the bounding box of a
                        menger row
            z0 (float): The z position of one end of the bounding box of a
                        menger row
            w (float): The total width of the menger row
            h (float): The height of the menger row
            d (float): The depth of the row

        Returns:
            list of list: List of cubes that were created within a single row
        """
        x,y,z = x0,y0,z0
        X,Y,Z = x + w, y + h, z + d
        cubes = []
        for n in range(3):
            cube = [x,y,z, X,Y,Z]
            cubes.append(cube)
            z,Z = z + d, Z + d
        return cubes
    # end row

    def divide(self, bbox, depth):
        """
        A recursive proc that subdivides a bounding box into
        27 sub-cubes. Each time the proc is called the arg
        "depth" is decremented. Recursion terminates when its
        value becomes zero.

        Args:
            bbox (list of lists): contains the min/max bounding box of the mesh
            depth (int): The number of recursions created before the menger is
                         drawn

        Returns:
            list of lists: The divided cubes, minus the original, undivided
                           cubes
        """

        if depth == 0:
            self.retainedCubes.append(bbox)
            return []
        x0,y0,z0,x1,y1,z1 = bbox
        w = float(x1 - x0)/3
        h = float(y1 - y0)/3
        d = float(z1 - z0)/3

        x,y,z = x0,y0,z0
        cubes = []
        for layer in range(3):
            x = x0
            for rows in range(3):
                cubes.extend(self.row(x,y,z,w,h,d))
                x = x + w
            y = y + h
        cubes = self.delete(cubes)
        # Recursion________________
        for cube in cubes:
            self.divide(cube, depth - 1)
        return cubes
    # end divide

    def delete(self,cubes):
        """
        Uses the indices in the holeLUT to remove specific cubes
        from the list of 27 cubes in the "cubes" arg.

        Args:
            cubes (list): The cubes to delete

        Returns:
            list: The original cubes that were deleted
        """
        for n in range(len(self.holeLUT)):
            index = self.holeLUT[n]
            if index < len(cubes):
                hole = cubes.pop(self.holeLUT[n])
                self.deletedCubes.append(hole)
        return cubes
    # end delete

    def writeAsCubes(self, rib_path, cube_type='retained'):
        """
        Write a RenderMan archive rib file for the menger cubes
        or for the cubes that were removed by the delete method.

        Args:
            rib_path (str): The full path to the 3D menger
            cube_type (str): picks the cube display

        Returns:
            int: The number of cubes that were either deleted or retained
        """
        f = open(rib_path,'w')
        bboxStr = ' '.join(map(str, self.bbox))
        f.write('#bbox: %s\n' % bboxStr)
        if cube_type == 'retained':
            cubes = self.retainedCubes
        else:
            cubes = self.deletedCubes
        counter = 1
        for cube in cubes:
            f.write(ri_utils.Cube(cube, counter))
            counter += 1
        f.close()
        return len(cubes)
    # end writeAsCubes

    def distance(self, p1, p2):
        """
        Not used in this example implementation but could be
        used to cull cubes on the basis of their distance from
        a central location - to create a menger sphere.

        Args:
            p1 (list): A 3D point to draw a distance from
            p2 (list): A 3D point to draw a distance from

        Returns:
            float: The distance between p1 and p2
        """
        x = p1[0]-p2[0]
        y = p1[1]-p2[1]
        z = p1[2]-p2[2]
        return sqrt(x * x + y * y + z * z)
    # end distance
# Menger3D


def test_menger_3d():
    """
    Quick test module
    """
    bounds = [-1,0,-1, 1,2,1]
    removals = [10,2,1,3,4,11,12,13,3,5,22,24]
    menger3d = Menger3D(bounds, 2, removals)
    print menger3d.writeAsCubes('/home/mkesson/menger3d.rib')
# end test_menger_3d


if __name__=="__main__":
    test_menger_3d()
