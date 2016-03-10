/********************************************************************

ZV Radial Blend Shape

Copyright (C) 2010 Paolo Dominici

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*********************************************************************/

#include <math.h>

#include <maya/MPxDeformerNode.h>
#include <maya/MItGeometry.h>

#include <maya/MTypeId.h> 
#include <maya/MDataBlock.h>
#include <maya/MDataHandle.h>
#include <maya/MGlobal.h>

#include <maya/MFnNumericAttribute.h>
#include <maya/MFnTypedAttribute.h>
#include <maya/MFnMatrixAttribute.h>
#include <maya/MFnCompoundAttribute.h>
#include <maya/MFnEnumAttribute.h>
#include <maya/MFnPlugin.h>
#include <maya/MFnMesh.h>

#include <maya/MPoint.h>
#include <maya/MVector.h>
#include <maya/MPointArray.h>
#include <maya/MVectorArray.h>
#include <maya/MMatrix.h>
#include <maya/MTransformationMatrix.h>

// constants
#define PI 3.14159265
#define TWOPI 6.28318531
#define HALFPI 1.57079633
#define EPSILON 0.0001
#define RADTODEG 57.29577951
#define DEGTORAD 0.01745329
#define ONETHIRD 0.33333333
#define TWOTHIRDS 0.66666667

// 2D Point structure
struct Point {
	double x, y;

	Point() : x(0.0), y(0.0) {}

	Point(double x, double y) {
		this->x = x;
		this->y = y;
	}

	Point& operator*=(const double val) {
		this->x *= val;
		this->y *= val;
		return *this;
	}
};

// radialBlendShape class definition
class radialBlendShape : public MPxDeformerNode {
public:
	radialBlendShape();
	virtual ~radialBlendShape();
	static void* creator();
	static MStatus initialize();

	// deformation function
    virtual MStatus deform(MDataBlock& data, MItGeometry& iter, const MMatrix& mat, unsigned int multiIndex);

	// radialBlendShape attributes
	static MObject inputTargetAttr;
	static MObject inputMeshAttr;
	static MObject inputOppositeMeshAttr;
	static MObject inputMatrixAttr;
	static MObject eyeMatrixAttr;
	static MObject eyeParentMatrixAttr;
	static MObject blendAttr;
	static MObject twistAttr;
	static MObject offsetInAttr;
	static MObject	offsetInXAttr;
	static MObject	offsetInYAttr;
	static MObject	offsetInZAttr;
	static MObject offsetMidAttr;
	static MObject	offsetMidXAttr;
	static MObject	offsetMidYAttr;
	static MObject	offsetMidZAttr;
	static MObject offsetOutAttr;
	static MObject	offsetOutXAttr;
	static MObject	offsetOutYAttr;
	static MObject	offsetOutZAttr;
	static MObject blinkAttr;
	static MObject blinkBiasAttr;
	static MObject followAttr;
	static MObject followMaxAngleAttr;
	static MObject followOpenAttr;
	static MObject followCloseAttr;
	static MObject offsetInfluenceAngleAttr;
	static MObject maxDisplacementAttr;
	static MObject bulgeDisplacementAttr;
	static MObject bulgeRadiusAttr;
	static MObject computeDisplacementsAttr;
	static MObject weightsAttr;
	static MTypeId id;

private:
	MVectorArray defVectors;
	MPointArray origPoints;

	static const unsigned int segments = 64;
	double step;
	double *bulgeFalloff;
	Point quadCVs[7];

	void toCartesian(MPoint& point, MPoint& outPoint);
	void toSpherical(MPoint& point, MPoint& outPoint);
	void linearBlend(MVector& p1, MVector& p2, double blend, MVector& outPoint);
	void sphericalBlend(MPoint& p1, MPoint& p2, double blend, MPoint& outPoint);
	double followBlend(double normEyeRotX, double openVal, double closeVal, bool isUpper, double follow);
	double getFalloffValue(double d);
	void bezier(Point& p1, Point& p2, Point& p3, Point& p4, double t, Point& outPoint);
	void setSplineCVs(double h0, double h1, double h2, Point *cvs);
	void setSpline(double h0, double h1, double h2, double *coeffs);
	void setQuadCoefficients(Point& p0, Point& p1, Point& p2, double *coeffs);
	double getQuadValue(double x, double *coeffs);
	double getSplineValue(double x, double *allCoeffs);
	double setMaxSphericalDisplacement(MItGeometry& iter, MFnMesh& targetMesh, MMatrix& invLocMatrix, MDataHandle& maxDisplacementDH);

	static const double& maxd(const double& a, const double& b);
	static const double& mind(const double& a, const double& b);
};

MTypeId radialBlendShape::id(0x58804);

// radialBlendShape attributes
MObject radialBlendShape::inputTargetAttr;
MObject radialBlendShape::inputMeshAttr;
MObject radialBlendShape::inputOppositeMeshAttr;
MObject radialBlendShape::inputMatrixAttr;
MObject radialBlendShape::eyeMatrixAttr;
MObject radialBlendShape::eyeParentMatrixAttr;
MObject radialBlendShape::blendAttr;
MObject radialBlendShape::twistAttr;
MObject radialBlendShape::offsetInAttr;
MObject		radialBlendShape::offsetInXAttr;
MObject		radialBlendShape::offsetInYAttr;
MObject		radialBlendShape::offsetInZAttr;
MObject radialBlendShape::offsetMidAttr;
MObject		radialBlendShape::offsetMidXAttr;
MObject		radialBlendShape::offsetMidYAttr;
MObject		radialBlendShape::offsetMidZAttr;
MObject radialBlendShape::offsetOutAttr;
MObject		radialBlendShape::offsetOutXAttr;
MObject		radialBlendShape::offsetOutYAttr;
MObject		radialBlendShape::offsetOutZAttr;
MObject radialBlendShape::blinkAttr;
MObject radialBlendShape::blinkBiasAttr;
MObject radialBlendShape::followAttr;
MObject radialBlendShape::followMaxAngleAttr;
MObject radialBlendShape::followOpenAttr;
MObject radialBlendShape::followCloseAttr;
MObject radialBlendShape::offsetInfluenceAngleAttr;
MObject radialBlendShape::maxDisplacementAttr;
MObject radialBlendShape::bulgeDisplacementAttr;
MObject radialBlendShape::bulgeRadiusAttr;
MObject radialBlendShape::computeDisplacementsAttr;
MObject radialBlendShape::weightsAttr;


