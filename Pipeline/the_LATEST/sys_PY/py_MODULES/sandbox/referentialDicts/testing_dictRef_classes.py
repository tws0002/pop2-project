#!/usr/bin/python

class DictRef(object):
    def __init__(self, d, key):
        self.d = d
        self.key = key

    def value(self):
        return self.d[self.key].value()

class DictVal(object):
    def __init__(self, value):
        self._value = value

    def value(self):
        return self._value

d = {}
d.update(
    key1=DictVal(['val1', 'val2']),
    key2=DictRef(d, 'key1')
)
print d['key2'].value()
