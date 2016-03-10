# Copyright (C) 1997-2013 Autodesk, Inc., and/or its licensors.
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

import maya.cmds as cmds
import maya.standalone as ms
import sys
import os.path

import xgenm.xmaya.xgmArchiveExport

def parseArgs( argc, argv ):
	destName=""
	destDir=""
	sourceFiles=[]
	lodMode=0
	lodLo=0.0
	lodMed=0.0
	startFrame=0.0
	endFrame=0.0
	scriptPaths = []
	loadPlugins = []

	a = 1
	if( argc > a ):
		lodMode = int( argv[a] )
	a+=1
	if( argc > a ):
		if lodMode==1:
			lodLo = float( argv[a] )
		elif lodMode==2:
			lodLo = str( argv[a] )
	a+=1
	if( argc > a ):
		if lodMode==1:
			lodMed = float( argv[a] )
		elif lodMode==2:
			lodMed = str( argv[a] )
	a+=1
	if( argc > a ):
		startFrame= float( argv[a] )
	a+=1
	if( argc > a ):
		endFrame= float( argv[a] )
	a+=1
	
	args = ""
	for i in range( a, argc ):
		args+=argv[i]+" "
	
	# Parse the remaning arguments and extract the path from within the square brackets.
	mode = 0
	curStr=""
	dictArgs={}
	curArg=""
	for i in range(len(args)):
		x = args[i]
		if mode==0:
			if x=='\'':
				mode=1
			elif x=='-':
				curArg=""
				mode=2
		elif mode==1:
			if x=='\'':
				dictArgs[curArg].append(curStr)
				curStr=""
				mode=0
			else:
				curStr+=x
		elif mode==2:
			if x==' ':
				dictArgs[curArg]=[]
				mode=0
			else:
				curArg+=x
	
	# First path is the dest dir... and all the rest are the maya scenes.
	if len( dictArgs ) < 3:
		return ( False, destName, destDir, sourceFiles, lodMode, lodLo, lodMed, startFrame, endFrame, [], [] )

	destName = dictArgs["destName"][0]
	destDir = dictArgs["destDir"][0]
	sourceFiles = dictArgs["sourceFiles"]
	if "objects" in dictArgs:
		objects = dictArgs["objects"]
	else:
		objects = []
	scriptPaths = dictArgs["scriptPaths"]
	loadPlugins = dictArgs["loadPlugins"]

	# All paths should exist.
	allExist = True
	if not os.path.exists( destDir ):
		allExist = False

	for p in sourceFiles:
		if not os.path.exists( p ):
			allExist = False
			break


	return ( allExist, destName, destDir, sourceFiles, objects, lodMode, lodLo, lodMed, startFrame, endFrame, scriptPaths, loadPlugins )

def exportWithoutStandalone(loadPlugins, destName, destDir, sourceFiles, objects, lodMode, lodLo, lodMed, startFrame, endFrame):
	# Load plugins
	for p in loadPlugins:
		if cmds.pluginInfo(p, query=True, loaded=True):
			continue
		cmds.loadPlugin(p)

	# Run xgmArchiveExport.processDir()
	print( "hlp = xgenm.xmaya.xgmArchiveExport.xgmArchiveExport()" )
	hlp = xgenm.xmaya.xgmArchiveExport.xgmArchiveExport()
	print( "hlp.processDir( \'%s\', \'%s\', %s, %s, %d, \'%s\', \'%s\', %f, %f )" % ( destName, str(destDir), str(sourceFiles), str(objects), lodMode, lodLo, lodMed, startFrame, endFrame ) )
	ret = hlp.processDir( destName, destDir, sourceFiles, objects, lodMode, lodLo, lodMed, startFrame, endFrame )

	return ret

def main( argc, argv ):
	# Parse the args
	(validArgs,destName,destDir,sourceFiles,objects,lodMode,lodLo,lodMed,startFrame,endFrame,scriptPaths,loadPlugins) = parseArgs( argc, argv )
	if validArgs==False:
		print "destDir doesn't exists."
		return 1

	# Register script paths
	for p in scriptPaths:
		sys.path.append( p )

	# Start maya standalone
	ms.initialize( name='python' )

	# Load plugins
	for p in loadPlugins:
		cmds.loadPlugin(p)

	# Run xgmArchiveExport.processDir()
	print( "hlp = xgenm.xmaya.xgmArchiveExport.xgmArchiveExport()" )
	hlp = xgenm.xmaya.xgmArchiveExport.xgmArchiveExport()
	print( "hlp.processDir( \'%s\', \'%s\', %s, %s, %d, \'%s\', \'%s\', %f, %f )" % ( destName, destDir, sourceFiles, objects, lodMode, lodLo, lodMed, startFrame, endFrame ) )
	ret = hlp.processDir( destName, destDir, sourceFiles, objects, lodMode, lodLo, lodMed, startFrame, endFrame )

	ms.uninitialize( )

	return ret

if __name__ == "__main__":
	sys.exit( main( len(sys.argv), sys.argv ) )