radialBlendShape::radialBlendShape() {
	// falloff curve values for the cornea deformation
	step = 1.0/segments;
	static double bulgeFalloffArr[] = {1.0, 0.99945442173592491, 0.99783472210708002, 0.995166301008234, 0.99147437121095805, 0.98678398537855994, 0.98112005024202831, 0.97450736262766002, 0.96697061369883852, 0.95853444250914654, 0.94922342571380991, 0.93906211531165706, 0.92807508818293172, 0.91628691928051775, 0.90372227992376841, 0.89040586098126717, 0.87636251630831052, 0.86161724250926774, 0.84619514113615923, 0.83012157674634302, 0.8134221506908802, 0.79612265971927931, 0.77824927559365431, 0.75982851529385687, 0.74088719860774133, 0.72145267716326744, 0.70155263442752513, 0.68121547076717204, 0.66046998651995281, 0.63934560265515605, 0.61787260642240938, 0.59608185208452169, 0.57400500651597752, 0.55167481658746798, 0.5291248099116419, 0.50638956810692903, 0.48350501889530573, 0.46050814822964292, 0.43743730598628061, 0.41433252801993192, 0.39123527447877327, 0.36818877590190702, 0.34523839411122736, 0.32243140682406246, 0.29981740733651285, 0.27744871911848235, 0.25538025527823061, 0.23366999369926855, 0.21237947036071392, 0.19157369738942032, 0.17132210143431992, 0.15169826551246934, 0.13278119515323084, 0.11465553319025379, 0.097411932436392124, 0.081148444997437674, 0.06597107200633745, 0.051994558313846029, 0.039344117844172466, 0.028156552534532975, 0.018581765425817687, 0.01078513374765766, 0.004949652012449568, 0.0012787515973776697, 0.0};
	bulgeFalloff = bulgeFalloffArr;

	// x positions of the control points used on the piecewise quadratic spline defined by the offset controls
	quadCVs[0].x = -1.0;
	quadCVs[1].x = -TWOTHIRDS;
	quadCVs[2].x = -ONETHIRD;
	quadCVs[3].x = 0.0;
	quadCVs[4].x = ONETHIRD;
	quadCVs[5].x = TWOTHIRDS;
	quadCVs[6].x = 1.0;

}

radialBlendShape::~radialBlendShape() {
}

void* radialBlendShape::creator() {
	return new radialBlendShape();
}

