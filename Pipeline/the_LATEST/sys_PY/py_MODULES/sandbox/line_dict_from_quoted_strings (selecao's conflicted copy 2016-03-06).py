#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
All methods governing searching within files and lines of strings, determining
rules for how and in what way information should be retrieved, and, to a lesser
extent, defines how to process the retrieved information

.. important::
    Currently, the regex that gets lines in quotes ""s is VERY basic. It only
    returns arguments in quotes without said quotes. Luckily, I plan to use it
    to search and replace paths so it's OK to not have the original string that
    it came with

.. authornote::
    In a future build, it would be good to make a regex rule that gets not just
    the quoted element but whatever string came before and after it, so that
    way I can just replace strings within lines/dicts and join the strings
    together, instead of using .replace() or re.replace() to modify quote paths
"""
# IMPORT STANDARD LIBRARIES
import re
import functools


CURRENT_LINE = ""


class LineGrabber(object):
    def __init__(self):
        super(LineGrabber, self).__init__()
        self.rules = {}
        self.init_rules()
    # end __init__

    def match_line(self, reCompile, currentLine):
        reMatch = re.findall(reCompile, currentLine)
        # reMatch = [m.groupdict() for m in reCompile.finditer(currentLine)]  # used with list of dict with quoted keys
        return reMatch
    # end match_line

    def init_rules(self):
        """
        Makes rules, currently for catching and idenifying relative paths
        """
        # reCompile = r'"([^"]*)"'
        # reCompile = r"""(?P<before>.+)["|'](?P<quoted>.+)["|'](?P<after>.+)"""
        # reCompile = r"""['|"](?P<quoted>.*?)['|"]"""  # good
        # reCompile = r"""(?P<before>.+)?["|'](?P<quoted>.*?)["|']"""
        # reCompile = r"""["|'](?P<quoted>.*?)["|']"""  # list of dicts with replace key
        reCompile = r"""["|'](.*?)["|']"""
        # reCompile = r".+"
        # reCompile = "asdf'"
        reCompile = re.compile(reCompile)
        # function = functools.partial(self.match_line, reCompile=reCompile, currentLine=CURRENT_LINE)
        function = lambda CURRENT_LINE: self.match_line(reCompile, CURRENT_LINE)
        rule = Rule()
        rule.add_rule(function, None)
        self.rules.update({"quoteRule1": rule})
    # end init_rules

    def eval_rules(self, popAfterEval=False):
        """
        Activates dormant rules and either keeps or unloads them on comparison
        """
        for condition, comparison in self.rules["quoteRule1"].rulebook.iteritems():
            ruleOutput = condition(CURRENT_LINE)
            if ruleOutput != comparison:
                break
            if popAfterEval:
                self.rules["quoteRule1"].pop(condition, None)
        else:
            return False  # only runs if no break occurredd
        return ruleOutput  # some break occurred, therefore the eval must return False
    # end eval_rules
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
    global CURRENT_LINE
    with open(fileLocation, "r") as f:
        data = f.readlines()

    modifiedDictH = {}
    for index, line in enumerate(data):
        # lineGrabber.currentLine = line
        CURRENT_LINE = line
        checkRules = lineGrabber.eval_rules()
        if lineGrabber.eval_rules() is not False:
            modifiedDictH.update({index: checkRules})

    for line, replacements in modifiedDictH.iteritems():
        # print key, item.group("quoted")
        for replace in replacements:
            data[line] = data[line].replace(replace, 'asdfasfd', 1)  # first occurrence only. VERY IMPORTANT
# end get_lines_from_quoted_strings


if __name__ == "__main__":
    get_lines_from_quoted_string()
