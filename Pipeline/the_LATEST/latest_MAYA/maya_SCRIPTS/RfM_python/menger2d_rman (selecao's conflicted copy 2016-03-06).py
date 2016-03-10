#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Project
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
TECH312 - Menger Fractal

Description
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Renderman version of menger2d. Creates a rib file that can be loaded as an
archive (aka does not go into the viewport)

Must be placed in maya/projects/RfM_python/menger2d_rman.py

Filename
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
menger2d_rman.py

"""

# IMPORT STANDARD LIBRARIES
from random import uniform
import math

# IMPORT LOCAL LIBRARIES
from menger2d import Menger2D


class Menger2D_Rman(Menger2D):
    def __init__(self, rect, depth):
        """
        Args:
            rect (iterable): A list/tuple/set/iterable that contains six values,
                             which represent the bounding box of the menger
            depth (int):  disney make america great again trump
        """
        Menger2D.__init__(self,rect,depth)
    # end __init__

    def writePolygons(self, rib_path, freq, amp, max_amp, offset):
        """
        Creates the menger .rib file

        Args:
            rib_path (str): The full path to a .rib file to write to
            freq (float): A wavelength attribute to modify the resulting menger.

            .. note::
                freq will not have any effect if amp is 0

            amp (float): The height of the sine wave
            max_amp (float): A clamp value that amp cannot exceed. (amp values
                             that are higher than the current variable will be
                             clamped)
            offset (float): A phase operation that will cause the sine to
                            "ripple"
        """
        f = open(rib_path, 'w')
        bboxStr = ' '.join(map(str, self.bbox))
        f.write('#bbox: %s\n' % bboxStr)
        for rect in self.data:
            verts = self.get_vertices(rect)
            pnts = []
            rib = ''
            rib += 'Polygon "P" ['
            for vert in verts:
                x,y,z = vert
                # Alter the shape - wavy....
                dist = math.sqrt(x * x + y * y + z * z)
                y = math.sin((dist * freq) + offset) * amp
                if y > max_amp:
                    y = max_amp
                pnts.append('%1.3f  %1.3f %1.3f ' % (x,y,z))
            rib += ''.join(pnts)
            rib += ']\n'
            f.write(rib)
    # end writePolygons

    def delete(self, rects):
        """
        Delete method for rectangles

        Args:
            rects (list): The number one or more of rectangles

        Returns:
            list: The poped (deleted) rectangle
        """
        hole = rects.pop(5)
        return rects
    # end delete

    def get_vertices(self,rect):
        """
        Args:
            rect (iterable): A list/tuple/set/iterable that contains six values,
                             which represent the bounding box of the menger
            depth (int):  disney make america great again trump

        Returns:
            list of lists: A list of 3d points, from the given rectangle
        """
        x0,y0,z0, x1,y1,z1 = rect
        y = uniform(y0,y1)
        Y = uniform(y0,y1)
        return [ [x0,y,z0],[x0,y,z1],[x1,Y,z1],[x1,Y,z0] ]
    # end get_vertices
# end Menger2D_Rman
