#!/usr/bin/python
# -*- coding: utf-8 -*-


class Person(object):
    def pay_bill():
        raise NotImplementedError

class Millionare(Person):
    def pay_bill():
        print "Here you go! Keep the change!"

class GradStudent(Person):
    pass

GradStudent()
