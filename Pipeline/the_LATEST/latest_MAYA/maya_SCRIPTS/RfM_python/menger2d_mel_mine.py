# menger2d_mel.py

# from menger2d import Menger2D

# IMPORT STANDARD LIBRARIES
import math


class Menger2D_Mel(Menger2D):
	def __init__(self, rect, depth, path):
		Menger2D.__init__(self,rect,depth)
		self.path = path
		
	def makePolys(self):
		"""given the min and max coordinats of a rectangle
		   this method outputs a mel command to draw a
		   polygon"""
		f = open(self.path, 'w')
		#   x    y    z    X    Y    Z
		# [0.0, 0.0, 0.0, 0.3, 0.0, 1.0]
		for rect in self.data:
			x,y,z,X,Y,Z = rect
			# redefine y, for fun
			w = rect[3] - rect[0]
			v0 = x,y,z
			v1 = w + x,y,z		
			v2 = w + x,y,Z	
			v3 = x,y,Z
			f.write('polyCreateFacet -p %f %f %f -p %f %f %f -p %f %f %f -p %f %f %f;\n' % 
				(v0[0],v0[1],v0[2],  v1[0],v1[1],v1[2],   v2[0],v2[1],v2[2],   v3[0],v3[1],v3[2]))
		f.close()
		
		
if __name__ == '__main__':
	menger = Menger2D_Mel( [0.0, 0.0, 0.0, 1.0, 0.0, 1.0], 4 , '/home/ckenne24/menger.mel')
	menger.makePolys()