// attributes
MStatus radialBlendShape::initialize() {
	// target mesh
	MFnTypedAttribute tAttr;
	inputMeshAttr = tAttr.create("inputMesh", "i", MFnData::kMesh);
	addAttribute(inputMeshAttr);
	
	inputOppositeMeshAttr = tAttr.create("inputOppositeMesh", "io", MFnData::kMesh);
	addAttribute(inputOppositeMeshAttr);
	
	// matrix of the center
	MFnMatrixAttribute mAttr;
	inputMatrixAttr = mAttr.create("inputMatrix", "im");
	addAttribute(inputMatrixAttr);
	
	// eye matrix
	eyeMatrixAttr = mAttr.create("eyeMatrix", "em");
	addAttribute(eyeMatrixAttr);
	
	// eye parent matrix
	eyeParentMatrixAttr = mAttr.create("eyeParentMatrix", "epm");
	addAttribute(eyeParentMatrixAttr);
	
	// blend value
	MFnNumericAttribute nAttr;
	blendAttr = nAttr.create("blend", "b", MFnNumericData::kDouble, -1000.0);
	nAttr.setArray(true);
	nAttr.setUsesArrayDataBuilder(true);
	nAttr.setKeyable(true);
	addAttribute(blendAttr);

	// twist value
	twistAttr = nAttr.create("twist", "t", MFnNumericData::kDouble, -1000.0);
	nAttr.setArray(true);
	nAttr.setUsesArrayDataBuilder(true);
	nAttr.setKeyable(true);
	addAttribute(twistAttr);

	// offsetIn
	offsetInXAttr = nAttr.create("offsetInX", "oix", MFnNumericData::kDouble, 0.0);
	offsetInYAttr = nAttr.create("offsetInY", "oiy", MFnNumericData::kDouble, 0.0);
	offsetInZAttr = nAttr.create("offsetInZ", "oiz", MFnNumericData::kDouble, 0.0);
	offsetInAttr = nAttr.create("offsetIn", "oi", offsetInXAttr, offsetInYAttr, offsetInZAttr);
	nAttr.setArray(true);
	nAttr.setUsesArrayDataBuilder(true);
	addAttribute(offsetInAttr);

	// offsetMid
	offsetMidXAttr = nAttr.create("offsetMidX", "omx", MFnNumericData::kDouble, 0.0);
	offsetMidYAttr = nAttr.create("offsetMidY", "omy", MFnNumericData::kDouble, 0.0);
	offsetMidZAttr = nAttr.create("offsetMidZ", "omz", MFnNumericData::kDouble, 0.0);
	offsetMidAttr = nAttr.create("offsetMid", "om", offsetMidXAttr, offsetMidYAttr, offsetMidZAttr);
	nAttr.setArray(true);
	nAttr.setUsesArrayDataBuilder(true);
	addAttribute(offsetMidAttr);

	// offsetOut
	offsetOutXAttr = nAttr.create("offsetOutX", "oox", MFnNumericData::kDouble, 0.0);
	offsetOutYAttr = nAttr.create("offsetOutY", "ooy", MFnNumericData::kDouble, 0.0);
	offsetOutZAttr = nAttr.create("offsetOutZ", "ooz", MFnNumericData::kDouble, 0.0);
	offsetOutAttr = nAttr.create("offsetOut", "oo", offsetOutXAttr, offsetOutYAttr, offsetOutZAttr);
	nAttr.setArray(true);
	nAttr.setUsesArrayDataBuilder(true);
	addAttribute(offsetOutAttr);

	// blink value
	blinkAttr = nAttr.create("blink", "bl", MFnNumericData::kDouble, -1000.0);
	nAttr.setArray(true);
	nAttr.setUsesArrayDataBuilder(true);
	nAttr.setMin(0.0);
	nAttr.setMax(1.0);
	nAttr.setKeyable(true);
	addAttribute(blinkAttr);

	// blink bias value
	blinkBiasAttr = nAttr.create("blinkBias", "blb", MFnNumericData::kDouble, -1000.0);
	nAttr.setArray(true);
	nAttr.setUsesArrayDataBuilder(true);
	nAttr.setMin(0.0);
	nAttr.setMax(1.0);
	nAttr.setKeyable(true);
	addAttribute(blinkBiasAttr);

	// follow value
	followAttr = nAttr.create("follow", "fl", MFnNumericData::kDouble, -1000.0);
	nAttr.setArray(true);
	nAttr.setUsesArrayDataBuilder(true);
	nAttr.setMin(0.0);
	nAttr.setMax(1.0);
	nAttr.setKeyable(true);
	addAttribute(followAttr);

	// follow max angle value
	followMaxAngleAttr = nAttr.create("followMaxAngle", "fma", MFnNumericData::kDouble, -1000.0);
	nAttr.setArray(true);
	nAttr.setUsesArrayDataBuilder(true);
	nAttr.setMin(0.0);
	nAttr.setMax(90.0);
	nAttr.setChannelBox(true);
	addAttribute(followMaxAngleAttr);

	// follow open value
	followOpenAttr = nAttr.create("followOpen", "fo", MFnNumericData::kDouble, -1000.0);
	nAttr.setArray(true);
	nAttr.setUsesArrayDataBuilder(true);
	nAttr.setMin(0.0);
	nAttr.setMax(1.0);
	nAttr.setChannelBox(true);
	addAttribute(followOpenAttr);

	// follow close value
	followCloseAttr = nAttr.create("followClose", "fc", MFnNumericData::kDouble, -1000.0);
	nAttr.setArray(true);
	nAttr.setUsesArrayDataBuilder(true);
	nAttr.setMin(0.0);
	nAttr.setMax(1.0);
	nAttr.setChannelBox(true);
	addAttribute(followCloseAttr);

	// offset influence value (it should be roughly the angle from the center of the eye to the two lid corners)
	offsetInfluenceAngleAttr = nAttr.create("offsetInfluenceAngle", "oia", MFnNumericData::kDouble, -1000.0);
	nAttr.setArray(true);
	nAttr.setUsesArrayDataBuilder(true);
	nAttr.setMin(0.0);
	nAttr.setMax(180.0);
	nAttr.setChannelBox(true);
	addAttribute(offsetInfluenceAngleAttr);

	// max displacement value
	maxDisplacementAttr = nAttr.create("maxDisplacement", "md", MFnNumericData::kDouble, -1000.0);
	nAttr.setArray(true);
	nAttr.setUsesArrayDataBuilder(true);
	addAttribute(maxDisplacementAttr);

	// bulge displacement value
	bulgeDisplacementAttr = nAttr.create("bulgeDisplacement", "bd", MFnNumericData::kDouble, -1000.0);
	nAttr.setArray(true);
	nAttr.setUsesArrayDataBuilder(true);
	nAttr.setMin(0.0);
	nAttr.setChannelBox(true);
	addAttribute(bulgeDisplacementAttr);

	// bulge radius value
	bulgeRadiusAttr = nAttr.create("bulgeRadius", "br", MFnNumericData::kDouble, -1000.0);
	nAttr.setArray(true);
	nAttr.setUsesArrayDataBuilder(true);
	nAttr.setMin(0.0);
	nAttr.setMax(90.0);
	nAttr.setChannelBox(true);
	addAttribute(bulgeRadiusAttr);

	// weights array
	weightsAttr = nAttr.create("targetWeights", "tw", MFnNumericData::kFloat, -1000.0);
	nAttr.setMin(0.0);
	nAttr.setMax(1.0);
	nAttr.setArray(true);
	nAttr.setReadable(true);
	nAttr.setUsesArrayDataBuilder(true);
	addAttribute(weightsAttr);

	// displacement computation state
	MFnEnumAttribute eAttr;
	computeDisplacementsAttr = eAttr.create("computeDisplacements", "cs", 0);
	eAttr.addField("Run", 0);
	eAttr.addField("Stored", 1);
	eAttr.setChannelBox(true);
	addAttribute(computeDisplacementsAttr);

	// input target compound attr
	MFnCompoundAttribute cAttr;
	inputTargetAttr = cAttr.create("inputTarget", "it");
	cAttr.setArray(true);

	cAttr.addChild(inputMeshAttr);
	cAttr.addChild(inputOppositeMeshAttr);
	cAttr.addChild(inputMatrixAttr);
	cAttr.addChild(eyeMatrixAttr);
	cAttr.addChild(eyeParentMatrixAttr);
	cAttr.addChild(weightsAttr);

	cAttr.setUsesArrayDataBuilder(true);
	addAttribute(inputTargetAttr);

	// affects
    attributeAffects(blendAttr, outputGeom);
	attributeAffects(twistAttr, outputGeom);
	attributeAffects(offsetInAttr, outputGeom);
    attributeAffects(offsetMidAttr, outputGeom);
    attributeAffects(offsetOutAttr, outputGeom);
    attributeAffects(blinkAttr, outputGeom);
    attributeAffects(blinkBiasAttr, outputGeom);
    attributeAffects(followAttr, outputGeom);
    attributeAffects(followMaxAngleAttr, outputGeom);
    attributeAffects(followOpenAttr, outputGeom);
    attributeAffects(followCloseAttr, outputGeom);
    attributeAffects(offsetInfluenceAngleAttr, outputGeom);
    attributeAffects(maxDisplacementAttr, outputGeom);
    attributeAffects(bulgeDisplacementAttr, outputGeom);
    attributeAffects(bulgeRadiusAttr, outputGeom);
    attributeAffects(computeDisplacementsAttr, outputGeom);
    attributeAffects(inputTargetAttr, outputGeom);

	return MStatus::kSuccess;
}

