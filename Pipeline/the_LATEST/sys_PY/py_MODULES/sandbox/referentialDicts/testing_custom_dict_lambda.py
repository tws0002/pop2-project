#!/usr/bin/python

class ParamDict(dict):
    def __getitem__(self, key):
        val = dict.__getitem__(self, key)
        return callable(val) and val(self) or val

params = ParamDict({
    'a': 5,
    'b': bda self: 2**self['a']
    })

print params["b"]
