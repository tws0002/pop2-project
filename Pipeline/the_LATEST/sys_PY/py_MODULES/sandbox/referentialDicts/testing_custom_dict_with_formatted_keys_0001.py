#!/usr/bin/python
# -*- coding: utf-8 -*-

# IMPORT STANDARD LIBRARIES
import string

class MyDict(dict):
    def __init__(self, *args, **kwargs):
        super(MyDict, self).__init__(*args, **kwargs)
        self.itemlist = super(MyDict,self).keys()
        self.fmt = string.Formatter()
    # end __init__

    def __getitem__(self, item):
        # return self.fmt.vformat(dict.__getitem__(self, item), {}, self)
    # end __getitem__
# end MyDict

dictionary = MyDict({
    'user' : 'gnucom',
    'home' : '/home/{user}',
    'bin' : '{home}/bin'
})

dictionary = MyDict({
    "info": {"value": 8},
    "newInfo": {"value": "{info[value]}"}
})

print dictionary["home"]
print dictionary["bin"]
