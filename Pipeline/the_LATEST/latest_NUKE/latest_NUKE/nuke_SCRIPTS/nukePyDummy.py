# Copyright (c) 2010 rise|fx GmbH.

#===============================================================================
# @author: Sebastian Elsner
# @comapny: rise|fx
# @version: 0.1
#===============================================================================

import inspect
import re
import os

import nuke

MODULE_DIR="/usr/bin/python2.7"

MODULE_PATH=os.path.join(MODULE_DIR,"nuke.py")

INDENT=0

moduleContents=""

def writeDefinition(*args):
    """Updates the moduleContent output string with the next line"""
    
    global moduleContents
    if INDENT:
        moduleContents += ' '*INDENT
    for arg in args:
        moduleContents +=str(arg)

def indent():
    """Increment indentation level"""
    
    global INDENT
    INDENT += 4

def dedent():
    """Decrement indentation level"""
    
    global INDENT
    INDENT -= 4
 
    
def getMemberInfo(member,isBuiltIn=False,isClassMember=True):
    """Gets the arguments for the given member"""
    
    if not isBuiltIn:
        try:
            arginfo = inspect.getargspec(member)
        except:
            return
        
        args = arginfo[0]

    else:
        docstr = member.__doc__
        args = ''
        
        if docstr:
            items = docstr.split('\n')
            if items:
                func_descr = items[0]
                s = func_descr.replace(member.__name__,'')
                idx1 = s.find('(')
                idx2 = s.find(')',idx1)
                if idx1 != -1 and idx2 != -1 and (idx2>idx1+1):
                    args = s[idx1+1:idx2]
                    
    if isinstance(args,str):
        args= args.replace(".", "").replace("[","").replace("]","").replace(")","").replace("(","")
        args=re.sub(".+ .+","",args)
        args=re.sub("^\d+$","",args)
    if isinstance(args,list):
        args=",".join(args)
    if isinstance(args,int):
        print args

    if isClassMember:
        if len(args):
            selfRef="self,"
        else:
            selfRef="self"
    else:
        selfRef=""
        
    writeDefinition('def %s(%s%s):\n' % (member.__name__,selfRef,args))
    indent()
    writeDefinition(r'"""%s"""'%member.__doc__ + "\n")
    writeDefinition('pass\n')
    dedent()
    writeDefinition('\n\n')

def cleanArg(item):
    if item == "...":
        return False
    else:
        return True
    
def getClassInfo(_class):
    
    parentClassName = inspect.getclasstree([_class])[0][0].__name__
    
    writeDefinition('class %s(%s):\n' %(_class.__name__,parentClassName))
    writeDefinition('\n')

    indent()

    for memberName in _class.__dict__:
        member = getattr(_class, memberName)
        if inspect.isbuiltin(member):
            getMemberInfo(member,isBuiltIn=True)
            continue
        if inspect.ismethod(member):
            getMemberInfo(member)
            continue
        if inspect.isfunction(member):
            getMemberInfo(member)
            continue
        if inspect.isroutine(member):
            getMemberInfo(member,isBuiltIn=True)
            continue
        if inspect.istraceback(member):
            getMemberInfo(member)
            continue
        if inspect.isframe(member):
            getMemberInfo(member)
            continue
        if inspect.iscode(member):
            getMemberInfo(member)
            continue
        if inspect.ismethoddescriptor(member):
            getMemberInfo(member)
            continue
        if inspect.isdatadescriptor(member): 
            getMemberInfo(member)
            continue
        if inspect.isgetsetdescriptor(member):
            getMemberInfo(member)
            continue
        if inspect.ismemberdescriptor(member):
            getMemberInfo(member)
        
    dedent()

if __name__ == "__main__":
    
    for name in dir(nuke):
        obj = getattr(nuke, name)
        if inspect.isclass(obj):
            getClassInfo(obj)
        elif (inspect.ismethod(obj) or inspect.isfunction(obj)):
            getMemberInfo(obj,isClassMember=False)
        elif inspect.isbuiltin(obj):
            getMemberInfo(obj,isBuiltIn=True,isClassMember=False)
    
    pyFile = open(MODULE_PATH,"w")
    pyFile.write(moduleContents)
    pyFile.close()
    
    
