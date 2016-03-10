#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
Quick Test, using a Maya file
"""

def test_sync():
    """
    Basic test sync initialization, based on the following test folder structure

    Feb 10, 2016:
     The Maya directory includes the following:
         - src_location
           - created_project  # An example Maya Project
           - reference  # A test parent-maya scene with a file containing relative paths
             - sphere_relative_test.ma  # file with all relative paths
             - sourceimages
               - black_calcification_seamless_0001.jpg
             - image.png
         - copy_location  # the place where src_location must be copied to
    """
    pass
    import re
    reCompile = r'"([^"]*)"'
    reCompile = r".+\".+\"."
    # reCompile = "asdf'"
    reCompile = re.compile(reCompile)

    fileLocation = r"/home/selecaotwo/Desktop/basic_test.ma"
    with open(fileLocation, "r") as f:
        data = f.readlines()

    for line in data:
        reMatch = re.match(reCompile, line)
        print line
        print reMatch

# end test_sync


if __name__ == "__main__":
    test_sync()
