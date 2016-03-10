#!/usr/bin/python
# -*- coding: utf-8

"""
Determines Go/Stop/Pause and other conditional operations within larger
applications
"""


class BaseOperation:
    def __init__(self):
        pass
    # end __init__
# end BaseStrategy

class Operation(BaseOperation):
    def __init__(self):
        super(Operation, self).__init__()
        self.STOP = None
        self.START = None
        self.CONTINUE = None
        self.PAUSE = None
        self.STATUS = None
        self.CONTINUE = None
        self.RECURSIVE_SAME_CLASS = None
        self.PASS = None
        self.SWITCH = None
    # end __init__
# end Operation


if __name__ == "__main__":
    print(__doc__)
