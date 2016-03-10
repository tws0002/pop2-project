
# batchdatabase.py
# See also batchRenderRI.mel, batchrender.py and batchrif.py
# The BatchDataBase class is the base class from which the 
# batchrender.BatchRender class is derived. BatchDataBase localizes the
# methods that query the RMS directory structure in order to obtain a
# list of ribs and/or rib-in-.zip files that will be rif'd by the helper
# class batchrif.BatchRif.
#
# Started: 28 Jan 2013
# Edited: 12 Mar 2013, 27 Mar 2014
# Edited: 15 Aug 2014 - RMS19/RIS ouputs .xml files that are now ignored.
# Malcolm Kesson
import re, os, sys

class BatchDataBase():
	def __init__(self, scene, project, begin, end, layer):
		if scene.endswith('.ma') or scene.endswith('.mb'):
			scene = scene[:-3]
		self.database = {'rootribs' : [], 'geomribs' : [], 'finalribs': [],
			  			 'rmanribs' : [], 'zippedribs'   : [], 'rlf': [], 
						 'projpath': project,  'scenename' : scene,
						 'begin' : int(begin), 'end' : int(end) }
		# First the ribs and/or zips in each of the numbered directories 
		# are added to the database.
		pattern_final = re.compile(r"_Final") 	# ex. "perspShape_Final.0010.rib"
		pattern_rman = re.compile(r"rman")		# ex. "rmanDeepShadowPass.0010.rib
  
		ribdir_path = os.path.join(project,'renderman', scene,'rib')
		framesdir_names = os.listdir(ribdir_path)
		
		for framedir in framesdir_names:
			if len(framedir) != 4:
				continue
			frame = int(framedir)
			if frame >= int(begin) and frame <= int(end):
				# In the case of the default layer the root ribs will be "0001.rib", 
				# otherwise, "0001_prman_deepmapshadows.rib". However, if there is MORE 
				# than one layer and the master layer is selected we get a name such as 
				# "0003_masterLayer.rib".
				if layer != 'defaultRenderLayer':
					rootname = framedir + '_' + layer + '.rib'
				else:
					rootname = framedir + '.rib'
				
				rootrib = os.path.join(ribdir_path, framedir, rootname)
				if os.path.exists(rootrib) == False and layer == 'defaultRenderLayer':
					rootname = framedir + '_masterLayer.rib'
					rootrib = os.path.join(ribdir_path, framedir, rootname)
				framedir_path = os.path.join(ribdir_path, framedir)
				for filename in os.listdir(framedir_path):
					# RIS ouputs .xml files - we must ignore them
					if filename.endswith('.xml'):
						continue
					filepath = os.path.join(framedir_path,filename)
					if filename.endswith('.zip'):
						if os.path.getsize(filepath) > 0:
							self.database['zippedribs'].append(filepath)	
					elif filename.endswith('.rlf'):
						self.database['rlf'].append(filepath)
					elif os.path.join(framedir_path,filename) == rootrib:
						self.database['rootribs'].append(filepath)
					elif pattern_final.search(filename, 1):
						self.database['finalribs'].append(filepath)
					elif pattern_rman.search(filename, 0):
						self.database['rmanribs'].append(filepath)
					else:
						self.database['geomribs'].append(filepath)
		# Finally, the ribs and/or zips in the "job" directory are added
		# to the database.
		jobDirPath = os.path.join(project,'renderman', scene,'rib','job')
		jobribs = os.listdir(jobDirPath)
		for filename in jobribs:
			if filename.endswith('.zip'):
				fullpath = os.path.join(jobDirPath,filename)
				if os.path.getsize(fullpath) > 0:
					self.database['zippedribs'].append(fullpath)
				else:
					print 'not adding ' + fullpath
			elif filename.endswith('.rlf'):
				self.database['rlf'].append(os.path.join(jobDirPath,filename))
			elif filename.endswith('.rib'):
				self.database['geomribs'].append(os.path.join(jobDirPath,filename))
