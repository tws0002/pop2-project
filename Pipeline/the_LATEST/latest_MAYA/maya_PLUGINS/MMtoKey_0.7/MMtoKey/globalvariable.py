import os
import maya.cmds as cmds

#global variables
pluginpath = os.path.dirname(__file__)
markingmenu = cmds.internalVar(umm=True)
tLoad = {'1': True, '0': False}
tName = [False, True, False, True]
tNode = [False, False, True, True]
languages = ['mel', 'python']
popupDiretions = ['N', 'S', 'W', 'E', 'NW', 'NE', 'SW', 'SE']
version = '0.7'
objects = {
    0: 'Handle',
    3: 'Joint',
    9: 'NurbsCurves',
    10: 'NurbsSurfaces',
    11: 'NurbsCurvesOnSurface',
    12: 'Polygon',
    22: 'Locator',
    28: 'ControlVertices(CVs)',
    30: 'EditPoints',
    31: 'PolygonVertices',
    32: 'PolygonEdges',
    34: 'PolygonFace',
    35: 'PolygonUVs',
    36: 'SubdivisionMeshPoints',
    37: 'SubdivisionMeshEdges',
    38: 'SubdivisionMeshFaces',
    39: 'CurveParameterPoints',
    40: 'CurveKnot',
    41: 'SurfaceParameterPoints',
    42: 'SurfaceKnot',
    43: 'SurfaceRange',
    44: 'TrimSurfaceEdge',
    45: 'SurfaceIsoparms',
    46: 'LatticePoints',
    47: 'Particles',
    49: 'ScalePivots',
    50: 'RotatePivots',
    51: 'SelectHandles',
    68: 'SubdivisionSurface',
    70: 'PolygonVertexFace',
    72: 'NURBSSurfaceFace',
    73: 'SubdivisionMeshUVs'}
UI = [u'MayaWindow', u'blendShapePanel1', u'clipEditorPanel1', u'componentEditorPanel1', u'createNodePanel1', u'dopeSheetPanel1', u'dynPaintScriptedPanel', u'dynRelEdPanel1', u'graphEditor1', u'hyperGraphPanel1', u'hyperShadePanel1', u'nodeEditorPanel1', u'outlinerPanel1', u'polyTexturePlacementPanel1', u'profilerPanel1', u'referenceEditorPanel1', u'relationshipPanel1', u'renderView', u'scriptEditorPanel1', u'sequenceEditorPanel1', u'visorPanel1']