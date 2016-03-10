# ri_utils.py
# A collection of procs that generate strings containing the
# RenderMan description of a surface. For example,
#
# import ri_utils
# verts = [ [-1,0,1], [1,0,1], [1,0,-1] ]
# print ri_utils.Polygon(verts)
#
# will generate the following Rib statement:
# Polygon "P" [-1.0  0.0 1.0 1.0  0.0 1.0 1.0  0.0 -1.0]
#
# Malcolm Kesson Jan 20 2013
#_______________________________________________________
def Cube(bbox, index):    
	pnts = []
	minX,minY,minZ,maxX,maxY,maxZ = bbox
	rib =  'AttributeBegin\n'
	rib += 'Attribute "identifier" "float id" [' + str(index) + ']\n'
	rib += 'PointsGeneralPolygons [1 1 1 1 1 1] '
	rib += '[4 4 4 4 4 4]\n'
	rib += '\t\t[0 1 3 2 2 3 5 4 4 5 7 6 6 7 1 0 1 7 5 3 6 0 2 4]\n'
	rib += '\t\t"P" ['
	pnts.append('%1.3f  %1.3f %1.3f' % (minX,minY,maxZ))
	pnts.append(' %1.3f %1.3f %1.3f' % (maxX,minY,maxZ))
	pnts.append(' %1.3f %1.3f %1.3f' % (minX,maxY,maxZ))
	pnts.append(' %1.3f %1.3f %1.3f' % (maxX,maxY,maxZ))
	pnts.append(' %1.3f %1.3f %1.3f' % (minX,maxY,minZ))
	pnts.append(' %1.3f %1.3f %1.3f' % (maxX,maxY,minZ))    
	pnts.append(' %1.3f %1.3f %1.3f' % (minX,minY,minZ))    
	pnts.append(' %1.3f %1.3f %1.3f' % (maxX,minY,minZ))
	rib += ''.join(pnts)
	rib += ']\n'
	rib += 'AttributeEnd\n'
	return rib
#_______________________________________________________
def __cube_edges(bbox):
	x0,y0,z0,x1,y1,z1 = bbox
	edges = []
	# lower edges
	edges.append([ [x0,y0,z0], [x0,y0,z1] ]) # edge 0_1
	edges.append([ [x0,y0,z1], [x1,y0,z1] ]) # edge 1_2
	edges.append([ [x1,y0,z1], [x1,y0,z0] ]) # edge 2_3
	edges.append([ [x1,y0,z0], [x0,y0,z0] ]) # edge 3_0
	# upper edges
	edges.append([ [x0,y1,z0], [x0,y1,z1] ]) # edge 4_5
	edges.append([ [x0,y1,z1], [x1,y1,z1] ]) # edge 5_6
	edges.append([ [x1,y1,z1], [x1,y1,z0] ]) # edge 6_7
	edges.append([ [x1,y1,z0], [x0,y1,z0] ]) # edge 7_4
	# vertical edges
	edges.append([ [x0,y0,z0], [x0,y1,z0] ]) # edge 0_4
	edges.append([ [x0,y0,z1], [x0,y1,z1] ]) # edge 1_5
	edges.append([ [x1,y0,z1], [x1,y1,z1] ]) # edge 2_6
	edges.append([ [x1,y0,z0], [x1,y1,z0] ]) # edge 3_7
	return edges
	
def CubeEdges(bbox, width):
	edges = __cube_edges(bbox)
	rib = ''
	for edge in edges:
		pnts = []
		begin,end = edge
		x,y,z = begin
		X,Y,Z = end
		rib +=  '\tCurves "linear" [2] "nonperiodic" \n'
		rib += '\t\t"P" ['
		pnts.append('%1.3f  %1.3f %1.3f' % (x,y,z))
		pnts.append(' %1.3f %1.3f %1.3f' % (X,Y,Z))
		rib += ''.join(pnts)
		rib += '] "constantwidth" [%1.3f]\n' % width
	return rib
#_______________________________________________________
def Polygon(verts, index):
	pnts = []
	rib =  'Attribute "identifier" "float id" [' + str(index) + ']\n'
	rib += 'Polygon "P" ['
	for vert in verts:
		x,y,z = vert
		pnts.append('%1.3f  %1.3f %1.3f ' % (x,y,z))
	rib += ''.join(pnts)
	rib += ']\n'
	return rib
#_______________________________________________________
def HierarchicalSubdivisionMesh(mesh, index):
	loops = []             # a list of the number of vertices of each face
	vertLUT = {}        # a sequence of unique vertices
	for poly in mesh:
		loops.append(' %d' % len(poly))
		for vert in poly:
			vertLUT[vert] = vert
	# Convert the LUT to a list so that indexing can be used
	pnts = []
	for item in vertLUT.keys():
		pnts.append(item)
	indices = []
	for poly in mesh:
		for vert in poly:
			indices.append(' %d' % pnts.index(vert))
	rib =  'Attribute "identifier" "float id" [' + str(index) + ']\n'
	rib += 'HierarchicalSubdivisionMesh "catmull-clark" \n['
	rib += ''.join(loops)
	rib += ']\n['
	rib += ''.join(indices)
	rib += ']\n'
	rib += '["creasemethod" "facevaryingpropagatecorners" "interpolateboundary"] [0 0 1 1 0 0 1 0 0] [1 1] [] ["chaikin"]\n'
	rib += '"P" [\n'
	pntstr = []
	for pnt in pnts:
		x,y,z = pnt
		pntstr.append('%1.4f %1.4f %1.4f ' % (x,y,z))
	rib += ''.join(pntstr)
	rib += ']\n'
	return rib
#_______________________________________________________
def PointsGeneralPolygons(mesh, index):
	faces = []
	loops = []
	vertLUT = {}
	for poly in mesh:
		faces.append(' 1')
		loops.append(' %d' % len(poly))
		for vert in poly:
			vertLUT[vert] = vert
	pnts = []
	for item in vertLUT.keys():
		pnts.append(item)
	pnts.sort()
	indices = []
	for poly in mesh:
		for vert in poly:
			indices.append(' %d' % pnts.index(vert))
	rib =  'Attribute "identifier" "float id" [' + str(index) + ']\n'
	rib += 'PointsGeneralPolygons ['
	rib += ''.join(faces)
	rib += ']\n['
	rib += ''.join(loops)
	rib += ']\n['
	rib += ''.join(indices)
	rib += '] \n"P" [\n'
	pntstr = []
	for pnt in pnts:
		x,y,z = pnt
		pntstr.append('%1.4f %1.4f %1.4f ' % (x,y,z))
	rib += ''.join(pntstr)
	rib += ']\n'
	return rib
#_______________________________________________________
def Cylinder(bbox, index):
	x,y,z,X,Y,Z = bbox
	xrad = (X - x) / 2
	zrad = (Z - z) / 2
	rad = (xrad + zrad) / 2
	height = Y - y
	rib = 'TransformBegin\n'
	rib += '\tTranslate %1.3f %1.3f %1.3f \n' % (x,y,z)
	rib += '\tRotate 90 1 0 0\n'
	rib += '\tAttribute "identifier" "float id" [' + str(index) + ']\n'
	rib += '\tCylinder %1.3f 0 %1.3f 360\n' % (rad,height)
	rib += 'TransformEnd\n'
	return rib

