#!/usr/bin/python


import re
import fileio.controller.paths as paths



def quick(path):
    pathSplit = paths.os_path_split_asunder(path, replaceSeparators=True)
    if re.match('[a-zA-Z]:', pathSplit[0]):
        return "win32"
    else:
        return "linux2"

filename = r"home/selecaotwo/Dropbox/Private/my_PROJECT/proj_POP2/Pipeline/the_LATEST/sys_PY/py_MODULES/syncmeister/controller/asdfsfd.txt"
print quick(filename)
