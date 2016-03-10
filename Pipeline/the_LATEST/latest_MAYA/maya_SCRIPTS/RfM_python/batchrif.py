# batchrif.py
# Instanced by batchrender.BatchRender class. It 
# A re-written version of ribops.py
# Started: 22 Jan 2013
# Malcolm Kesson

import re, os, sys, prman, time, inspect, zipfile

class BatchRif(): 
	# Rifs that implement any of these methods will be applied to the zips/ribs
	# in the RMS "job" and "frames" directories. Used by self.isGeometryRif().
	geoMethods = ['TrimCurve','VArchiveRecord','VPAtmosphere',\
		'Blobby','Curves','Cylinder','Disk','GeneralPolygon',\
		'GeometricApproximation','Geometry', 'SubdivisionMesh',\
		'HierarchicalSubdivisionMesh','PointsGeneralPolygons',\
		'Hyperboloid','NuPatch','ObjectBegin','ObjectEnd',\
		'ObjectInstance','Paraboloid','Patch','PatchMesh',\
		'PointsPolygons','Polygon','Procedural','Torus',\
		'ReadArchive','SolidBegin','SolidEnd','Sphere','Volume','Points',]
	#-------------------------------------------------
	def __init__(self, logpath):
		self.logpath = logpath
		self.__log('log_rif.txt', '', 'w')
				
	#-------------------------------------------------
	# getRifsFromString [public]
	#-------------------------------------------------
	def getRifsFromString(self, text):
		text = text.strip("'")
		regx = re.compile(r'[;]')
		names = [ ]
		parts = regx.split(text)
		for part in parts:
			# Avoid empty strings
			if len(part) > 0:
				names.append(part)
		if len(names) > 0:
			return self.__getRifsFromList(names)
		
	#-------------------------------------------------
	# __getRifsFromList [private]
	#-------------------------------------------------
	def __getRifsFromList(self, rifnames):
		out = []
		ri = prman.Ri()
		out.append(ri)
		for name in rifnames:
			cls = self.__getClassFromStr(name.strip())
			if cls == None:
				continue
			rifClass = cls[0]
			if len(cls) == 1:
				rifInst = rifClass(ri)
			else:
				rifArgs = cls[1]
				rifArgs = rifArgs.strip('[]')
				regx = re.compile(r'[,]')
				parts = regx.split(rifArgs)
				args = []
				for part in parts:
					if len(part) > 0:
						if self.__isa_number(part):
							args.append(float(part))
						else:
							args.append(part)
				rifInst = rifClass(ri,args)
			out.append(rifInst)
		return out	
	#-------------------------------------------------
	# __getClassFromStr [private]
	#-------------------------------------------------
	def __getClassFromStr(self, mcStr):
		regx = re.compile(r'[()]')
		parts = mcStr.split('.',1)
		module = parts[0].strip()
		if len(parts) == 1:
			parts.append('Rif()')
		# Tokenize on '()' to extract any args
		tokens = regx.split(parts[1:][0])
		tokens = self.__removeEmptyStrs(tokens);
		cls = tokens[0].strip()
		argStr = ''
		if len(tokens) == 2:
			argStr = tokens[1]
		mcStr = module + '.' + cls
		parts = mcStr.split('.')
		try:
			m = __import__(module)
		except:
			print'%s' % ('-' * 70)
			print('Error: Cannot import module named "%s".' % module)
			print('It either does not exist or it has syntax errors.')
			print'%s' % ('-' * 70)
			return None
		for comp in parts[1:]:	
			m = getattr(m, comp)
		out = [m]
		argStr = argStr.strip()
		if len(argStr):
			out.append(argStr)
		return out
	#-------------------------------------------------
	# applyRifsToRibs [public]
	#-------------------------------------------------
	def applyRifsToRibs(self, rifs, ribs, format):
		if len(rifs) == 0 or len(ribs) == 0:
			return
		# Get the instance of Ri used by any of the Rifs. There can only 
		# be a single instance of the 'ri' variable and it must be "shared" 
		# by the rifs so we pick the first Rif and use it to get an
		# instance of 'm_ri'.
		ri = rifs[0].m_ri
		if format == 'ascii':
			ri.Option("rib", {"string asciistyle": "indented"})
		else:
			ri.Option("rib", {"string format": "binary"})
		prman.RifInit(rifs)
		for rib in ribs:
			parent = os.path.dirname(rib)
			name = os.path.basename(rib)
			if name == 'cutter_history' or name.startswith('cif'):
				continue
			tmpRib = os.path.join(parent, 'tmp_' + name)			
			ri.Begin(tmpRib)
			prman.ParseFile(rib)
			ri.End()
			os.remove(rib)
			os.rename(tmpRib,rib)
  		prman.RifInit([]) # will crash without this !!
		#msg = 'Filtered %d rib(s) using the following,\n' % len(ribs)
		
		msg = 'Applied:\n'
		for rif in rifs:
			name = str(rif.__class__)
			msg += '  %s\n' % name[8:len(name)-2]
		msg += 'to filter:\n'	
		for rib in ribs:
			msg += '  %s\n' % rib
		self.__log('log_rif.txt', msg, 'a')

	#-------------------------------------------------
	# applyRifsToZips [public]
	#-------------------------------------------------  
	def applyRifsToZips(self, rifs, zips, projpath):
		for zfile in zips:
			self.applyRifsToZip(rifs, zfile, projpath)
			
	#-------------------------------------------------
	# applyRifsToZip [public]
	#-------------------------------------------------			
	def applyRifsToZip(self, rifs, zfile, projpath):
		# Extract the ribs from the zip file
		zip_in = zipfile.ZipFile(zfile)
		ribs = []
		for rib_path in zip_in.namelist():
			# ex rib_path "renderman/sphere3/rib/job/pCubeShape1.job.rib"
			# ex projpath "/Users/mkesson/helper_apps/sphere/"
			zip_in.extract(rib_path, projpath)
			ribs.append(os.path.join(projpath, rib_path))
		self.applyRifsToRibs(rifs,ribs,'binary')

		# Re-zip the ribs
		tmp_zip_fullpath = os.path.join(os.path.dirname(zfile), 'tmp.zip')
		if os.path.exists(tmp_zip_fullpath):
			os.remove(tmp_zip_fullpath)
		tmp_zipfile = zipfile.ZipFile(tmp_zip_fullpath, mode='a')
		for rib in ribs:
			relative_path = os.path.relpath(rib, projpath)
			tmp_zipfile.write(rib, relative_path)
		tmp_zipfile.close()
		os.remove(zfile)
		os.rename(tmp_zip_fullpath,zfile)
		for rib in ribs:
			os.remove(rib)

	# Utility_____________________________________________	
	def __log(self, logname, logMsg, permission):
		f = open(os.path.join(self.logpath,logname), permission)
		if permission == 'w':
			localtime = time.asctime( time.localtime(time.time()) )
			f.write('Time %s.\n' % localtime)
		f.write(logMsg)
		f.close()		
				
	# Utility_____________________________________________	
	def __convertToWindows(linuxpath):
		pattern = re.compile(r"/")
		return pattern.sub(r'\\', linuxpath)
				
	# Utility_____________________________________________	
	def isGeometryRif(self, rif):
		members = inspect.getmembers(rif)
		for member in members:
			if member[0] in self.geoMethods and str(member[1]).startswith('<bound method'):
				return True
		return False
  
	# Utility_____________________________________________	
	def __removeEmptyStrs(self, inlist):
		def remove(strn): 
			return len(strn.strip())
		return filter(remove, inlist)
	
	# Utility_____________________________________________	
	def __isa_number(self, arg):
		try:
			float(arg)
			return True
		except ValueError:
			return False
