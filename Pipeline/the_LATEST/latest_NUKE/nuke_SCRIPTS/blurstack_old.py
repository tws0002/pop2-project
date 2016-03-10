#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import with_statement  # < py 2.5.X

"""
Description
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Creates a stack of blurs which update interactively within Nuke's viewer.
Because this script lives within the context of a Nuke gizmo, there is no
__name__ statement or main function.

Filename
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
blurStack_helper_function.py
"""

# IMPORT STANDARD LIBRARIES
import math

# IMPORT THIRD-PARTY LIBRARIES
import nuke

def set_bias(inputH, bias):
    """
    Pushes values in a smooth way from one extreme to another between the range
    of 0 to 1. This function is used in set_contrast to define the contrast
    of the output image

    Args:
        inputH (float): A value to bias in one direction or another
        bias (float): The amount to bias the value. If bias is clamped at zero
                      and all values above zero perform a log operation
                      on modulate inputH's ouput value

    Returns:
        float or int: Will return 0 if bias is on or below 0, else it returns
                      a float above the value of 0
    """
    if bias > 0:
        power = math.log10(bias) / math.log10(0.5)
        return math.pow(inputH, power)
    else:
        return 0
# end set_bias

def set_contrast(inputH, contrast):
    """
    Changes an input value image, making darks darker and lights lighter
    set_contrast uses bias depending on whether the input value is below or
    above the exact midpoint value of the image, 0.5. This operation is meant
    to be done per-channel (r,g,b) individually.

    .. note::
        The value is reduced to 1/2 to order to keep the number within the
        range of 0 to 1

    Args:
        inputH (float): The value to change the contrast of
        contrast (float): The amount to change the contrast of the inputH.
                          A value of 0.5 does nothing, values lower than 0.5
                          increase contrast and values above reduce contrast

    Returns:
        float: The output value from the operation
    """
    if input < 0.5:
        outValue = set_bias(2 * inputH, 1 - contrast)
    else:
        outValue =  2 - set_bias(2 - (2 * inputH), 1 - contrast)
    return outValue * 0.5
# end set_contrast

def set_gamma(inputH, gamma):
    """
    Changes the gamma of an inputH, much like bias but the effect is created
    by modifying the value by a power function, instead of how set_bias does it
    through a log division

    Args:
        inputH (float): The input value to change the gamma of
        gamma (float): The gamma value whose inverse is applied to inputH

    Returns:
        float: The output value from the operation
    """
    return math.pow(inputH, 1/gamma)
# end set_gamma

def set_compression(inputH, lo, hi):
    """
    Linearly squashes values so that the input's maximum value is restricted by
    the hi, its lo cannot be lower than lo, and every value in-between is some
    percentage between the two ranges

    Args:
        inputH (float): The input value to change the gamma of
        lo (float): The lowest allowed value of the output
        hi (float): The highest allowed value of the output

    Returns:
        float: The output value from the operation
    """
    return ((hi-lo) * inputH) + lo
# end set_compression

def set_expansion(inputH, lo, hi):
    """
    Linearly stretches values so that the input's maximum value is restricted by
    the hi, its lo cannot be lower than lo, and every value in-between is some
    percentage between the two ranges. It is essentially the inverse process
    of set_compression but has the same types of inputs

    Args:
        inputH (float): The input value to change the gamma of
        lo (float): The lowest allowed value of the output
        hi (float): The highest allowed value of the output

    Returns:
        float: The output value from the operation
    """
    returnval = 0
    if (lo == hi):
        if inputH < lo:
            return 0
        else:
            return 1
    else:
        return float(inputH - lo) / (hi-lo)
# end set_expansion

# Get node attribute information
# :NOTE: If the output of "step" that results from these attributes is within
# the range of 0 to 1, these attributes basically have no effect on the actual
# blurStack's output. But if the value returned from the for-loop is outside of
# 0 to 1, a fail-safe op is done to clamp the values within 0 to 1
#
# (in other words, these attributes are used to check, not in any node's knobs)
#
# thisNode = nuke.thisNode()
thisNode = nuke.toNode("blurStack")
quality = int(thisNode.knob("quality").getValue())
minimum = int(thisNode.knob("minBlur").getValue())
maximum = int(thisNode.knob("maxBlur").getValue())
contrast = thisNode.knob("contrast").getValue()
gamma = thisNode.knob("gamma").getValue()
compress = thisNode.knob("compression").getValue()
expand = thisNode.knob("expansion").getValue()
colorFalloff = thisNode.knob("colorFalloff").getValue()

with thisNode:
    # GET INFO FOR REINITIALIZATION
    connectedNode = thisNode.input(0)

    # RESET ALL
    nAll = nuke.allNodes()
    [nuke.delete(n) for n in nAll]

    # REINITIALIZATION FROM START
    inputH = nuke.nodes.Input()
    inputH.setInput(0, connectedNode)

    for i in xrange(quality):
        # perform some simple math ops to modify the
        # (otherwise) linear step function
        #
        step = 1 - float(i)/quality
        color = step
        step = set_contrast(step, contrast)
        step = set_gamma(step, gamma)
        step = set_compression(step, compress[0], compress[1])
        step = set_expansion(step, expand[0], expand[1])
        if step < 0:
            step = "0"
        elif step > 1:
            step = "1"
        else:
            step = "1 - float({})/nuke.thisGroup().knob('quality').getValue()".format(i)
            step = "set_contrast({}, nuke.thisGroup().knob('contrast').getValue())".format(step)
            step = "set_gamma({}, nuke.thisGroup().knob('gamma').getValue())".format(step)
            step = "set_compression({}, nuke.thisGroup().knob('compression').x(),"\
                   "nuke.thisGroup().knob('compression').y())".format(step)
            step = "set_expansion({}, thisNode.knob('expansion').x(), "\
                   "thisNode.knob('expansion').y())".format(step)

        blur = nuke.nodes.Blur()
        merge = nuke.nodes.Merge()

        blur.connectInput(0, inputH)
        blur.knob("size").setExpression('[python {} * (nuke.thisGroup().knob("maxBlur").value() - nuke.thisGroup().knob("minBlur").value()) + nuke.thisGroup().knob("minBlur").value()]'.format(step))

        multiply = nuke.nodes.Multiply()
        colorFalloff = '1 - ((1- {}) * color)'

        colorExpression = []
        for x in xrange(3):
            strH = 'nuke.thisGroup().knob("colorFalloff").getValue({}) * {}'.format(x, step)
            colorExpression.append(strH)

        multiply.knob("value").setExpression('[python {}]'.format(colorFalloff.format(colorExpression[0])), 0)
        multiply.knob("value").setExpression('[python {}]'.format(colorFalloff.format(colorExpression[1])), 1)
        multiply.knob("value").setExpression('[python {}]'.format(colorFalloff.format(colorExpression[2])), 2)
        multiply.knob("value").setExpression('1', 3)
        multiply.connectInput(0, blur)

        merge.connectInput(1, multiply)
        if i == 0:
            merge.connectInput(0, inputH)
        else:
            merge.connectInput(0, previous)

        previous = merge

    # create one more
    blur = nuke.nodes.Blur()
    merge = nuke.nodes.Merge()

    blur.connectInput(0, inputH)
    blur.knob("size").setExpression('[python nuke.thisGroup().knob("minBlur").value()]')

    merge.connectInput(1, blur)

    if i == 0:
        merge.connectInput(0, inputH)
    else:
        merge.connectInput(0, previous)

    output = nuke.nodes.Output()
    output.connectInput(0, merge)
