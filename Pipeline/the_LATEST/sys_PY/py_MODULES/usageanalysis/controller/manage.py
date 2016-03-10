#!/usr/bin/env python

"""
Project::
 Portal Origins: Part Two
Description::
 Manage is used to decide what to do with files that have been flagged
 for not being used in any scene files. Users can delete, rename, or exempt
Author::
 Colin Kennedy
"""

def rename_file():
    pass
# end rename_files

def delete_file():
    pass
# end delete_file

def split_path(path, splitOperator):
    from itertools import chain
    iteration = 0
    while iteration < len(splitOperator):
        if iteration != 0:
            path = [x.split(splitOperator[iteration]) for x in path]
            path = list(chain.from_iterable(path))
        else:
            path = path.split('/')

        iteration += 1

    return path
# end split_path

def main():
    import os
    string = "C:\Users/SelecaoOne/Desktop\\some_file.ma"
    print split_path(path=string, splitOperator=('/', '\\', '\\\\'))
# end main

if __name__ == "__main__":
    main()