// Deformation function
MStatus radialBlendShape::deform(MDataBlock& data, MItGeometry& iter, const MMatrix& mat, unsigned int) {
	MStatus status = MStatus::kSuccess;

	// envelope
	MDataHandle dh = data.inputValue(envelope);
	double envelope = dh.asFloat();

	// input target attribute
	MArrayDataHandle inputTargetADH = data.inputArrayValue(inputTargetAttr);

	unsigned int targetCount = inputTargetADH.elementCount();

	// exit if none
	if (envelope == 0.0 || targetCount == 0)
		return status;
	
	// eyelid attribute array handles arrays
	MArrayDataHandle blendADH = data.inputArrayValue(blendAttr);
	MArrayDataHandle twistADH = data.inputArrayValue(twistAttr);
	MArrayDataHandle offsetInADH = data.inputArrayValue(offsetInAttr);
	MArrayDataHandle offsetMidADH = data.inputArrayValue(offsetMidAttr);
	MArrayDataHandle offsetOutADH = data.inputArrayValue(offsetOutAttr);
	MArrayDataHandle blinkADH = data.inputArrayValue(blinkAttr);
	MArrayDataHandle blinkBiasADH = data.inputArrayValue(blinkBiasAttr);
	MArrayDataHandle followADH = data.inputArrayValue(followAttr);
	MArrayDataHandle followMaxAngleADH = data.inputArrayValue(followMaxAngleAttr);
	MArrayDataHandle followOpenADH = data.inputArrayValue(followOpenAttr);
	MArrayDataHandle followCloseADH = data.inputArrayValue(followCloseAttr);
	MArrayDataHandle offsetInfluenceAngleADH = data.inputArrayValue(offsetInfluenceAngleAttr);
	MArrayDataHandle maxDisplacementADH = data.inputArrayValue(maxDisplacementAttr);
	MArrayDataHandle bulgeDisplacementADH = data.inputArrayValue(bulgeDisplacementAttr);
	MArrayDataHandle bulgeRadiusADH = data.inputArrayValue(bulgeRadiusAttr);

	// computeDisplacements enum value
	MDataHandle computeDisplacementsDH = data.inputValue(computeDisplacementsAttr);
	short computeDisplacements = computeDisplacementsDH.asShort();


	///////////////
	// VARIABLES //
	///////////////

	MObject meshObj, oppMeshObj;
	MMatrix invGeoMatrix, matrix, invMatrix, eyeMatrix, invEyeMatrix;
	double blend, twist, blink, blinkBias, bulgeDisplacement, bulgeRadius, offsetInfluenceAngle;
	double loBlend, loTwist, loFollow, loFollowMaxAngle, loFollowOpen, loFollowClose;
	double upBlend, upTwist, upFollow, upFollowMaxAngle, upFollowOpen, upFollowClose;
	MVector offsetIn, offsetMid, offsetOut;
	MVector loOffsetIn, loOffsetMid, loOffsetOut;
	MVector upOffsetIn, upOffsetMid, upOffsetOut;
	unsigned int t, i, pointCount;
	int tidx, loidx, upidx, idx;
	MDataHandle cdh;

	// for each spherical coordinate I have a spline defined by 3 quadratic splines that require 9 coefficients in total
	// normAngle is the parameter of the spline function, it starts from the center of the eye, it's normalized by the offsetInfluenceAngle value
	double splineCoeffsX[9], splineCoeffsY[9], splineCoeffsZ[9], normAngle;

	MPoint targetPoint, targetOppPoint, origPointLS, targetPointLS, blendedPointLS, origPointLSSph, targetPointLSSph, blendedPointLSSph;
	MVector tmpVector;
	MVector* defVector;
	MPoint* origPoint;
	double localBlend, weight, maxDisplacement;
	bool isLower, oppMeshExists;

	// eye transform variables
	MTransformationMatrix eyeTransformation;
	MTransformationMatrix::RotationOrder eyeRotOrder;
	double eyeRot[3];
	double loNormEyeRotX, upNormEyeRotX, angleFromEye;

	// store the geo's inverse matrix
	invGeoMatrix = mat.inverse();

	// store the original points
	iter.allPositions(origPoints, MSpace::kObject);
	pointCount = origPoints.length();

	// resize the array if needed
	defVectors.setLength(pointCount);

	// zero out the deformation vectors
	for (i = 0; i < pointCount; i++)
		defVectors[i] = MVector::zero;
	
	/////////////////
	// TARGET LOOP //
	/////////////////

	// loop through the connected or stored meshes (radial blend shape targets)
	for (t=0; t<targetCount; inputTargetADH.next(), t++) {
		tidx = inputTargetADH.elementIndex();
		isLower = tidx % 2 == 0;
		loidx = isLower ? tidx : (tidx - 1);
		upidx = loidx + 1;

		dh = inputTargetADH.inputValue();

		// target mesh
		cdh = dh.child(inputMeshAttr);

		// if no mesh, continue
		if (cdh.type() != MFnData::kMesh)
			continue;
		
		meshObj = cdh.asMesh();
		MFnMesh mesh(meshObj);
		
		// opposite mesh
		cdh = dh.child(inputOppositeMeshAttr);
		oppMeshExists = cdh.type() == MFnData::kMesh;
		if (oppMeshExists)
			oppMeshObj = cdh.asMesh();
		else
			oppMeshObj = meshObj;
		
		MFnMesh oppMesh(oppMeshObj);

		// find the locator's matrix relative to the geo's transform
		cdh = dh.child(inputMatrixAttr);
		matrix = cdh.asMatrix();
		matrix *= invGeoMatrix;
		invMatrix = matrix.inverse();

		/////////////////////
		// GET ATTR VALUES //
		/////////////////////

		// blend
		loBlend = (blendADH.jumpToElement(loidx) == MStatus::kSuccess)? blendADH.inputValue().asDouble() : 0.0;
		upBlend = (blendADH.jumpToElement(upidx) == MStatus::kSuccess)? blendADH.inputValue().asDouble() : 0.0;

		// twist
		loTwist = (twistADH.jumpToElement(loidx) == MStatus::kSuccess) ? twistADH.inputValue().asDouble() : 0.0;
		upTwist = (twistADH.jumpToElement(upidx) == MStatus::kSuccess) ? twistADH.inputValue().asDouble() : 0.0;

		// offset in
		loOffsetIn = (offsetInADH.jumpToElement(loidx) == MStatus::kSuccess)? offsetInADH.inputValue().asVector() : MVector::zero;
		upOffsetIn = (offsetInADH.jumpToElement(upidx) == MStatus::kSuccess)? offsetInADH.inputValue().asVector() : MVector::zero;

		// offset mid
		loOffsetMid = (offsetMidADH.jumpToElement(loidx) == MStatus::kSuccess)? offsetMidADH.inputValue().asVector() : MVector::zero;
		upOffsetMid = (offsetMidADH.jumpToElement(upidx) == MStatus::kSuccess)? offsetMidADH.inputValue().asVector() : MVector::zero;

		// offset out
		loOffsetOut = (offsetOutADH.jumpToElement(loidx) == MStatus::kSuccess)? offsetOutADH.inputValue().asVector() : MVector::zero;
		upOffsetOut = (offsetOutADH.jumpToElement(upidx) == MStatus::kSuccess) ? offsetOutADH.inputValue().asVector() : MVector::zero;

		// blink
		blink = (blinkADH.jumpToElement(upidx) == MStatus::kSuccess)? blinkADH.inputValue().asDouble() : 0.0;

		// blink bias
		blinkBias = (blinkBiasADH.jumpToElement(upidx) == MStatus::kSuccess)? blinkBiasADH.inputValue().asDouble() : 0.0;

		// follow
		loFollow = (followADH.jumpToElement(loidx) == MStatus::kSuccess)? followADH.inputValue().asDouble() : 0.0;
		upFollow = (followADH.jumpToElement(upidx) == MStatus::kSuccess)? followADH.inputValue().asDouble() : 0.0;

		// followMaxAngle
		loFollowMaxAngle = (followMaxAngleADH.jumpToElement(loidx) == MStatus::kSuccess)? followMaxAngleADH.inputValue().asDouble() : 0.0;
		upFollowMaxAngle = (followMaxAngleADH.jumpToElement(upidx) == MStatus::kSuccess)? followMaxAngleADH.inputValue().asDouble() : 0.0;

		// followOpen
		loFollowOpen = (followOpenADH.jumpToElement(loidx) == MStatus::kSuccess)? followOpenADH.inputValue().asDouble() : 0.0;
		upFollowOpen = (followOpenADH.jumpToElement(upidx) == MStatus::kSuccess)? followOpenADH.inputValue().asDouble() : 0.0;

		// followClose
		loFollowClose = (followCloseADH.jumpToElement(loidx) == MStatus::kSuccess)? followCloseADH.inputValue().asDouble() : 0.0;
		upFollowClose = (followCloseADH.jumpToElement(upidx) == MStatus::kSuccess)? followCloseADH.inputValue().asDouble() : 0.0;

		// offsetInfluenceAngle
		offsetInfluenceAngle = (offsetInfluenceAngleADH.jumpToElement(upidx) == MStatus::kSuccess)? offsetInfluenceAngleADH.inputValue().asDouble()*DEGTORAD : 0.0;

		// maxDisplacement
		MDataHandle maxDisplacementDH;
		if (maxDisplacementADH.jumpToElement(tidx) == MStatus::kSuccess && computeDisplacements == 1)
			maxDisplacementDH = maxDisplacementADH.inputValue();

		// create element if not existing
		else {
			// create the element with a negative value (negative means the max displacement needs to be computed)
			MPlug maxDisplacementArrPlug(thisMObject(), maxDisplacementAttr);
			MPlug maxDisplacementPlug = maxDisplacementArrPlug.elementByLogicalIndex(tidx);
			maxDisplacementPlug.setValue(-1.0);

			// get the data handle of the element
			maxDisplacementADH.jumpToElement(tidx);
			maxDisplacementDH = maxDisplacementADH.inputValue();

			// -1 means that the computation has been performed
			computeDisplacements = -1;
		}
		maxDisplacement = maxDisplacementDH.asDouble();

		// find max displacement from this target
		if (maxDisplacement < 0.0)
			maxDisplacement = setMaxSphericalDisplacement(iter, mesh, invMatrix, maxDisplacementDH);

		///////////////////
		// EYELID FOLLOW //
		///////////////////

		// get the eye matrix (used on the follow eye)
		cdh = dh.child(eyeMatrixAttr);
		eyeMatrix = cdh.asMatrix();
		eyeTransformation = eyeMatrix;
		eyeTransformation.reorderRotation(MTransformationMatrix::kZYX);
		eyeTransformation.getRotation(eyeRot, eyeRotOrder);

		// x local rotation of the eye normalized by the followMaxAngle value
		loNormEyeRotX = (loFollowMaxAngle == 0.0)? 0.0 : mind(maxd(eyeRot[0]*RADTODEG/loFollowMaxAngle, -1.0), 1.0);
		upNormEyeRotX = (upFollowMaxAngle == 0.0)? 0.0 : mind(maxd(eyeRot[0]*RADTODEG/upFollowMaxAngle, -1.0), 1.0);

		// add the follow lid contribution
		loBlend += followBlend(loNormEyeRotX, loFollowOpen, loFollowClose, false, loFollow);
		upBlend += followBlend(upNormEyeRotX, upFollowOpen, upFollowClose, true, upFollow);

		//////////////////
		// EYELID BLINK //
		//////////////////

		// final values if lower lid, these values depend on the blink and blinkBias
		if (isLower) {
			if (blink > 0.0) {
				blend = loBlend - (loBlend + upBlend - 1.0)*blinkBias;
				blend = loBlend + (blend - loBlend)*blink;

				twist = loTwist - (upTwist + loTwist)*blinkBias;
				twist = loTwist + (twist - loTwist)*blink;

				linearBlend(loOffsetIn, upOffsetIn, blinkBias, offsetIn);
				linearBlend(loOffsetIn, offsetIn, blink, offsetIn);

				linearBlend(loOffsetMid, upOffsetMid, blinkBias, offsetMid);
				linearBlend(loOffsetMid, offsetMid, blink, offsetMid);

				linearBlend(loOffsetOut, upOffsetOut, blinkBias, offsetOut);
				linearBlend(loOffsetOut, offsetOut, blink, offsetOut);
			}
			else {
				blend = loBlend;
				twist = loTwist;
				offsetIn = loOffsetIn;
				offsetMid = loOffsetMid;
				offsetOut = loOffsetOut;
			}
		}

		// final values if upper lid
		else {
			if (blink > 0.0) {
				blend = (upBlend + loBlend - 1.0)*blinkBias - loBlend + 1.0;
				blend = upBlend + (blend - upBlend)*blink;

				twist = (upTwist + loTwist)*blinkBias - loTwist;
				twist = upTwist + (twist - upTwist)*blink;

				linearBlend(loOffsetIn, upOffsetIn, blinkBias, offsetIn);
				linearBlend(upOffsetIn, offsetIn, blink, offsetIn);

				linearBlend(loOffsetMid, upOffsetMid, blinkBias, offsetMid);
				linearBlend(upOffsetMid, offsetMid, blink, offsetMid);

				linearBlend(loOffsetOut, upOffsetOut, blinkBias, offsetOut);
				linearBlend(upOffsetOut, offsetOut, blink, offsetOut);
			}
			else {
				blend = upBlend;
				twist = upTwist;
				offsetIn = upOffsetIn;
				offsetMid = upOffsetMid;
				offsetOut = upOffsetOut;
			}

			// on the upper lid positive values mean negative blending
			offsetIn.y *= -1.0;
			offsetMid.y *= -1.0;
			offsetOut.y *= -1.0;
		}

		// set the spline for the offsets, I compute one spline per axis
		setSpline(offsetIn.x, offsetMid.x, offsetOut.x, splineCoeffsX);
		setSpline(offsetIn.y, offsetMid.y, offsetOut.y, splineCoeffsY);
		setSpline(offsetIn.z, offsetMid.z, offsetOut.z, splineCoeffsZ);

		// loop through the affected points (eyelid blending)
		for (i=0; !iter.isDone(); i++, iter.next()) {
			idx = iter.index();
			
			// get original and target points in object space
			origPoint = &origPoints[i];
			mesh.getPoint(idx, targetPoint, MSpace::kObject);
			
			if (oppMeshExists)
				oppMesh.getPoint(idx, targetOppPoint, MSpace::kObject);
			
			// if the target point is not equal to the original point, then do the blend calculation
			if (fabs(targetPoint.x - origPoint->x) > EPSILON || fabs(targetPoint.y - origPoint->y) > EPSILON || fabs(targetPoint.z - origPoint->z) > EPSILON || (oppMeshExists && (fabs(targetOppPoint.x - origPoint->x) > EPSILON || fabs(targetOppPoint.y - origPoint->y) > EPSILON || fabs(targetOppPoint.z - origPoint->z) > EPSILON))) {
				// point in locator space
				origPointLS = (*origPoint)*invMatrix;
				
				// convert to spherical coordinates
				toSpherical(origPointLS, origPointLSSph);
				
				// get the blend value for this specific point
				localBlend = blend - (HALFPI - origPointLSSph.z)*twist;
				
				// angle starting from the middle of the lid opening (where the offsetMid is centered)
				normAngle = (HALFPI - origPointLSSph.z) / offsetInfluenceAngle * 2.0;

				// add the offset y contributions to the localBlend value
				localBlend += getSplineValue(normAngle, splineCoeffsY);

				// get target point in locator space
				// if the local blend is negative, use the opposite mesh
				if (oppMeshExists && localBlend < 0.0) {
					localBlend *= -1;
					targetPointLS = targetOppPoint*invMatrix;
				}
				else {
					targetPointLS = targetPoint*invMatrix;
				}

				// convert to spherical coordinates
				toSpherical(targetPointLS, targetPointLSSph);

				// get the blended point
				sphericalBlend(origPointLSSph, targetPointLSSph, localBlend, blendedPointLSSph);

				// the x and z offsets will be modulated by the weight obtained by the distance of the original point and the target point along the azimuth
				weight = fabs(targetPointLSSph.y - origPointLSSph.y) / maxDisplacement;

				// add x offset to polar angle
				blendedPointLSSph.z -= getSplineValue(normAngle, splineCoeffsX)*weight;

				// add z offset to radius
				blendedPointLSSph.x += getSplineValue(normAngle, splineCoeffsZ)*weight;

				// convert the blended point to cartesian (locator space)
				toCartesian(blendedPointLSSph, blendedPointLS);

				// get the offset from the original position
				tmpVector = blendedPointLS - origPointLS;

				// convert the offset to object space
				tmpVector *= matrix;

				// sum this offset to the other target offsets
				defVectors[i] += tmpVector;
			}
		}
		iter.reset();
	}

	// first envelope blending pass
	for (i=0; i < pointCount; i++) {
		defVector = &defVectors[i];

		if (*defVector == MVector::zero)
			continue;

		// set the final position of this point
		(*defVector) *= envelope;
		origPoints[i] += (*defVector);

		(*defVector) = MVector::zero;
	}

	///////////////////////
	// BULGE DEFORMATION //
	///////////////////////

	// reset array position
	inputTargetADH = data.inputArrayValue(inputTargetAttr);

	// bulge deformation
	for (t=0; t<targetCount; inputTargetADH.next(), t++) {
		tidx = inputTargetADH.elementIndex();
		isLower = tidx % 2 == 0;

		// the upper eyelid indices are the ones that contain the bulge data
		if (isLower)
			continue;

		// bulge displacement
		bulgeDisplacement = (bulgeDisplacementADH.jumpToElement(tidx) == MStatus::kSuccess)? bulgeDisplacementADH.inputValue().asDouble()*envelope : 0.0;

		// bulge radius
		bulgeRadius = (bulgeRadiusADH.jumpToElement(tidx) == MStatus::kSuccess)? bulgeRadiusADH.inputValue().asDouble()*DEGTORAD : 0.0;

		// weights array
		dh = inputTargetADH.inputValue();
		cdh = dh.child(weightsAttr);
		MArrayDataHandle weightsADH(cdh);

		// eye matrix
		cdh = dh.child(eyeMatrixAttr);
		eyeMatrix = cdh.asMatrix();

		// eye parent matrix
		cdh = dh.child(eyeParentMatrixAttr);
		eyeMatrix *= cdh.asMatrix();
		eyeMatrix *= invGeoMatrix;
		invEyeMatrix = eyeMatrix.inverse();

		// bulge deformation
		if (bulgeDisplacement != 0.0 && bulgeRadius != 0.0) {
			// loop through the affected points (bulging)
			for (i=0; !iter.isDone(); i++, iter.next()) {
				idx = iter.index();

				// get the weight
				weight = (weightsADH.jumpToElement(idx) == MStatus::kSuccess)? weightsADH.inputValue().asFloat() : 1.0;
				
				if (weight > EPSILON) {
					tmpVector = origPoints[i]*invEyeMatrix;
					tmpVector.normalize();
					
					// get angle from z axis
					angleFromEye = acos(tmpVector.z);

					if (angleFromEye < bulgeRadius)
						defVectors[i] += tmpVector*(bulgeDisplacement*weight*getFalloffValue(angleFromEye/bulgeRadius))*eyeMatrix;
				}
			}
			iter.reset();
		}
	}

	
	// envelope blending pass
	for (i=0; i < pointCount; i++) {
		defVector = &defVectors[i];

		if (*defVector == MVector::zero)
			continue;

		// set the final position of this point
		origPoints[i] += (*defVector);
	}

	// set the compute displacements back to stored
	if (computeDisplacements == -1) {
		computeDisplacementsDH.set(1);
		MGlobal::displayInfo("[" + name() + "] maxDisplacement values have been stored successfully.");
	}

	// set the final positions
	iter.setAllPositions(origPoints, MSpace::kObject);
	
	return status;
}

