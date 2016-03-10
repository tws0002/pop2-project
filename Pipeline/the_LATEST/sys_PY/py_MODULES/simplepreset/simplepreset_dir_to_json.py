#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Takes  a root path and generates a json file with a single key, which
represents the root path
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import json
import argparse

# IMPORT LOCAL LIBRARIES
import fileio.controller.paths as paths
import controller.engine as engine


def make_config_file(folderPath, outputPath):
    """
    Creates the json files from a folder path and places them in an output path

    Args:
        folderPath (str): The folder (and subfolder) to make into a JSON config
        outputPath (str): The directory to place the newly created JSON config

    Returns:
        bool: True/False - The success or failure to write to the output path
    """
    rootDict = engine.RootDict()
    dictH = rootDict.path_to_dict(folderPath)
    dictH = {folderPath: dictH}
    with open(outputPath, "w") as f:
        json.dump(dictH, f, indent=4)

    if os.path.isfile(outputPath):
        return True
    else:
        return False
# end make_config_file

def show_gui():
    pass
# end show_gui


def cmd_line(argv):
    """
    The command-line utility to run the main script. At least one input
    directory is required but the output path is optional. If no output path is
    specified, the write directory defaults to the current working directory

    Args:
        --inputs: (-i) A list of directories (1 or more) to copy,
                       with each entry separated with spaces
        --output: (-o) The output location for the generated JSON config file(s)
        --extension: (-x) The output extension for the config files created.
                          Default is ".json"

    Returns:
        bool or NoneType: If the script runs successfully, it will return True.
                          If the script exits prematurely, it will have no
                          return type
    """
    parser = argparse.ArgumentParser(description="")
    msg = "The directories that you want to make into json files"
    parser.add_argument('-i', '--inputs', nargs="+", dest="inputs",
                        help=msg)
    msg = "Destination for the json files. Will be set to the directory in"\
          "which the script is called if none is specified"
    parser.add_argument('-o', '--output', dest="output", help=msg)
    msg = "Choose the extension of the output file. If not specified, the "\
          "extension defaults to a json-valid suffix"
    parser.add_argument('-x', '--extension', dest="ext", help=msg)
    args = parser.parse_args()

    if args.inputs == []:
        sys.exit("No input files specified (use -o)")

    if args.output is None:
        args.output = os.getcwd()
    elif not os.path.isdir(args.output):
        sys.exit('Output Directory: "{f}" does not exist. '
                 'Please specify a valid directory'.format(f=args.output))
    if args.ext is None:
        args.ext = "json"

    for f in args.inputs:
        if not os.path.isdir(f):
            sys.exit('Folder: "{f}" does not exist. Please correct'
                     'before continuing'.format(f=f))
        outputDir = paths.os_path_split_asunder(f)[-1]
        outputDir = os.path.join(args.output, outputDir + "." + args.ext)
        make_config_file(f, outputDir)
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
