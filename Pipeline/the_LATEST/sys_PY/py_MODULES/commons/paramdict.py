#!/usr/bin/python

class ParamDict(dict):
    def __getitem__(self, key):
        val = dict.__getitem__(self, key)
        return callable(val) and val(self) or val


def test_dict_basic():
    params = ParamDict({
        'a': 5,
        'b': lambda self: 2**self['a']
        })

    return params["b"]
# end test_dict_basic


if __name__ == "__main__":
    print(__doc__)
