#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Takes the current path and generates a json file
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import json
import argparse

# IMPORT LOCAL LIBRARIES
import fileio.controller.paths as paths
import controller.engine as engine
import controller.factory as factory


def show_gui():
    pass
# end show_gui


def cmd_line(argv):
    """
    The command-line utility which interfaces with the main execution of the script

    .. Note::
     The underlying command that executes is actually
     controller.factory.make_tree_from_dict which has been modified since this
     command-line's last execution. The script may need to be updated for bugs
     before the first run

    Args:
        --inputs: (-i) The json config file(s) to process into folder
                  structures. Multiple files must be separated by spaces
        --output: (-o) The output directory location.
                  Defaults to the current working directory

    Returns:
        bool or NoneType: If the script runs all the way through without
                          exiting prematurely, the script returns True.
                          Otherwise, it will simply return None
    """
    parser = argparse.ArgumentParser(description="")
    msg = "The json file that you want to make into a directory"
    parser.add_argument('-i', '--inputs', nargs="+", dest="inputs",
                        help=msg)
    msg = "Destination for the file(s)/folder(s) that the json file creates. "\
          "This setting is only used if the root key is {root}. If the "\
          "top-level key in the dictionary is an actual folder-path, this "\
          "option is ignored"
    parser.add_argument('-o', '--output', dest="output", help=msg)
    args = parser.parse_args()
    if args.inputs == []:
        sys.exit("No input files specified (use -o)")

    if args.output is not None and not os.path.isabs(args.output):
        sys.exit('Output Directory: "{f}" is not absolute'
                 'Please specify a valid directory'.format(f=args.output))

    for f in args.inputs:
        if not os.path.isfile(f):
            sys.exit('Input: "{f}" does not exist. Please correct'
                     'before continuing'.format(f=f))
        factory.make_tree_from_dict(f, args.output)
    return True
# end cmd_line


def main():
    """
    If the user passed no arguments to the python file or if they simply
    double-clicked the script, it will open in GUI mode
    """
    if len(sys.argv) == 1:
        show_gui()
    else:
        cmd_line(sys.argv[1:])
# end main


if __name__ == "__main__":
    main()