// Convert from cartesian to spherical coordinates
void radialBlendShape::toSpherical(MPoint& point, MPoint& outPoint) {
	// radius
	outPoint.x = sqrt(point.x*point.x + point.y*point.y + point.z*point.z);
	// phi (azimuth)
	outPoint.y = atan2(point.y, point.z);
	// theta (polar angle)
	outPoint.z = acos(point.x/outPoint.x);
}

// Convert from spherical to cartesian coordinates
void radialBlendShape::toCartesian(MPoint& point, MPoint& outPoint) {
	outPoint.x = point.x*cos(point.z);
	outPoint.y = point.x*sin(point.z);
	outPoint.z = outPoint.y*cos(point.y);
	outPoint.y *= sin(point.y);
}

// Linear interpolation
void radialBlendShape::linearBlend(MVector& p1, MVector& p2, double blend, MVector& outPoint) {
	outPoint.x = (p2.x - p1.x)*blend + p1.x;
	outPoint.y = (p2.y - p1.y)*blend + p1.y;
	outPoint.z = (p2.z - p1.z)*blend + p1.z;
}

// Blend two spherical coordinates in the shortest path
void radialBlendShape::sphericalBlend(MPoint& p1, MPoint& p2, double blend, MPoint& outPoint) {
	outPoint.x = (p2.x - p1.x)*blend + p1.x;

	double diff = p2.y - p1.y;
	if (diff > PI)
		diff -= TWOPI;
	else if (diff < -PI)
		diff += TWOPI;

	outPoint.y = diff*blend + p1.y;
	outPoint.z = (p2.z - p1.z)*blend + p1.z;
}

