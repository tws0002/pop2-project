
# batchrender.py
# See also batchRenderRi.mel, batchdatabase.py and batchrif.py
# The base class, BatchDataBase, querries the RMS directory for the current
# project and populates the following database with lists of files and a few
# individual values such as the start and ending frame numbers.
#
# 		self.database = {'rootribs' : [], 'geomribs'  : [], 'finalribs': [],
#			  			 'rmanribs' : [], 'zippedribs': [], 'rlf': [], 
#						 'projpath': project,  'scenename' : scene,
#						 'begin' : int(begin), 'end' : int(end) }
#
# An instance of the BatchRif class returns instances of the rifs the user 
# wishes to apply. They are divided into two categores, those that should be 
# applied to archived geometry ribs and those to be applied to XXX_Final ribs. 
# The actual rif'ing is done by,
#		BatchRif.applyRifsToRibs() and
#		BatchRif.applyRifsToZips()
# 22 Jan 2013
# Malcolm Kesson

import os, time, subprocess, sys
from batchdatabase import BatchDataBase
from batchrif import BatchRif

def main():
	args = sys.argv[1:]
	scene = args[0]     # remove .ma or .mb
	project = args[1]   # full path to project
	begin = args[2]     # start frame
	end = args[3]       # end frame
	layer = args[4]     # render layer, example, "defaultRenderLayer"
	immediate = args[5]
	rifstr = args[6]
	br = BatchRender(scene,project,begin,end,layer,immediate,rifstr)
	
class BatchRender(BatchDataBase):
	DEFAULT_BATCH_NAME = 'batchrender'
	#-------------------------------------------------
	# Constructor
	#-------------------------------------------------
	def __init__(self, scene,project,begin,end,layer,immediate,rifstr):
		BatchDataBase.__init__(self, scene,project,begin,end,layer)

		# Get an instance of the rif handling class
		logpath = project
		rifjob = BatchRif(logpath)
		if rifstr != '':
			rifs = rifjob.getRifsFromString(rifstr)
			rifs = rifs[1:]  # Ignore the first item
			geomRifs = []
			otherRifs = []
			for rif in rifs:
				if rifjob.isGeometryRif(rif):
					geomRifs.append(rif)
				else:
					otherRifs.append(rif)
			# Static geometry is archived in the shared 'job' directory.
			if len(geomRifs) > 0:
				rifjob.applyRifsToRibs(geomRifs, self.database['geomribs'], 'ascii')
				rifjob.applyRifsToRibs(geomRifs, self.database['rmanribs'], 'ascii')
				# Format for rib-in-.zip will be automatically set to 'binary'
				rifjob.applyRifsToZips(geomRifs, self.database['zippedribs'], self.database['projpath'])
			rifjob.applyRifsToRibs(rifs, self.database['finalribs'], 'ascii')
			
		self.rootribs = self.database['rootribs']
		scriptpath = self.makeBatchRenderScript()
		doRender = int(immediate)
		if doRender and len(self.rootribs) > 0:
			self.runBatchRenderScript(scriptpath)
		
	#-------------------------------------------------
	# makeBatchRenderScript
	#-------------------------------------------------
	def makeBatchRenderScript(self):
		scriptname = BatchRender.DEFAULT_BATCH_NAME
		if os.name == "nt":
			scriptname += '.bat'
		batchpath = os.path.join(self.database['projpath'], scriptname)
		f = open(batchpath, 'w')
		if os.name == "nt":
			f.write("unset LD_LIBRARY_PATH\n")
			f.write("SET\n")
		if len(self.database['projpath']) > 0:
			rootdir = self.database['projpath']
			if os.name == "nt":
				rootdir = convertToWindows(self.project)
			f.write("cd " + rootdir + "\n")
		for rib in self.database['rootribs']:
			if os.name == "nt":
				rib = convertToWindows(rib)
			#f.write("unset LD_LIBRARY_PATH\n")
			# The next line may be required on linux - needs testing
			#f.write('export RMANTREE=/opt/pixar/RenderManProServer-18.0\n')
			f.write('prman -t:all ' + rib + "\n")
		f.close()
		return batchpath

	#-------------------------------------------------
	# runBatchRenderScript
	#-------------------------------------------------
	def runBatchRenderScript(self, fullpath):
		if os.name == "posix":
			os.chmod(fullpath, 0777)
			if sys.platform == 'darwin': # MacOSX
				args = ['open', fullpath]
			else:	# linux
				args = ['sh', fullpath]
			subprocess.Popen(args,stdout=subprocess.PIPE)
		else:	# windows
			args = ['start', fullpath]
			subprocess.Popen(args,stdout=subprocess.PIPE)

	def log(self, logname, logMsg):
		f = open(os.path.join(self.project, logname), 'w')
		localtime = time.asctime( time.localtime(time.time()) )
		f.write('Time %s.\n' % localtime)
		f.write(logMsg)
		f.close()			
		
	def print_database(self):
		for rib in self.database['rootribs']:
			print '--------------rootribs------------'
			print rib
		print '--------------geomribs------------'
		for rib in self.database['geomribs']:
			print rib
		print '--------------finalribs------------'
		for rib in self.database['finalribs']:
			print rib
		print '--------------rmanribs------------'
		for rib in self.database['rmanribs']:
			print rib
		print '--------------zippedribs------------'
		for rib in self.database['zippedribs']:
			print rib
		print '--------------rlf------------'
		for rib in self.database['rlf']:
			print rib
			
if __name__ == "__main__":
	batch = BatchRender('first.mb',
						'/Users/mkesson/RMS4/',
						1,1,
						'defaultRenderLayer',
						1,'rif_it')
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
