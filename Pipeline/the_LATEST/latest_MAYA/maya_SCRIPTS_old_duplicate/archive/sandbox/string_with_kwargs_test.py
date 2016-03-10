from string import Formatter

class UnseenFormatter(Formatter):
    def __init__(self):
        Formatter.__init__(self)

    def get_value(self, key, args, kwds):
        if isinstance(key, str):
            try:
                return kwds[key]
            except KeyError:
                return key
        else:
            Formatter.get_value(key, args, kwds)

string = "{number_of_sheep} sheep {has} run away"
other_dict = {'number_of_sheep' : 1}

fmt = UnseenFormatter()
print fmt.format(string, **other_dict)