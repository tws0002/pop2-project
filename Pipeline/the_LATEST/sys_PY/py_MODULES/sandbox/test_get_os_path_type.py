#!/usr/bin/python

import os

import fileio.controller.paths as paths

def getit(path):
    folders = []
    while 1:
        path, folder = os.path.split(path)

        if folder != "":
            folders.append(folder)
        else:
            if path != "":
                folders.append(path)

            break

    folders.reverse()
    return folders

str1 = r"C:\Some\Example Path\from\windows.txt"
str4 = r"C:/Some/Example Path/from/windows.txt"
str2 = r"C:Some\Example-Path\from\windows.txt"
str3 = r"/root/derp/Example-Path/linux.txt"
str5 = r"//UNC/path/Example-Path/linux.txt"

filepaths = [str1, str2, str3, str4, str5]
for path in filepaths:
    # print os.path.splitdrive(path)
    # print getit(path)
    drive, path = os.path.splitdrive(path)
    print paths.os_path_split_asunder(path, replaceSeps=True)
