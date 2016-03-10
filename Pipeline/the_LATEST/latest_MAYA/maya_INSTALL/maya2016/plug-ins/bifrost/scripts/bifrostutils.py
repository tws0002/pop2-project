import os
import os.path
import subprocess

def addToSysPath( path ):
    import sys
    cleanpath = os.path.abspath(path)
    if cleanpath not in [os.path.abspath(p) for p in sys.path]:
        sys.path.insert(0, cleanpath)
        print "addToSysPath: ", cleanpath

def execAndOutput(args):
    import os
    import os.path
    import tempfile
    temp = os.path.join(tempfile.gettempdir(), "p4cmd.log")    
    cmd = " ".join(args)
    #print "cmd to execute", cmd
    os.system(cmd + " > " + temp )
    ff = open(temp, "r")
    lines = ff.readlines()
    ff.close()
    return lines

def checkP4Env():
    output = execAndOutput(['p4', 'set'])
    env = {}
    for line in output:
        pos = line.find('=')
        key = line[0:pos]
        value = line[pos+1:]
        env[key] = value
    return 'P4CLIENT' in env and 'P4USER' in env and 'P4PORT' in env

def p4Cmd(cmd, path):
    if not checkP4Env():
        print "p4 environment is not set (P4CLIENT, P4USER, P4PORT)"
        return False
    
    retcode = subprocess.call(["p4", cmd, path], shell=True)
    if retcode != 0:
        print cmd, path, "... FAILED!"
    else:
        print cmd, path
    return cmd == 0

def extractDepotPath(path):
    lines = execAndOutput(["p4", "files", path])
    depotpath, filepath = os.path.split(lines[0])
    return depotpath

def getP4FileList(path):
    def getFileFromP4FilesEntry(line):
        items = line.split("#")        
        filename = ""
        if not items[1].find("delete") != -1:
            depotPath = items[0]
            filename = os.path.split(depotPath)[1]
        return filename

    output = execAndOutput(["p4", "files", path + "/*"])
    lines = output

    filelist = []
    for l in lines:
        entry = getFileFromP4FilesEntry(l)
        if entry:
            filelist.append(entry)
    return filelist

def p4Checkout(path):
    return p4Cmd("edit", path)    

def p4Delete(path):
    return p4Cmd("delete", path)

def p4Add(path):
    return p4Cmd("add", path)
# Copyright (C) 1997-2014 Autodesk, Inc., and/or its licensors.
# All rights reserved.
#
# The coded instructions, statements, computer programs, and/or related
# material (collectively the "Data") in these files contain unpublished
# information proprietary to Autodesk, Inc. ("Autodesk") and/or its licensors,
# which is protected by U.S. and Canadian federal copyright law and by
# international treaties.
#
# The Data is provided for use exclusively by You. You have the right to use,
# modify, and incorporate this Data into other products for purposes authorized 
# by the Autodesk software license agreement, without fee.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND. AUTODESK
# DOES NOT MAKE AND HEREBY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTIES
# INCLUDING, BUT NOT LIMITED TO, THE WARRANTIES OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, OR ARISING FROM A COURSE 
# OF DEALING, USAGE, OR TRADE PRACTICE. IN NO EVENT WILL AUTODESK AND/OR ITS
# LICENSORS BE LIABLE FOR ANY LOST REVENUES, DATA, OR PROFITS, OR SPECIAL,
# DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES, EVEN IF AUTODESK AND/OR ITS
# LICENSORS HAS BEEN ADVISED OF THE POSSIBILITY OR PROBABILITY OF SUCH DAMAGES.

