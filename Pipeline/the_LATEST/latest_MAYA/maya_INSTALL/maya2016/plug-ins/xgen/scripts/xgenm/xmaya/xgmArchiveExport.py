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
import maya.mel as mel
import time
import os
import xgenm as xg

class Timer:
	'''Simple Timer class to time the archive export.'''
	def __enter__(self):
		self.start= time.clock()
		return self
		
	def __exit__(self, *args):
		self.end = time.clock()
		self.interval = self.end - self.start

class Progress:
	'''Progress class to keep a global percentage and split it among recursive steps'''
	def __init__(self, start, end, steps, level="" ):
		self.start = start
		self.end = end
		self.steps = steps
		self.cur = 0
		self.level = level
		
	def split(self, steps):
		return Progress( self.progress(), self.progress()+(self.end-self.start)/self.steps, steps, self.level+" " )
		
	def progress(self, step=0):
		self.cur += step
		divider = self.steps*self.cur
		if divider == 0:
			return 0.0
		else:
			return self.start + (self.end-self.start)/divider


def fixPath( s ):
	return s.replace( "\\", "/" )

class ArchiveFile:
	def __init__(self, t, f, m, o, l, aOff=0 ):
		self._type = t
		self._file = f
		self._material = m
		self._obj = o
		self._lod = l
		self._archiveOffset = aOff

	def lodSuffixOffset( self ):
		if self._lod=="_med":
			return 1
		elif self._lod=="_lo":
			return 2
		else:
			return 0

	def archiveOffset( self ):
		return self._archiveOffset

class ArchiveFiles:
	'''Holds arrays of the generated files for a single archive maya scene.'''
	def __init__(self):
		self._files = [] 
		self._low = False
		self._med = False
		self._baseFilename = ""
		self._materialFilename = ""
	
	def quotify(self, n, s ):
		'''Surround the value with double quotes and add a name tag with equal sign at the start.'''
		if len(n)==0 and len(s)>0:
			return "\"" + s + "\""
		if len(s)>0:
			return " " + n + "=\"" + s + "\""
		else:
			return ""

	def makeRelativePath( self, s ):
		'''Turn the path into a relative path'''
		s = fixPath( s )
		# Replace with XGEN_ROOT environment variable if the base path matches
		basePaths = [ "${XGEN_ROOT}/", "~/xgen/", "${XGEN_LOCATION}presets/" ]
		for i in range(len(basePaths)):
			basePath = basePaths[i]
			if basePath!="":
				exBasePath = os.path.expanduser(basePath)
				exBasePath = os.path.expandvars(exBasePath)
				exBasePath = fixPath( exBasePath )
				exBasePathDotDot = ""

				# Keep the reference to ${XGEN_ROOT} because it doesn't map one to one with the XGen localRepo location.
				# Can't do the resolution directly with $PROJECT because the xgen data path isn't set when description are present in the scene
				if i==0:
					relativeBasePath = "${PROJECT}/xgen/"
				else:
					relativeBasePath = ""

				rIndex = exBasePath.rfind('/')
				if rIndex>1:
					exBasePathDotDot = exBasePath[0:rIndex]

				if s.startswith( exBasePath ):
					s = relativeBasePath + s[ len(exBasePath): ]
					break
				elif s.startswith( exBasePathDotDot ):
					s = relativeBasePath + "../" + s[ len(exBasePathDotDot): ]
					break

		return s

	def getFilesString( self, exts ):
		'''Get string representation of the archive files.'''
		index=0
		ret = "#ArchiveGroup 0" + \
			self.quotify("name",self._baseFilename) + \
			self.quotify("description","No description.") + \
			self.quotify("thumbnail",self.makeRelativePath(self._baseFilename + ".png")) + \
			self.quotify("materials",self.makeRelativePath(self._materialFilename)) + \
			" color=[1,0,0]\n"
		
		for f in self._files:
			archiveFile = self.makeRelativePath( f._file )

			if f._material!="":
				material = " material=" + f._material
			if f._obj!="":
				obj = " objects=" + f._obj

			# Insert the LOD suffix before the extension and frame token if it's present.
			extLen = 4
			for e in exts:
				if archiveFile.endswith( e ):
					extLen = len( e )
					break

			baseStr = fixPath( archiveFile[0:-extLen] )
			extStr = archiveFile[-extLen:]
			
			indexStr = str(index*10 + f.archiveOffset() + f.lodSuffixOffset() )
			ret += indexStr + " " + self.quotify("",baseStr + extStr) + material + obj + "\n"

		return ret
		
		
