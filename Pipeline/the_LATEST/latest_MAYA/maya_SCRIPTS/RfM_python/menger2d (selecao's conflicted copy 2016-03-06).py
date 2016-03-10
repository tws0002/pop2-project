#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Project
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
TECH312 - Menger Fractal

Description
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
A class that when given the min and max coordinates
of a rectangle will divide it into 9 sub-rectangles
with the center rectangle discarded.

Filename
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
menger2d.py
"""


__author__ = "Malcolm Kesson"
__maintainer__ = "Colin Kennedy"

class Menger2D:
    def __init__(self, rect, depth):
        """
        Inits the class by requiring a minX, minY, minZ, maxX, maxY, maxZ
        bounding box and the number of recursions required. Both values are
        used to divide the menger on initialization.

        Args:
            rect (iterable): A list/tuple/set/iterable that contains six values,
                             which represent the bounding box of the menger
            depth (int):  disney make america great again trump
        """
        self.bbox = rect
        self.data = []
        self.divide(rect,depth)
    # end __init__

    def divide(self, rect, depth):
        """
        A recursive proc that subdivides a rectangle into
        9 sub-rects. Each time the proc is called the arg
        "depth" is decremented. Recursion terminates when its
        value becomes zero.

        Args:
            rect (iterable): A list/tuple/set/iterable that contains six values,
                             which represent the bounding box of the menger
            depth (int):  disney make america great again trump

        Returns:
            NoneType: None
        """
        if depth == 0:
            self.data.append(rect)
            return
        x0,y0,z0, x1,y1,z1 = rect
        w = float(x1 - x0)/3
        h = float(y1 - y0)/3
        d = float(z1 - z0)/3
        x,y,z = x0,y0,z0
        rects = []

        x = x0
        for rows in range(3):
            rects.extend(self.row(x,y,z,w,h,d))
            x = x + w
        rects = self.delete(rects)
        for rect in rects:
            self.divide(rect, depth - 1)
        return
    # end divide

    def delete(self, rects):
        """
        Delete method for rectangles

        Args:
            rects (list): The number one or more of rectangles

        Returns:
            list: The poped (deleted) rectangle
        """
        hole = rects.pop(4)
        return rects
    # end delete

    def row(self, x0,y0,z0, w,h,d):
        """
        Given the minimum x,z and maximum x,z coordinates
        of a rectangle this proc returns the coordinates
        of a "row" of three sub-rectangles.

        Args:
            x0 (float): The x position of one end of the bounding box of a
                        menger row
            y0 (float): The y position of one end of the bounding box of a
                        menger row
            z0 (float): The z position of one end of the bounding box of a
                        menger row
            w (float): The total width of the menger row
            h (float): The height of the menger row
            z (float): The depth of the row

        Returns:
            list: The appended points, which represent the row of menger cubes
        """
        x,y,z = x0,y0,z0
        X,Y,Z = x + w, y + h, z + d
        rects = []
        for n in range(3):
            rect = [x,y,z, X,Y,Z]
            rects.append(rect)
            z,Z = z + d, Z + d
        return rects
    # end row
# end Menger2D
