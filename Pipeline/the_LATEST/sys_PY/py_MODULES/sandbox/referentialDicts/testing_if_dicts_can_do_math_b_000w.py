#!/usr/bin/python


class DictRef(dict):
    def __init__(self, d, *args):
        self.d = d
        self.key = args[0]
        if len(args) > 1:
            for arg in args[1:]:
                self.key = self.key
                # self.key = self.__getitem__(self.key[arg])
    # end __init__
# end DictRef

d = {}
d.update({
    'key1': ['val1','val2'],
    'key2': DictRef(d, 'key1')
})

print d["key2"].key

dictionary = {"key": 8*8}
print dictionary["key"]


dictionary = {}
dictionary.update({
    "key1": {"value": 8},
    "key2": DictRef(d, 'key1', 'value')
})
print dictionary
