#!/usr/bin/python
# -*- coding: utf-8 -*-


import constants.model.constants as consts
import re

class MyDict(dict):
   def __getitem__(self, item):
       return dict.__getitem__(self, item) % self

dictionary = MyDict({

    'user' : 'gnucom',
    'home' : '/home/%(user)s',
    'bin' : '%(home)s/bin',
    "test": {"value": 8},
    "newTest": {"value": '{%(test[value])s}'}
})

print dictionary["home"]
print dictionary["bin"]
print dictionary["newTest"]