// Follow eyelid contribute to the blend value
double radialBlendShape::followBlend(double normEyeRotX, double openVal, double closeVal, bool isUpper, double follow) {
	if (follow == 0.0 || normEyeRotX == 0.0)
		return 0.0;

	// if it's lower flip the curve horizontally, so I have the close ramp (positive blend values)
	// always to the right and the open ramp (negative blending values) to the left
	if (!isUpper)
		normEyeRotX *= -1;

	if ((normEyeRotX > 0.0 && closeVal == 0.0) || (normEyeRotX < 0.0 && openVal == 0.0))
		return 0.0;

	double minVal, maxVal, normMinVal, t;
	// bezier points and line points
	Point p1, p2, p3, p4, pStart, pEnd;

	if (openVal > closeVal) {
		maxVal = openVal;
		minVal = closeVal;
	}
	else {
		minVal = openVal;
		maxVal = closeVal;
	}

	normMinVal = minVal/maxVal;
	
	// close (positive) ramp
	if (normEyeRotX > 0.0) {
		p4.x = 1.0;
		p3.x = 0.8;
		p3.y = p4.y = (closeVal == maxVal)? 1.0 : normMinVal;
		p2.x = 0.3 + 0.05*normMinVal;
		p2.y = normMinVal*0.5;
	}
	// open (negative) ramp
	else {
		p1.x = -1.0;
		p2.x = -0.8;
		p1.y = p2.y = (openVal == maxVal)? -1.0 : -normMinVal;
		p3.x = -0.3 - 0.05*normMinVal;
		p3.y = -normMinVal*0.5;
	}

	// break once found the right t value on the bezier
	pEnd = p1;
	for (t=0.01; t<1.01; t += 0.01) {
		pStart = pEnd;
		bezier(p1, p2, p3, p4, t, pEnd);
		if (pEnd.x > normEyeRotX)
			break;
	}

	// solve the line equation for x=normEyeRotX
	return ((normEyeRotX - pStart.x)*(pEnd.y - pStart.y)/(pEnd.x - pStart.x) + pStart.y)*maxVal*follow;
}

