# menger3d.py
# Implements a recursive subdivision of a cube into 27 sub
# cubes - three "layers" each with nine cubes. The indices
# in the "holeLUT" are used to delete specific cubes from
# each layer. 
# Malcolm Kesson Jan 16 2013
# Converted to a class: Feb 9 2016
import ri_utils
from math import sqrt
  
class Menger3D:
	def __init__(self, bbox, depth, listOfHoles):
		self.deletedCubes = []     
		self.retainedCubes = []
		self.holeLUT = listOfHoles
		self.bbox = bbox            # minx,miny,minz, maxx,maxy,maxz
		self.depth = depth
		self.divide(bbox, depth)    # the recursive routine
	#_______________________________________________________
	# Given the minimum x,y,z and maximum x,y,z coordinates
	# of a bounding box this proc returns the bouding box
	# coordinates of a "row" of three cubes.
	def row(self, x0,y0,z0, w,h,d):
		x,y,z = x0,y0,z0
		X,Y,Z = x + w, y + h, z + d
		cubes = []
		for n in range(3):
			cube = [x,y,z, X,Y,Z]
			cubes.append(cube)
			z,Z = z + d, Z + d
		return cubes
	#_______________________________________________________
	# A recursive proc that subdivides a bounding box into
	# 27 sub-cubes. Each time the proc is called the arg
	# "depth" is decremented. Recursion terminates when its
	# value becomes zero.
	def divide(self, bbox, depth):
		if depth == 0:
			self.retainedCubes.append(bbox)
			return []
		x0,y0,z0,x1,y1,z1 = bbox
		w = float(x1 - x0)/3
		h = float(y1 - y0)/3
		d = float(z1 - z0)/3
		
		x,y,z = x0,y0,z0
		cubes = []
		for layer in range(3):
			x = x0
			for rows in range(3):
				cubes.extend(self.row(x,y,z,w,h,d))
				x = x + w
			y = y + h
		cubes = self.delete(cubes)
		# Recursion________________
		for cube in cubes:
			self.divide(cube, depth - 1)
		return cubes
	#_______________________________________________________
	# Uses the indices in the holeLUT to remove specific cubes
	# from the list of 27 cubes in the "cubes" arg.
	def delete(self,cubes):
		for n in range(len(self.holeLUT)):
			index = self.holeLUT[n]
			if index < len(cubes):
				hole = cubes.pop(self.holeLUT[n])
				self.deletedCubes.append(hole)
		return cubes
		
	#_______________________________________________________
	# Write a RenderMan archive rib file for the menger cubes
	# or for the cubes that were removed by the delete method.
	def writeAsCubes(self, rib_path, cube_type='retained'):
		f = open(rib_path,'w')
		bboxStr = ' '.join(map(str, self.bbox))
		f.write('#bbox: %s\n' % bboxStr)
		if cube_type == 'retained':
			cubes = self.retainedCubes
		else:
			cubes = self.deletedCubes
		counter = 1
		for cube in cubes:
			f.write(ri_utils.Cube(cube, counter))
			counter += 1
		f.close()
		return len(cubes)
  
	#_______________________________________________________
	# Not used in this example implementation but could be 
	# used to cull cubes on the basis of their distance from
	# a central location - to create a menger sphere.
	def distance(self, p1, p2):
		x = p1[0]-p2[0]
		y = p1[1]-p2[1]
		z = p1[2]-p2[2]
		return sqrt(x * x + y * y + z * z)
		  
#=======================================================
if __name__=="__main__":
	bounds = [-1,0,-1, 1,2,1]
	removals = [10,2,1,4,20,22]
	menger3d = Menger3D(bounds, 5, removals)
	print menger3d.writeAsCubes('/home/mkesson/menger3d.rib')
	











