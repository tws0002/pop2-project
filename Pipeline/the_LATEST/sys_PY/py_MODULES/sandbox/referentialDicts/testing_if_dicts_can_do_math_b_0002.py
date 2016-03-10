#!/usr/bin/python


class DictRef(dict):
    def __init__(self, d, *args):
        self.d = d
        print self.d
        self.key = args[0]
        if len(args) > 1:
            for arg in args[1:]:
                self.key = self.key
                dict.__getitem__(self, self.key)
                # self.key = self.__getitem__(self.key[arg])
    # end __init__
# end DictRef

d = {}
d.update({
    "key1": {"value": 8},
    "key2": DictRef(d, 'key1', 'value')
})
