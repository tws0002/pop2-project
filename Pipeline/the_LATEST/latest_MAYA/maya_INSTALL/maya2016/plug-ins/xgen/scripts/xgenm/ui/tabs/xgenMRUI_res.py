import maya

maya.stringTable['y_xgenMRUI.kMentalRayApplyHairAnn'] = u"Apply default mental ray XGen Hair Shader to the current Description.\nThe shader reacts to 'root_color', 'tip_color' and 'back_color' XGen custom shader parameters."
maya.stringTable['y_xgenMRUI.kMentalRayRenderMode'] = u'Render Mode'
maya.stringTable['y_xgenMRUI.kSplineDegreeAnn'] = u'Spline Primitives can be rendered as linear segments or as cubic Bezier curves.\nSet to Cubic for Card Primitives.\nHas no effect on Archives and Sphere Primitives.'
maya.stringTable['y_xgenMRUI.kMentalRayApproxSetttings'] = u'mental ray Approximation Settings'
maya.stringTable['y_xgenMRUI.kMentalRayRenderModeAnn'] = u"'Live' allows XGen to query patches and guide animation directly from Maya.\nThis mode doesn't support Motion Blur and will try to reuse information the preview generated.\n\n'Batch Render' mode will always read geometry and animation from files.\n'Batch Render' mode is always on when doing a Batch Render.\nYou must first export the patches and guide animation to caches.\nUse this mode to make sure your caches are properly exported before doing a Batch Render."
maya.stringTable['y_xgenMRUI.kTools'] = u'Tools'
maya.stringTable['y_xgenMRUI.kSplineDegreeCubic'] = u'Cubic'
maya.stringTable['y_xgenMRUI.kRenderModeLive'] = u'Live'
maya.stringTable['y_xgenMRUI.kMentalRayApplyHair'] = u'Apply Hair Shader'
maya.stringTable['y_xgenMRUI.kMentalrayGeoshadersAuto'] = u'Automatically'
maya.stringTable['y_xgenMRUI.kApproximationMethod'] = u'Type'
maya.stringTable['y_xgenMRUI.kApproxFine'] = u'Fine Approximation'
maya.stringTable['y_xgenMRUI.kParametricSubdivisionsAnn'] = u'For Linear, defines the number of segments to use between control points.\nFor Cubic, defines a recursive number of subdivisions between control points.'
maya.stringTable['y_xgenMRUI.kMentalrayGeoshadersAnn'] = u'Setup a mental ray geometry shader used to generate the XGen render time geometry.\nBy default, the setup is automatically done when a new description is created.\nYou can perform the setup manually for the current Description by clicking the Setup button.'
maya.stringTable['y_xgenMRUI.kParametricSubdivisions'] = u'Subdivisions'
maya.stringTable['y_xgenMRUI.kSubPixelSizeAnn'] = u'Subdivides geometry until edges hit a maximal length in pixel size.\nIt is view and resolution dependent.\nValues below 1.0 will split the geometry within the same pixel.\nThis is useful to render very thin hair with tube normals and a high number of samples.\nValues above 1.0 will produce geometry that does not look perfectly smooth.\nThis is useful to optimize render time if the geometry is far away from the camera.'
maya.stringTable['y_xgenMRUI.kSplineDegreeLinear'] = u'Linear'
maya.stringTable['y_xgenMRUI.kSplineDegree'] = u'Degree'
maya.stringTable['y_xgenMRUI.kMentalrayGeoshaders'] = u'Setup GeoShaders'
maya.stringTable['y_xgenMRUI.kApproxParametric'] = u'Parametric Approximation'
maya.stringTable['y_xgenMRUI.kSubPixelSize'] = u'Sub Pixel Size'
maya.stringTable['y_xgenMRUI.kRenderModeBatch'] = u'Batch Render'
maya.stringTable['y_xgenMRUI.kApproxNo'] = u'No Approximation'
maya.stringTable['y_xgenMRUI.kMentalRaySettings'] = u'mental ray Settings'
maya.stringTable['y_xgenMRUI.kApproximationMethodAnn'] = u"Type of mental ray approximation to use when subdividing render time hair bezier curves or card NURBS patches.\n'No Approximation' won't subdivide the render time geometry.\n'Parametric Approximation' subdivides render time geometry a number of times between control points.\n'Fine Approximation' subdivides until edges hit a given length in pixel size. It's view dependent."
maya.stringTable['y_xgenMRUI.kMentalrayGeoshadersManual'] = u'Manually'
maya.stringTable['y_xgenMRUI.kSetupGeometryShaders'] = u'Setup'

