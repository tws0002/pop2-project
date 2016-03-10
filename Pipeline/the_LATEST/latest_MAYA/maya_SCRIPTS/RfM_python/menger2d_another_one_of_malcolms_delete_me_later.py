# menger2d.py
# A class that when given the min and max coordinates
# of a rectangle will divide it into 9 sub-rectangles
# with the center rectangle discarded.

# IMPORT STANDARD LIBRARIES
import time


class Menger2D:
	def __init__(self, rect, depth):
		self.bbox = rect
		self.data = []
		self.divide(rect,depth)
	#_______________________________________________________
	# A recursive proc that subdivides a rectangle into
	# 9 sub-rects. Each time the proc is called the arg
	# "depth" is decremented. Recursion terminates when its
	# value becomes zero.
	def divide(self, rect, depth):
		if depth == 0:
			self.data.append(rect)
			return
		x0,y0,z0, x1,y1,z1 = rect
		w = float(x1 - x0)/3
		h = float(y1 - y0)/3
		d = float(z1 - z0)/3
		x,y,z = x0,y0,z0
		rects = []

		x = x0
		for rows in range(3):
			rects.extend(self.row(x,y,z,w,h,d))
			x = x + w
		rects = self.delete(rects)
	    # Recursion________________
		for rect in rects:
			self.divide(rect, depth - 1)
		return	
	#_______________________________________________________
	def delete(self, rects):
	    hole = rects.pop(4)
	    return rects
	#_______________________________________________________
	# Given the minimum x,z and maximum x,z coordinates
	# of a rectangle this proc returns the coordinates 
	# of a "row" of three sub-rectangles.
	def row(self, x0,y0,z0, w,h,d):
	    x,y,z = x0,y0,z0		
	    X,Y,Z = x + w, y + h, z + d
	    rects = []
	    for n in range(3):
	        rect = [x,y,z, X,Y,Z]
	        rects.append(rect)
	        z,Z = z + d, Z + d
	    return rects
	
	def makePolys(self):
		"""given the min and max coordinats of a rectangle
		   this method outputs a mel command to draw a
		   polygon"""
		f = open('/home/ckenne24/menger.mel', 'w')
		#   x    y    z    X    Y    Z
		# [0.0, 0.0, 0.0, 0.3, 0.0, 1.0]
		for rect in self.data:
			x,y,z,X,Y,Z = rect
			w = rect[3] - rect[0]
			v0 = x,y,z
			v1 = w + x,y,z
			v2 = w + x,y,Z
			v3 = x,y,Z
			f.write('polyCreateFacet -p %f %f %f -p %f %f %f -p %f %f %f -p %f %f %f;\n' % 
				(v0[0],v0[1],v0[2],  v1[0],v1[1],v1[2],   v2[0],v2[1],v2[2],   v3[0],v3[1],v3[2]))
		f.close()

