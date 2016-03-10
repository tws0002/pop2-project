
# maya/projects/RfM_python/menger2d_rman.py

from menger2d import Menger2D
from random import uniform
import math

class Menger2D_Rman(Menger2D):
	def __init__(self, rect, depth):
		Menger2D.__init__(self,rect,depth)

	def writePolygons(self, rib_path, freq, amp, max_amp):
		f = open(rib_path, 'w')
		bboxStr = ' '.join(map(str, self.bbox))
		f.write('#bbox: %s\n' % bboxStr)
		for rect in self.data:
			verts = self.get_vertices(rect)
			pnts = []
			rib = ''
			rib += 'Polygon "P" ['
			for vert in verts:
				x,y,z = vert
				# Alter the shape - wavy....
				dist = math.sqrt(x * x + y * y + z * z)
				y = math.sin(dist * freq) * amp
				if y > max_amp:
					y = max_amp
				pnts.append('%1.3f  %1.3f %1.3f ' % (x,y,z))
			rib += ''.join(pnts)
			rib += ']\n'
			f.write(rib)
	#_______________________________________________________
	def delete(self, rects):
	    hole = rects.pop(5)
	    return rects
	
	def get_vertices(self,rect):
		x0,y0,z0, x1,y1,z1 = rect
		y = uniform(y0,y1)
		Y = uniform(y0,y1)
		return [ [x0,y,z0],[x0,y,z1],[x1,Y,z1],[x1,Y,z0] ]