class xgmArchiveExport:
	'''
	Helper class to export all XGen Archives files from Maya scenes.
	This script assumes the given directory contains .mb that you wish to export as XGen Archives.
	It will create:
	1) LOD Geometry in .abc, mi.gz formats. 
	2) Materials in .ma format.
	3) Script to apply the archive preset to an existing description.
	'''
	def __init__( self ):
		'''xgmArchiveExport ctor'''
		self.progress = Progress( 0.0, 100.0, 1 )
		self.fileList = []
	
	def addArchiveFile( self, filetype, filename, material, obj, lod, archiveOffset ):
		self.curFiles._files.append( ArchiveFile( filetype, filename, material, obj, lod, archiveOffset ) )
	
	def splitProgress(self, steps):
		self.progress = self.progress.split( steps )
		
	def incProgress(self, steps=1):
		self.progress.progress(steps)
		
	def log(self, message):
		'''Log a string. Might add some timing prefix.'''
		
		f = self.progress.progress()
		percent = "%.2f" % f
		frontpad = 6-len(percent)
		for i in range(frontpad):
			percent = " " + percent
		print "[" + percent + "%] " + self.progress.level + message

	def fixNamespace(self, str):
		fixedNs = ""
		for s in str:
			if s.isalpha() or s.isdigit() or s == '_':
				fixedNs += s
			else:
				fixedNs += '_'
				
		return fixedNs

	def getSGsFromObj( self, obj ):
		'''Lists the shading groups applied to the object'''
		self.log( "getSGsFromObj " + obj )
		shadingEngines = []
		if cmds.objExists(obj) :
			shapes = cmds.listRelatives( obj, fullPath=True, shapes=True )
			if shapes:
				for shape in shapes:
					if cmds.objExists(shape) :
						dest = cmds.listSets( type=1, object=shape )
						if dest and len(dest):
							select = cmds.ls( sl=True )
							cmds.select( dest, r=True, ne=True )
							shapeSGs = cmds.ls( sl=True )
							shadingEngines = shadingEngines + shapeSGs
							if select == []:
								cmds.select( cl=True )
							else:
								cmds.select( select, r=True )
		return shadingEngines

	def filterFaceSelectionbyObjectName( self, s, name ):
		'''Face Selection Filtering function'''
		if s.startswith( name ): return True
		else: return False
		
	def duplicateShadingGroupFaces( self, shape, sg ):
		'''duplicate the original shape keeping only the face that had the given shading group.'''
		
		newShapeName = shape+sg
		newShapeName = cmds.duplicate( shape, name=newShapeName, returnRootsOnly=True, upstreamNodes=True )[0]
		self.log( "duplicate " + shape + " to " + newShapeName  )
		
		# Select all the faces a material is usingaw
		cmds.select( cl=True )
		cmds.select( sg, add=True )
	
		#cmds.hyperShade( objects=sg )
		selectedPoly = cmds.ls( sl=True )
	
		# Filter the faces to only work on the faces on the object we care
		newShapeFaceName = newShapeName + ".f"
		filteredPoly = [ s for s in selectedPoly if self.filterFaceSelectionbyObjectName( s, newShapeFaceName ) ]

		# if no faces are using the material, just delete the emtpy object we created.
		if filteredPoly == []:
			cmds.delete( newShapeName )
			return [shape]

		cmds.select( filteredPoly, r=True )
	
		# Invert Selection and Delete selected faces.
		# The new object should contain only the faces we want
		mel.eval("InvertSelection;\nDelete;")

		# Force a single material on the object. This also removes the per face material bindings.
		cmds.sets( newShapeName, e=True, forceElement=sg )
		self.log( "forceSingleMaterial " + newShapeName + " " + sg )
		return [newShapeName]

	def splitShapeByMaterials( self, obj ):
		'''Split an object in separated objects by ShadingGroup'''

		SGlist = self.getSGsFromObj( obj )
		self.log( "getSGsFromObj( " + obj + " ) returned " + str(SGlist) )
		
		if SGlist and len( SGlist ) > 1:
			newObjs = []
			for SG in SGlist:
				newObjs = newObjs + self.duplicateShadingGroupFaces(obj,SG)
			return newObjs
		else:
			return [obj]

	def polySplitByShadingGroups( self, objs):
		'''List all the visible objects and split them by shading groups'''
		lastProgress = self.progress
		self.splitProgress( len(objs) )
		self.log( "splitByShadingGroups " + str(objs) )
		newObjs = []
		for o in objs:
			newObjs = newObjs + self.splitShapeByMaterials( o )
			self.incProgress()
		self.progress = lastProgress
		
		return newObjs

	def openScene( self, filename ):
		'''Open scene'''
		self.log( "openScene " + filename )
		cmds.file( filename, f=True, options="v=0;", o=True )
	
	def saveSceneAs( self, filename ):
		'''Save a Scene with a new filename'''
		self.log( "saveSceneAs " + filename )
		cmds.file( rename=filename )
		cmds.file( f=True, save=True, options="v=0;" )
		
	def nestFilenameInDirectory( self, filename, directory ):
		splitFilename = os.path.split(filename)
		return fixPath( os.path.join( splitFilename[0], directory, splitFilename[1] ) )
		
	def tweakLodAppend( self, curFiles,  lod ):
		'''This will make the lo and med lod behave as hirez when on of them isn't available.'''
		ret = [lod]
		if lod=="":
			if not curFiles._med:
				ret.append( "_med" )
			if not curFiles._low:
				ret.append( "_lo" )
			
		return ret
			
	def abcExportAppendFile( self, abcFilename, material, obj, lod ):
		lodList = self.tweakLodAppend( self.curFiles, lod  )
		for l in lodList:
			self.addArchiveFile( "abc", abcFilename, material, obj, l, 0 )

	def abcExport( self, objs, filename, lod,  materialNS ):
		'''Export alembic archives'''
		filename = self.nestFilenameInDirectory( filename + lod, "abc" )
		abcFilename = filename + ".abc"
		self.log( "abcExport " + abcFilename )
		self.log( "abcExport objects " + str(objs) )
		cmds.select(clear=True)
		for obj in objs:
			shapes = cmds.listRelatives( obj, fullPath=True, shapes=True )
			if shapes:
				self.log( "abcExport select objects " + str(shapes) )
				cmds.select( shapes, add=True)

		jobString = "-selection -uvWrite -frameRange %f %f -worldSpace" % (self.startFrame,self.endFrame)

		jobString += " -file " + "\"" + abcFilename + "\"" 
		self.log( "abcExport " + jobString )
		cmds.AbcExport( j=jobString )
		
		if self.curFiles != None:
			for obj in objs:
				materials = self.getSGsFromObj( obj )
				longName = cmds.ls( obj, l=True )[0]
				longName.replace('|','/')
				if materials and len(materials)>0 :
					self.abcExportAppendFile( abcFilename, materialNS+materials[0], longName, lod )
		
	def archiveExport( self, objs, filename, lod ):
		'''Export archives in various formats'''
		
		lastProgress = self.progress
		self.splitProgress( 2 )

		# Namespace cannot contain illegal character, convert to '_'
		materialNS = self.fixNamespace(os.path.basename(filename)) + ":"
		
		self.log( "archiveExport alembic object: " + str(objs) )
		self.abcExport( objs, filename, lod, materialNS )
		self.incProgress()
		
		# Custom Renderer export callbacks
		# Passing a string reference to self
		# Avoid passing the arguments as stringis by putting them in self.invokArgs
		self.invokeArgs = [objs,filename,lod,materialNS]
		self.log( "archiveExport for callbacks" )
		xg.invokeCallbacks( "ArchiveExport", [str(id(self))] )
		self.log( "archiveExport for callbacks finished" )
		self.invokeArgs = None
		self.incProgress()

		self.progress = lastProgress

	def createMaterialReferences( self, sg ):
		'''Create an empty mesh and apply a material to it to force it to be exported by mentalray'''
		oldSel = cmds.ls(sl=True)
		cube = cmds.polyCube( w=1, h=1, d=1, sx=1, sy=1, sz=1, ax=[0,1,0], cuv=4, ch=0, name=sg+"_materialRef" )
		cmds.select( cube[0] + ".vtx[0:7]", r=True )
		mel.eval( "catchQuiet( polyMergeToCenter() );" )

		cmds.select( cube[0], r=True )
		cmds.sets( e=True, forceElement=sg );

		cmds.select( cube[0], r=True )
		cmds.delete( ch=True )

		if oldSel:
			cmds.select(oldSel,r=True)
		else:
			cmds.select(cl=True)
			
		return cube[0]

	def materialExport( self, objs, filename ):
		'''Export Shading Groups from a scene into a single maya ascii file.'''
		filename = self.nestFilenameInDirectory( filename, "materials" ) 
		
		materialFile = filename + ".ma"
		self.log( "materialExport " + materialFile )
		
		# Get the unique shading groups
		setSGs = set()
		for obj in objs:
			objSGs = self.getSGsFromObj( obj )
			setSGs = setSGs.union( set(objSGs) )
		
		# Convert to list
		SGs = list()
		for SG in setSGs:
			SGs.append( SG )
			
		# Create empty objects to reference the materials
		refs = []
		for SG in SGs:
			refs.append( self.createMaterialReferences(SG) )
			
		cmds.select( SGs, r=True, ne=True )
		cmds.select( refs, add=True )
		cmds.file( materialFile, force=True, options="v=0;", typ="mayaAscii", pr=True, es=True )
		
		if( self.curFiles ):
			self.curFiles._materialFilename = fixPath( materialFile )
	
	def polyReduce( self, objs, percent ):
		'''Apply poly reduce with a percentage'''
		lastProgress = self.progress
		self.splitProgress(len(objs))
		for obj in objs:
			
			# Check if the object has valid shapes
			bValidMesh = False 
			shapes = cmds.listRelatives( obj, fullPath=True, shapes=True )
			if shapes:
				bValidMesh = True 
				for shape in shapes:
					if cmds.nodeType(shape) != "mesh":
						bValidMesh = False
						break
				
			if bValidMesh:
				self.log( "polyReduce " + str(percent) + " " + obj )
				cmds.polyReduce( obj, ver=1, trm=0, p=float(percent), vct=0, tct=0, shp=0, 
					keepBorder=1, keepMapBorder=1, keepColorBorder=1, keepFaceGroupBorder=1, 
					keepHardEdge=1, keepCreaseEdge=1, keepBorderWeight=0.95, keepMapBorderWeight=0.5, 
					keepColorBorderWeight=0.5, keepFaceGroupBorderWeight=0.5, keepHardEdgeWeight=0.5,
					keepCreaseEdgeWeight=0.5, useVirtualSymmetry=0, symmetryTolerance=0.01, 
					sx=0, sy=1, sz=0, sw=0,
					preserveTopology=1, keepQuadsWeight=1, vertexMapName="",
					replaceOriginal=1, cachingReduce=1, ch=0 )
			else:
				self.log( "skipping polyReduce because it's not a mesh." + str(percent) + " " + obj )
			self.incProgress()
		self.progress = lastProgress

	def toggleLodSuffix( self, objs, lod, lodLo, lodMed ):
		if len(lod) == 0:
			return objs

		loNames = []
		medNames = []
		for obj in objs:
			if lod == "_lo":
				if cmds.objExists(obj+lodLo):
					loNames.append(obj+lodLo)
			elif lod == "_med":
				if cmds.objExists(obj+lodLo):
					medNames.append(obj+lodMed)

		# Return only the right LOD level objects
		if lod == "_lo":
			return loNames
		elif lod == "_med":
			return medNames

		return []

	def fixNodeToShapeParent(self, objs):
		self.log( "fixNodeToShapeParent objs - " + str(objs) )
		if objs == None or len(objs) == 0:
			# select all nodes
			cmds.select(allDagObjects=True)
			objs = cmds.ls(sl=True)
		shapeParentObj = []
		for obj in objs:
			s = cmds.listRelatives( obj, fullPath=True, shapes=True )
			if s:
				shapeParentObj.append(obj)
			descNodes = cmds.listRelatives( obj, allDescendents=True, fullPath=True, type="transform" )
			if descNodes:
				for n in descNodes:
					s = cmds.listRelatives( n, allDescendents=True, fullPath=True, shapes=True )
					if s:
						shapeParentObj.append(n)
		self.log( "fixNodeToShapeParent shapeParentObj - " + str(shapeParentObj) )
		return shapeParentObj

	def processScene( self, oriSceneFile, baseSceneFile, objs, lod, lodMode, lodLo, lodMed ):
		'''Process a single scene LOD level.'''
		lastProgress = self.progress
		numSplit = 3

		if lod=="": 
			numSplit += 1 # for material export
		self.log( "processing scene " + baseSceneFile + lod )
		self.splitProgress( numSplit )
		
		# Open Scene
		self.openScene( oriSceneFile )
		objs = self.fixNodeToShapeParent(objs)
		if objs == None or len(objs) == 0:
			self.log( "No object specified or found in the scene" )
			return objs
		matObjs = objs # The material export uses the original list to allow the export of all materials when manual LOD materials are diffrent from the main version.
		self.incProgress()#1
		self.log( "processScene 1 " + str(objs) )

		# polyReduce
		if lodMode==1:
			if lod=="_lo":
				self.polyReduce( objs, lodLo )
			elif lod=="_med":
				self.polyReduce( objs, lodMed )

		# lod suffix
		elif lodMode==2:
			objs = self.toggleLodSuffix( objs, lod, lodLo, lodMed )

		# Split by shading group
		self.log( "processScene 2 " + str(objs) )
		objs = self.polySplitByShadingGroups( objs )
		self.incProgress()#2
		self.log( "processScene " + str(objs) )

		# Export the full rez archives
		self.log( "before archiveExport " + str(objs) )
		self.archiveExport( objs, baseSceneFile, lod )
		self.incProgress()#3
		
		# Export the materials
		if lod=="":
			self.log( "before materialExport " + str(matObjs))
			self.materialExport( matObjs, baseSceneFile )
			self.incProgress()#4

		self.progress = lastProgress
		return objs

	def processFile( self, f, objs, lodMode, lodLo, lodMed, startFrame, endFrame ):
		'''Process a single file.'''
		lastProgress = self.progress
		self.log( "processing file " + f )
	
		oriSceneFile = f
		if len(self.destName)==0:
			baseSceneFile = os.path.join( self.destDir, os.path.basename( oriSceneFile[0:-3] ) )
		else:
			baseSceneFile = os.path.join( self.destDir, self.destName )
			
		
		# Count the number of sub steps
		validLodMed = False
		validLodLo = False
		if lodMode==1:
			validLodMed = lodMed>0.0
			validLodLo = lodLo>0.0
		elif lodMode==2:
			validLodMed = len(lodMed)>0
			validLodLo = len(lodLo)>0
		self.splitProgress( 1 + int(validLodMed) + int( validLodLo) )
		
		self.curFiles = ArchiveFiles()
		self.curFiles._baseFilename = os.path.basename(baseSceneFile)
		self.curFiles._med = validLodMed
		self.curFiles._low = validLodLo
		self.startFrame = startFrame
		self.endFrame = endFrame

		origObjs = objs
		# Process the hi rez scene. It will export the materials in that pass.
		objs = self.processScene( oriSceneFile, baseSceneFile, objs, "", lodMode, lodLo, lodMed )
		self.incProgress()#1
		
		# Build an entry for the Archive File List
	
		# Process the 2 other LOD levels if needed
		if validLodMed:
			self.processScene( oriSceneFile, baseSceneFile, origObjs, "_med", lodMode, lodLo, lodMed )
			self.incProgress()#2
			
		if validLodLo:
			self.processScene( oriSceneFile, baseSceneFile, origObjs, "_lo", lodMode, lodLo, lodMed )
			self.incProgress()#3
		
		self.fileList.append( self.curFiles )
		self.progress = lastProgress
		
	def writeFilesString( self, dirLoc ):
		'''Write .xarc text files with paths to the created archives'''
		
		for f in self.fileList:
			fileListString = f.getFilesString(self.archiveLODBeforeExt) + "\n"
			with open( dirLoc + os.sep + f._baseFilename +".xarc", "w" ) as fp:
				fp.write( fileListString )
		
	def makeDir( self, dirLoc, subDir ):
		d = os.path.join(dirLoc,subDir)
		if not os.path.isdir( d ):
			os.makedirs( d )
			
	def makeDirs( self, dirLoc, subDirs ):
		for s in subDirs:
			self.makeDir( dirLoc, s )
		
	def processDir( self, destName, destDir, sourceFiles, objects, lodMode, lodLo, lodMed, startFrame, endFrame ):
		'''Process a directory.'''

		retCode = 0
		lastProgress = self.progress
		self.destDir = destDir
		self.destName = destName

		# Custom Renderer export callbacks
		# Passing a string reference to self
		# This callback must:
		# 1) append to self.archiveDirs the directories to be created before export
		self.archiveDirs = ["materials","abc"]
		self.archiveLODBeforeExt = []
		xg.invokeCallbacks( "ArchiveExportInfo", [str(id(self))] )

		try:
			with Timer() as t:
				'''Process a single file.'''
				self.log( "creating sub directories" + destDir )
				self.makeDirs( self.destDir, self.archiveDirs )
				if len(sourceFiles) > 0:
					self.splitProgress( len(sourceFiles) )
					for f in sourceFiles:
						self.processFile( f, objects, lodMode, lodLo, lodMed, startFrame, endFrame )
						self.incProgress()
				
					self.writeFilesString( destDir )
				else:
					self.log( "No maya scene files to process." )
		except Exception as e:
			print str(e)
			retCode = 1
		finally:
			self.log( "done in %.03f sec "%t.interval + destDir  )
		
		self.progress = lastProgress
		
		
		return retCode

