#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Description
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Testing module examples for PickRunner

.. note::
    These modules assume that the proper modules have already been loaded. They
    haven't been tested outside of that assumption

Filename
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
test.py
"""

# IMPORT STANDARD LIBRARIES
import pickrunner.controller.engine as engine
import pickrunner.model.header as header


__author__ = header.__author__
__copyright__ = header.__author__
__license__ = header.__license__
__version__ = header.__version__
__email__ = header.__email__
__status__ = header.__status__


def test_get_left():
    motor = engine.MotorMaya("centerLoc1")
    print motor.members.left
# end test_get_left


def test_set_left():
    motor = engine.MotorMaya("centerLoc1")
    # use the name of some metadata node
    motor.members.left = "_PickRunner_metadata_"\
                         "57A839D5_4F86_5858_E26F_59A861938199"  # UUID
# end test_set_left

def test_large_scene():
    # create a grid of locators
    locatorDictH = {}
    gridOfLocators = (10, 10)
    spacing = 4
    offsetX = -4.5 * 4
    offsetY = 5
    for x in xrange(gridOfLocators[0]):
        for y in xrange(gridOfLocators[1]):
            locator = pm.spaceLocator()
            xCoord = (spacing * x) + offsetX
            yCoord = (spacing * y) + offsetY
            locator.translate.set([xCoord, yCoord, 0])
            locator.rotate.set([-45, -45, -45])
            position = (x,y)
            locatorDictH.update({position: locator})    

    # set-up connections
    for position, locator in locatorDictH.iteritems():
        x, y = position
        otherPositions = [(0, -1), (-1, 0), (0, 1), (1, 0)]
        motor = engine.MotorMaya(locator)
        motor.init_metadata_proxy()
        for num, pos in enumerate(otherPositions):
            posX = pos[0]
            posY = pos[1]
            try:
                adjacentLoc = locatorDictH[x-posX, y-posY]
            except KeyError:
                # skip, the index locator doesn't exist at this position
                continue

            adjMotor = engine.MotorMaya(adjacentLoc)
            adjMotor.init_metadata_proxy()
            if num == 0:  # up
                motor.members.up = adjMotor
            elif num == 1:  # left
                motor.members.left = adjMotor
            elif num == 2:  # down
                motor.members.down = adjMotor
            elif num == 3:  # right
                motor.members.right = adjMotor
# test_large_scene

if __name__ == "__main__":
    print(__doc__)