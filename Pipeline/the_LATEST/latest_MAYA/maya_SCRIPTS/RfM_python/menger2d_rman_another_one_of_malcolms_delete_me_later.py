# menger2d_rman.py

from menger2d import Menger2D
from menger2d_mel import Menger2D_Mel
from random import uniform
import sourcemel
import math

class Menger2D_Rman(Menger2D):
	def __init__(self, rect, depth):
		Menger2D.__init__(self,rect,depth)

	def writePolygons(self, rib_path):
		f = open(rib_path, 'w')
		bboxStr = ' '.join(map(str, self.bbox))
		f.write('#bbox: %s\n' % bboxStr)
		for rect in self.data:
			verts = self.get_vertices(rect)
			
			pnts = []
			rib = '' #'Color %1.3f %1.3f %1.3f\n' % (random(),random(),random())
			rib += 'Polygon "P" ['
			for vert in verts:
				x,y,z = vert
				dist = math.sqrt(x * x + y * y + z * z)
				y = math.sin(dist * 16) * 0.05
				pnts.append('%1.3f  %1.3f %1.3f ' % (x,y,z))
			rib += ''.join(pnts)
			rib += ']\n'
			f.write(rib)
	
	def get_vertices(self,rect):
		x0,y0,z0, x1,y1,z1 = rect
		y = uniform(y0,y1)
		Y = uniform(y0,y1)
		return [ [x0,y,z0],[x0,y,z1],[x1,Y,z1],[x1,Y,z0] ]


if __name__ == '__main__':	
	bounds = [-1,0,-1, 1,  0.0,  1]
	pixar = Menger2D_Rman(bounds,4)
	pixar.writePolygons('/home/mkesson/menger2d.rib')
	
	maya = Menger2D_Mel(bounds, 1, '/home/mkesson/menger2d.mel')
	maya.makePolys()
	
	#sourcemel.source_mel('/home/mkesson/menger2d.mel', 2222)
	






