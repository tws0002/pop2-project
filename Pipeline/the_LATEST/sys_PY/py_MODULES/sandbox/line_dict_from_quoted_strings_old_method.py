#!/usr/bin/python
# -*- coding: utf-8 -*-

# IMPORT STANDARD LIBRARIES
import re
import functools

CURRENT_LINE = ""


class LineGrabber(object):
    def __init__(self):
        super(LineGrabber, self).__init__()
        self.rules = []
        self.init_rules()
    # end __init__

    def match_line(self, reCompile, currentLine):
        reMatch = re.match(reCompile, currentLine)
        return reMatch
    # end match_line

    def init_rules(self):
        """
        Makes rules, currently for catching and idenifying relative paths
        """
        reCompile = r'"([^"]*)"'
        reCompile = r".+\"(?P<quoted>.+)\"."
        # reCompile = r".+"
        # reCompile = "asdf'"
        reCompile = re.compile(reCompile)
        # function = functools.partial(self.match_line, reCompile=reCompile, currentLine=CURRENT_LINE)
        function = lambda CURRENT_LINE: self.match_line(reCompile, CURRENT_LINE)
        rule = Rule()
        rule.add_rule(function, None)
        self.rules.append(rule)
    # end init_rules
# end LineGrabber


class Rule(object):
    def __init__(self, **kwargs):
        super(Rule, self).__init__()
        if kwargs is not None:
            self.rulebook = kwargs
    # end __init__

    def add_rule(self, condition, comparison):
        """
        Generic method to create simple conditional statements. Its intended
        use is to add
        """
        self.rulebook.update({condition: comparison})
    # end add_rules

    def eval_rules(self):
        """
        Activates dormant rules and either keeps or unloads them on comparison
        """
        for condition, comparison in self.rulebook.iteritems():
            if condition(CURRENT_LINE) != comparison:
                break
        else:
            return False  # only runs if no break occurredd
        return True  # some break occurred, therefore the eval must return False
# end Rule


def get_lines_from_quoted_string():
    """
    Gets a dictionary that represents every line that must be changed, with
    its information at the time it was read.
    """
    fileLocation = r"/home/selecaotwo/Desktop/basic_test.ma"
    lineGrabber = LineGrabber()
    with open(fileLocation, "r") as f:
        data = f.readlines()

    for line in data:
        # lineGrabber.currentLine = line
        global CURRENT_LINE
        CURRENT_LINE = line
        for rule in lineGrabber.rules:
            print rule.eval_rules()
# end get_lines_from_quoted_strings


if __name__ == "__main__":
    get_lines_from_quoted_string()