// bulge dropoff function
double radialBlendShape::getFalloffValue(double d) {
	unsigned int i = (unsigned int) (d*segments);
	return (d-step*i)*(bulgeFalloff[i+1]-bulgeFalloff[i])/step + bulgeFalloff[i];
}

// cubic bezier function
void radialBlendShape::bezier(Point& p1, Point& p2, Point& p3, Point& p4, double t, Point& outPoint) {
	double r = 1-t;
	outPoint.x = r*r*r*p1.x + 3*t*r*r*p2.x + 3*t*t*r*p3.x + t*t*t*p4.x;
	outPoint.y = r*r*r*p1.y + 3*t*r*r*p2.y + 3*t*t*r*p3.y + t*t*t*p4.y;
}

// max function
const double& radialBlendShape::maxd(const double& a, const double& b) {
	return (a<b)?b:a;
}

// min function
const double& radialBlendShape::mind(const double& a, const double& b) {
	return (a>b)?b:a;
}

// set the 7 CVs of the spline from the 3 offset values
void radialBlendShape::setSplineCVs(double h0, double h1, double h2, Point *cvs) {
	// the x values are set in the constructor, they never change
	// the y values depend on the offset controls (in, mid, out)
	cvs[0].y = h0;
	cvs[1].y = h0;
	cvs[2].y = (h1 + h0)*0.5;
	cvs[3].y = h1;
	cvs[4].y = (h1 + h2)*0.5;
	cvs[5].y = h2;
	cvs[6].y = h2;
}

