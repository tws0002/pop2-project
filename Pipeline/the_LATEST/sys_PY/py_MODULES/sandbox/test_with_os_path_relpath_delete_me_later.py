#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
path1 = r"/some///path//here/with/file"
path2 = r"/some///path//there/asdf"
path2 = r"/some///path//here"

print os.path.relpath(path1, path2)
