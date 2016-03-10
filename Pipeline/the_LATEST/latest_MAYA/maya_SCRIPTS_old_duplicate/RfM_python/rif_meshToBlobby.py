# Jan 29 2013
import prman

class Rif(prman.Rif):
	flag = 0
	def __init__(self, ri, args):
		self.scale = float(args[0])
		self.kind  = int(args[1])  # set to 1 for a volume
		prman.Rif.__init__(self, ri)
					
	def PointsGeneralPolygons(self, nloops, nverts, verts, params):
		opcodes = []
		if self.kind == 1:  # we want a volume
			opcodes.append(8)
		numblobs = len(params['P'])/3
		for n in range(numblobs):
			opcodes.append(1001)
			opcodes.append(n * 16)
		opcodes.append(0)	# blending code
		opcodes.append(numblobs)# blend all blobs
		for n in range(numblobs):
			opcodes.append(n)# indices of the blobs to blend
		common = (self.scale,0,0,0,0,self.scale,0,0,0,0,self.scale,0)
		transforms = (self.scale,0,0,0,0,self.scale,0,0,0,0,self.scale,0)
		xyz = params['P']
		numxyz = len(xyz)
		for n in range(0, numxyz, 3):
			pos = (xyz[n], xyz[n+1], xyz[n+2])
			if n == 0:
				transforms = common + pos + (1,)
			else:
				transforms = transforms + common + pos + (1,)
		params = {}
		strs = ('',)
		self.m_ri.Blobby(numblobs,opcodes,transforms, strs, params)

