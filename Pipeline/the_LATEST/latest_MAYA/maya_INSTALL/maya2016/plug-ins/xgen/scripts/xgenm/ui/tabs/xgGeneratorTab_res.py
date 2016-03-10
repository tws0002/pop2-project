import maya

maya.stringTable['y_xgGeneratorTab.kEnableCullingAnn'] = u'Turns on/off the automatic culling (hiding or removing) of primitives.\nThis controls culling on backfaces and outside the view, but has no effect on manually-culled primitives.'
maya.stringTable['y_xgGeneratorTab.kCullPrimitivesOutsideTheView'] = u'Cull Primitives outside the view'
maya.stringTable['y_xgGeneratorTab.kGenerateOnBackFaces'] = u'Flip to other side of surface'
maya.stringTable['y_xgGeneratorTab.kGeneratingPrimitives'] = u'Generator Attributes'
maya.stringTable['y_xgGeneratorTab.kOffset'] = u'Offset'
maya.stringTable['y_xgGeneratorTab.kBump'] = u'Bump'
maya.stringTable['y_xgGeneratorTab.kPaddingAngleAnn2'] = u'Controls how far the surface must be outside the view before culling occurs.\nYou can increase this to ensure that larger primitives are still visible around the edges of the view.'
maya.stringTable['y_xgGeneratorTab.kBackfaceCullAnn'] = u'Degrees of padding for backface cull.'
maya.stringTable['y_xgGeneratorTab.kCullSelectedPrimitivesAnn'] = u'Select primitives with the Select Tool, then click this to cull (remove or hide) them.'
maya.stringTable['y_xgGeneratorTab.kDisplacement'] = u'Displacement'
maya.stringTable['y_xgGeneratorTab.kCullOutsideViewAnn'] = u'Turn on to cull primitives that are outside the camera view (the frustum).\nYou can save rendering time by culling them. You can render primitives outside the view in certain cases, such as when they are visible in reflections.'
maya.stringTable['y_xgGeneratorTab.kPromoteFunctionDoesNotExist'] = u'Promote function [%s] does not exist.'
maya.stringTable['y_xgGeneratorTab.kNoExtraAttributesForGenerator'] = u'No extra attributes for %s generator.'
maya.stringTable['y_xgGeneratorTab.kOffsetAnn'] = u'Controls the distance at which primitives are created away from the surface.\nThis is similar to Displacement, but the offset direction is not affected by Bump maps.'
maya.stringTable['y_xgGeneratorTab.kVectorDisplacementAnn'] = u'Turn on if you have attached a vector displacement map (VDM) to the Displacement attribute above.'
maya.stringTable['y_xgGeneratorTab.kGenerateOnBackFacesAnn'] = u'Generate primitives on the back side of surface by flipping the surface normals.'
maya.stringTable['y_xgGeneratorTab.kDisplayCulledPrimitives'] = u'Display Culled Primitives'
maya.stringTable['y_xgGeneratorTab.kCullBackFacesAnn'] = u'Turn on to cull primitives that are created on surfaces that face away from the camera.\nThese are usually not visible in the final frame, and you can save rendering time by culling them.'
maya.stringTable['y_xgGeneratorTab.kAtSpecifiedLocations'] = u'At specified locations'
maya.stringTable['y_xgGeneratorTab.kDisplacementAnn'] = u'Control the distance that primitives are displaced from the surface.\nThe direction of displacement is affected by the Bump value. If the surface has a displacement map, attach that map to this attribute.'
maya.stringTable['y_xgGeneratorTab.kDisplayCulledPrimAnn'] = u'Turn on to see (in your preview) the primitives being culled.\nCulled primitives are not rendered.  In the preview, culled primitives display in red and purple.'
maya.stringTable['y_xgGeneratorTab.kGeneratePrimitives'] = u'Generate Primitives'
maya.stringTable['y_xgGeneratorTab.kPaddingAngleAnn'] = u'Controls how far the surface must be turned away from the camera before culling occurs.\nYou can increase this to ensure that primitives are still shown on the silhouette of the surface.'
maya.stringTable['y_xgGeneratorTab.kInUniformRowsAndColumns'] = u'In uniform rows and columns'
maya.stringTable['y_xgGeneratorTab.kCulling'] = u'Culling'
maya.stringTable['y_xgGeneratorTab.kGeneratorTabUnknownType'] = u'Unknown type %s'
maya.stringTable['y_xgGeneratorTab.kPromoteModuleDoesNotExist'] = u'Promote module [%s] does not exist.'
maya.stringTable['y_xgGeneratorTab.kCullSelectedPrimitives'] = u'Cull Selected Primitives'
maya.stringTable['y_xgGeneratorTab.kFromXPDFile'] = u'From XPD File'
maya.stringTable['y_xgGeneratorTab.kUseVectorDisplacementForMaps'] = u'Use Vector Displacement for maps'
maya.stringTable['y_xgGeneratorTab.kRandomlyAcrossTheSurface'] = u'Randomly across the surface'
maya.stringTable['y_xgGeneratorTab.kFrustumCulling'] = u'Degrees of padding for frustum cull.'
maya.stringTable['y_xgGeneratorTab.kGeneratePrimitivesAnn'] = u'Control the distribution of primitives generated by XGen'
maya.stringTable['y_xgGeneratorTab.kAtGuideLocations'] = u'At guide locations'
maya.stringTable['y_xgGeneratorTab.kPaddingAngle'] = u'Padding Angle'
maya.stringTable['y_xgGeneratorTab.kCullPrimitivesOnBackFaces'] = u'Cull Primitives on back faces'
maya.stringTable['y_xgGeneratorTab.kGeneratorSeed'] = u'Generator Seed'
maya.stringTable['y_xgGeneratorTab.kUncull'] = u'Uncull'
maya.stringTable['y_xgGeneratorTab.kEnableCulling'] = u'Enable Culling'
maya.stringTable['y_xgGeneratorTab.kCullExpr'] = u'Cull Expr'
maya.stringTable['y_xgGeneratorTab.kBumpAnn'] = u'Changes the surface normal without changing the position of the surface.\nIf the surface has a bump map, attach that map to this attribute.'
maya.stringTable['y_xgGeneratorTab.kGenerateSeedAnn'] = u'Generator Seed controls the random number generation sequence used by Generators, Modifiers and Expressions.\nUse the same seed on 2 descriptions to generate primitive at the same location.'
maya.stringTable['y_xgGeneratorTab.kCullExprAnn'] = u'This expression is evaluated for each primitive that XGen generates.\nIf the expression returns any value other than 0, that primitive is culled.'
maya.stringTable['y_xgGeneratorTab.kUncullAnn'] = u'Select culled primitives, (you can display them with Display Culled Primitives above) then click this button to bring them back.'
maya.stringTable['y_xgGeneratorTab.kPromote'] = u'Promote'