// find the 3 coefficients of the quadratic function from the 3 given points
void radialBlendShape::setQuadCoefficients(Point& p0, Point& p1, Point& p2, double *coeffs) {
	coeffs[0] = 0.5*((p2.y - p1.y) / (p2.x - p1.x) - (p1.y - p0.y) / (p1.x - p0.x)) / (p2.x - p0.x);
	coeffs[1] = (p2.y - p0.y - coeffs[0] * (p2.x*p2.x - p0.x*p0.x)) / (p2.x - p0.x);
	coeffs[2] = p0.y - coeffs[0] * p0.x*p0.x - coeffs[1] * p0.x;
}

// solve the quadratic function
double radialBlendShape::getQuadValue(double x, double *coeffs) {
	return coeffs[0]*x*x + coeffs[1]*x + coeffs[2];
}

// find the 9 coefficients of the spline
void radialBlendShape::setSpline(double h0, double h1, double h2, double *coeffs) {
	setSplineCVs(h0, h1, h2, quadCVs);

	setQuadCoefficients(quadCVs[0], quadCVs[1], quadCVs[2], coeffs);
	setQuadCoefficients(quadCVs[2], quadCVs[3], quadCVs[4], coeffs + 3);
	setQuadCoefficients(quadCVs[4], quadCVs[5], quadCVs[6], coeffs + 6);
}

// solve the spline from the 3 given quadratic functions
double radialBlendShape::getSplineValue(double x, double *allCoeffs) {
	// clamp [-1, +1]
	x = maxd(mind(x, 1.0), -1.0);

	// select the spline to solve
	if (x < -ONETHIRD)
		return getQuadValue(x, allCoeffs);

	else if (x < ONETHIRD)
		return getQuadValue(x, allCoeffs+3);

	else
		return getQuadValue(x, allCoeffs+6);
}

// maximum orig-target distance along the azimuth for a given shape
double radialBlendShape::setMaxSphericalDisplacement(MItGeometry& iter, MFnMesh& targetMesh, MMatrix& invLocMatrix, MDataHandle& maxDisplacementDH) {
	unsigned int i;
	int idx;
	double maxDistance = -1.0;
	double dist;
	MPoint origPoint, origPointLSSph, targetPoint, targetPointLSSph;

	// loop through the affected points (eyelid blending)
	for (i=0; !iter.isDone(); i++, iter.next()) {
		idx = iter.index();

		// get original and target points in object space
		origPoint = iter.position();
		targetMesh.getPoint(idx, targetPoint, MSpace::kObject);

		// if the target point is not equal to the original point, then do the blend calculation
		if (fabs(targetPoint.x - origPoint.x) > EPSILON || fabs(targetPoint.y - origPoint.y) > EPSILON || fabs(targetPoint.z - origPoint.z) > EPSILON) {
			// point in locator space
			origPoint *= invLocMatrix;
			targetPoint *= invLocMatrix;

			// convert to spherical coordinates
			toSpherical(origPoint, origPointLSSph);
			toSpherical(targetPoint, targetPointLSSph);

			dist = fabs(targetPointLSSph.y - origPointLSSph.y);
			if (dist > maxDistance)
				maxDistance = dist;
		}
	}
	iter.reset();

	// set the attribute value
	maxDisplacementDH.set(maxDistance);

	return maxDistance;
}

// Initialize
MStatus initializePlugin(MObject obj) {
	MStatus result;
	MFnPlugin plugin(obj, "Paolo Dominici (paolodominici@gmail.com)", "3.0.0", "Any");
	result = plugin.registerNode("radialBlendShape", radialBlendShape::id, radialBlendShape::creator, radialBlendShape::initialize, MPxNode::kDeformerNode);
	return result;
}

// Uninitialize
MStatus uninitializePlugin(MObject obj) {
	MStatus result;
	MFnPlugin plugin(obj);
	result = plugin.deregisterNode(radialBlendShape::id);
	return result;
}
