// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.
#ifndef XGRENDERAPI_H
#define XGRENDERAPI_H
//-
// ==================================================================
// ==================================================================
//+
//
// An XGen render procedural is split in 2 parts.
// A top level patch procedural API will have the responsibility of generating child procedurals for each face.
// The child procedural will be called with smaller bounding boxes. That first step is pretty easy to implement.
// The implementation of the face procedural starts with the invocation of a Render() method.
//
//

/*

// User Implementation of ProceduralCallbacks
class MyRendererCallbacks : public ProceduralCallbacks
{
...
};

// API Usage pseudo code.
// How to use the PatchRenderer and FaceRenderer from the Procedural DSO.
void Procedural( unsigned int in_faceID, const cahr* in_xgen_args, void* in_data )
{
  static MyRendererCallbacks cb;

  if( in_faceID == -1 )
  {
    PatchRenderer* patch =  PatchRenderer::Init( &cb, in_xgen_args );

    float subBBox[6];
    unsigned int faceID = -1;
    while( patch->NextFace( subBBox, faceID ) )
    {
      // Declare a nested procedural for the bounding box and faceid.
      FaceRenderer* face = FaceRenderer::Init( patchRender, in_faceID );

      // Missing renderer specific code to create a Procedural Geometry to fit in subBBox.
      // For Renderman, it would be a call to something like:
      // RiProcedural((RtPointer)face, bound, Subdivide, Free);
    }
  }
  else
  {
    FaceRenderer* face = (FaceRenderer*)in_data;

    // The face renderer class will call the MyRendererCallbacks as needed.
    face->render();
  }
}
*/

#include "XgWinExport.h"

namespace XGenRenderAPI
{

// Interface
#define interface struct

// Declare virtual Dtor
#define interface_methods( X ) \
	virtual ~X() {}

// Forward Declarations
interface PrimitiveCache;
interface ProceduralCallbacks;

// Typedefs and simple structures
struct vec3{ float x,y,z; };

struct mat44 { // Column first matrix
	float _00,_10,_20,_30;
	float _01,_11,_21,_31;
	float _02,_12,_22,_32;
	float _03,_13,_23,_33;
};

struct bbox
{
	double xmin, xmax;
	double ymin, ymax;
	double zmin, zmax;
};

// Attribute Getters Declaration macros
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  A simple attribute has only a get method that return the data directly.
//   DECL(float,EFloatAttribute); -> virtual float get( EFloatAttribute )const = 0;
#define DECL(t,e) virtual t get( e ) const = 0

//
//  A 1D array attribute has a get() method returning a const pointer to the start of the array
//  and a getSize() method returning the number of elements in the array.
//
#define DECL_ARRAY_1D(t,e) virtual const t * get( e ) const = 0; \
						   virtual unsigned int getSize( e ) const = 0
//
//  A 1D array of string has a get(unsigned int) method taking an index and returning a const char*.
//	We do that to avoid the use of a const char**.
//
#define DECL_ARRAY_1D_STR(e) virtual const char* get( e, unsigned int ) const = 0; \
							 virtual unsigned int getSize( e ) const = 0
//
//  A 2D array attribute has a get(unsigned int) method returning a const pointer to the start of the array at the given index.
//  and a getSize() method returning the number of 1D arrays in the 2D array,
//  and a getSize2(unsigned int) method returning the number of elements in the 1D array at the given index.
//
#define DECL_ARRAY_2D(t,e) virtual const t * get( e, unsigned int ) const = 0; \
						   virtual unsigned int getSize( e ) const = 0; \
						   virtual unsigned int getSize2( e, unsigned int ) const = 0

// A render description wrapper
// We can't return an internal pointer to XgDescription since it returns std::strings 
// and it doesn't work nice across dll on windows. 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface Description
{
public:
	interface_methods( Description );

	// String attributes
	enum EStringAttribute {
		PrimitiveType = 0,
	};
	DECL( const char*, EStringAttribute );
};

// A patch render
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface XGEN_EXPORT PatchRenderer
{
public:
	interface_methods( PatchRenderer );

	// Init a new patch renderer.
	// Follow the Xgen Renderman documentation for in_xgen_args formatting.
	static PatchRenderer* init( ProceduralCallbacks* in_cb, const char* in_xgen_args );

	// Get the next face id.
	// The current face id gets reinitialized when io_uiFaceID=-1 in input.
	// A face bounding box is returned in out_bbox.
	// Use the faceid/bbox and the current PatchRenderer pointer to initialize
	// a new FaceRenderer.
	// It returns true until the last face is reached.
	// It can return an empty bounding box when inCameraOnly is enabled and the face is culled by the camera.
	// The face bounding box also takes into account the motion samples if motion blur is used.
	virtual bool nextFace( bbox& out_bbox, unsigned int& io_uiFaceID ) = 0;

	// Access the XGen Description being used for the patch.
	// Use it to retrieve the list of archives files, or any data that needs pre processing when rendering.
	virtual Description* getDescription() const = 0;

	// Compute the bounding box for the current patch.
	// A patch bounding box is returned in out_bbox.
	// The bounding box is extended by the primitive bounding box buffer.
	// The patch bounding box also takes into account the motion samples if motion blur is used.
	virtual bool boundingBox( bbox& out_bbox, bool pref=false ) = 0;

	// Compute the bounding box for the current patch at the specified sample.
	// A patch bounding box is returned in out_bbox.
	// The bounding box is extended by the primitive bounding box buffer.
	virtual bool motionBoundingBox( bbox& out_box, unsigned int sample, bool pref=false ) = 0;
};

// A face renderer is created by enumerating the Faces on the PatchRenderer.
// It will take a snapshot of the state of the PatchRenderer.
// It will also inherit the xgen args and ProceduralCallbacks from the patch.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface XGEN_EXPORT FaceRenderer
{
public:
	interface_methods( FaceRenderer );

	// Init a new FaceRenderer.
	// Use the returned values from PatchRenderer::NextFace()
	// If in_cb isn't NULL, it will use a per face procedural callback instead.
	static FaceRenderer* init( PatchRenderer* in_pPatchRenderer, unsigned int uiFaceID, ProceduralCallbacks* in_cb=NULL );

	// Call Render from the recursive procedural.
	// It will end up calling the Flush() callback on ProceduralCallbacks.
	virtual bool render() = 0;
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// User Defined Callbacks to implement a custom XGen procedural.
//  This virtual class needs to be implemented and given to PatchRenderer::init() method.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
interface ProceduralCallbacks
{
public:
	interface_methods( ProceduralCallbacks );

	// XGen asks the Procedural Callback to flush the current primitive cache.
	virtual void flush( const char* in_geom, PrimitiveCache* in_cache )=0;

	// XGen will log messages using the following callback.
	virtual void log( const char* in_str )=0;

	// XGen can query data using the get functions.
	// The get methods should return global render option or render attributes
	// from the current rendered scene.
	// In Renderman the data is stored in the rib using RiOption or RiAttribute and
	// accessed at runtime using RxOption or RxAttribute.
	// It's up to the third party to decide where to store it.
	// Could be as a shader parameter, a global user data or even hardcoded
	// TODO: DOCUMENT THE ATTRIBUTES
	// The attributes are documented in the XGen Renderman Procedural dso documentation.

	// Bool Attributes
	enum EBoolAttribute
	{
		// Return true when the Procedural wants the cache of descriptions cleared.
		// Its only meaningful when render is done on the same process multiple times and the active objects change on on of the description.
		// The cache is used to avoid recreating the same description multiple times when rendering multiple patches.
		ClearDescriptionCache = 0,

		// Return true if the Procedural doesn't want to use ref counting of palettes.
		// This will let palettes leak and the procedural won't be able to render multiple frames on the same process.
		DontUsePaletteRefCounting = 1,
	};
	DECL( bool, EBoolAttribute );

	// Float Attributes
	enum EFloatAttribute
	{
		ShadowMotionBlur = 0,
		ShutterOffset = 1,
	};
	DECL( float, EFloatAttribute );

	// String Attributes
	enum EStringAttribute
	{
		BypassFXModulesAfterBGM = 0,
		CacheDir = 1,
		Generator	= 2,
		Off = 3,
		Phase = 4,
		RenderCam = 5,
		RenderCamFOV = 6,
		RenderCamRatio = 7,
		RenderCamXform = 8,
		RenderMethod = 9,
	};
	DECL( const char*, EStringAttribute );

	// Float Array Attributes
	enum EFloatArrayAttribute
	{
		DensityFalloff = 0,
		LodHi = 1,
		LodLow = 2,
		LodMed = 3,
		Shutter = 4,
	};
	DECL_ARRAY_1D( float, EFloatArrayAttribute );


	// getOverride
	//  A user render attribute can override the expression of an xgen attribute.
	//  For example, if you code this method to return “2.0*( $originalExpr )”
	//  when in_name==”length” then length is going to be multiply by 2.
	//  Again, it's up to the third party to decide how to implement that.
	//  In Renderman, it's implemented with a string RiAttribute formatted
	//  like : “user:xgen_” + in_name
	//  and a RxAttribute call is used to query the value at runtime.
	// Return an override expression for the in_name attribute.
	// Return NULL to avoid overriding the in_name attribute.
	virtual const char* getOverride( const char* in_name )const = 0;

	// getTransform
	//  Returns the current object transform in world space at the given normalized shutter time.
	//  In Renderman, this maps to a call:
	//   RxTransform( const_cast<char*>("object"), const_cast<char*>("world"), in_time, out_mat );
	virtual void getTransform( float in_time, mat44& out_mat ) const = 0;

	// getArchiveBoundingBox
	// The original XGen Renderman procedural was parsing the first lines of rib files for a BBOX comment.
	// fscanf(fd, "## BBOX %lf %lf %lf %lf %lf %lf", &xmin, &xmax, &ymin, &ymax, &zmin, &zmax);
	// A renderer might have a better way to query an archive bounding box from a filename.
	//  Returns the bounding box for the archive file in out_bbox. ( min_x, max_x, min_y, max_y, min_z, max_z ).
	//  Returns true if it succeeded, false otherwise.
	// The calls to ProceduralCallbacks::getArchiveBoundingBox() are cached internally, so the method should get called only one time per filename.
	// The cache can be used by calling PrimitiveCache::getArchiveBoundingBox() which returns the cached bounding box or query it using this method if it has not been called.
	//  If false is returned, it will use a default bounding box of( -0.5, 0.5, 0.0, 1.0, -0.5, 0.5 ).
	virtual bool getArchiveBoundingBox( const char* in_filename, bbox& out_bbox )const = 0;
};

////////////////////////////////////////////////////////////////////////////////////////////////////
// The PrimitiveCache represents a list of primitives to be drawn by the flush() callback.
// Each primitive has 'NumVertices' vertices repeated 'NumMotionSamples' times.
// 'Points', 'Norms' and 'Width' have values for each vertex/motion samples.
// All other array attributes have one value per primitive.
//
// Contexts
////////////////////////////////////////////////////////////////////////////////////////////////////
// Some attributes have a suffix append at the end of their name.
//  '_XP' Primitive attribute. Constant for the whole primitive.
//  '_XS' Surface attribute. Transfered at UV location and constant for the whole primitive.
//
////////////////////////////////////////////////////////////////////////////////////////////////////
// Globals
////////////////////////////////////////////////////////////////////////////////////////////////////
//  bool	FlipParam			Coordinate system switching. (NEED MORE DOC)
//
////////////////////////////////////////////////////////////////////////////////////////////////////
// Motion Blur
////////////////////////////////////////////////////////////////////////////////////////////////////
//  int		NumMotionSamples 	The number of motion samples.
//								The control points attributes have samples for each vertices at each motion step.
//  flt[]	Shutter				Shutter time offset for each motion sample. Has an internal limit of 20 values.
//
////////////////////////////////////////////////////////////////////////////////////////////////////
// Primitive
////////////////////////////////////////////////////////////////////////////////////////////////////
//  int		CacheCount			The current number of primitives in a primitive cache. Can't be higher than CacheMax.
//  int		CacheMax			The maximum number of primitives in a priconstmitive cache.
//  bool 	PrimIsArchive		True when handling an archive primitive.
//  bool	PrimIsSpline		True when handling a spline primitive.
//	str		PrimitiveType		"CardPrimitive", "SpherePrimitive", "ArchivePrimitive", "SplinePrimitive"
//  dbl		PrimitiveBound		A global safety offset to put around the primitive bounding boxes.
//  bool	FaceCamera			Hair is facing the camera.
//
////////////////////////////////////////////////////////////////////////////////////////////////////
// Archive Primitive
// Note: Multiple archives can be referenced within a single primitive to form an archive group.
//       Archives, ArchivesAbsolute, ArchivesMaterial, ArchivesObjects strings will be multi-line to represent the group.
//       ArchivesFrame and ArchiveSize are per primitive.
//
////////////////////////////////////////////////////////////////////////////////////////////////////
//  str[]	Archives			Unresolved Archive paths.  
//  str[]	ArchivesAbsolute	Resolved Archive paths.
//  str[]	ArchivesMaterial	Material name reference. The material definition isn't handled by XGen. We assume a name lookup can be performed to access the render material.
//  str[]	ArchivesObjects		Selected object names from an archive file. Separated by spaces.
//  dbl[] 	ArchivesFrame		Animation frame to use in the archive file.
//  dbl 	ArchiveSize			Scaling factor to transform archives into a unit cube.
//
////////////////////////////////////////////////////////////////////////////////////////////////////
// Level of Detail
////////////////////////////////////////////////////////////////////////////////////////////////////
//  int		LodLevels
//  vec3	LoTrans
//  vec3	MaxVis
//  vec3	MinVis
//  vec3	UpTrans
//
////////////////////////////////////////////////////////////////////////////////////////////////////
// Control Points
////////////////////////////////////////////////////////////////////////////////////////////////////
//	Type		Attr
//  vec3[][]	Points			Control Points per motion sample.
//  vec3[][]	Norms			Control Normals per motion sample.
//  float[]		Widths			Widths.
//  int[][]		NumVertices		Number of vertices per primitive per motion sample.
//
//  bool		PointParam		Add Points as shader parameter.
//  bool		NormalParam		Add Norms as shader parameter.
//
//  bool		ConstTaper		Taper is constant or not.
//  bool		ConstWidth 		Width is constant or not.
//  bool		ConstantWidth  	Constant Width value.
//
////////////////////////////////////////////////////////////////////////////////////////////////////
// Primitive Shader Attributes with a boolean switch.
// The boolean switch has 'Add_' prefix. If it's true the attribute should be exported as
// a shader parameter.
////////////////////////////////////////////////////////////////////////////////////////////////////
//	Type		Attr
//  int[]		DescID_XP		Description ID from Primitive.
//  int[]		PrimitiveID_XP	Primitive ID.
//
//  int[]		Stray_XP		Stray from the Description Stray Percentage.
//  float[]		Length_XP		Length from Primitive.
//  float[]		Width_XP		Width without taper from Primitive.
//
//  flt[] 		RandomFloat_XP	Random float from Primitive
//  int[] 		RandomInt_XP	Random int from Primitive
//
////////////////////////////////////////////////////////////////////////////////////////////////////
// Surface Shader Attributes with a boolean switch.
// The boolean switch has 'Add_' prefix. If it's true the attribute should be exported as
// a shader parameter.
////////////////////////////////////////////////////////////////////////////////////////////////////
//	Type		Attr
//  int[]		GeomID_XS		Geometry ID from Surface.
//
//  vec3[] 		P_XS			Position from surface.
//  vec3[]		Pg_XS, 			Position non-displaced from surface.
//  vec3[]		Pref_XS			Position reference from surface.
//  vec3[]		Prefg_XS  		Position reference non-displacedfrom surface.
//
//  vec3[]		N_XS			Normal from surface.
//  vec3[]		Ng_XS			Normal non-displaced from surface.
//  vec3[]		Nref_XS			Normal reference from surface.
//  vec3[]		Nrefg_XS		Normal reference non-displaced from surface.
//
//  flt[]		U_XS			U from surface.
//  flt[]		V_XS			V from surface.
//  int[]		FaceID_XS  		FaceID from surface.
//
//  vec3[]		T_XP			Tangent from surface.
//
//	vec3[]		dPdu_XS 		U Position Derivative from surface.
//	vec3[]		dPdug_XS 		U Position Derivative non-displaced from surface.
//	vec3[]		dPduref_XS 		U Position reference Derivative from surface.
//	vec3[]		dPdurefg_XS 	U Position reference Derivative non-displaced from surface.
//
//	vec3[]		dPdv_XS 		V Position Derivative from surface.
//	vec3[]		dPdvg_XS 		V Position Derivative non-displaced from surface.
//	vec3[]		dPdvref_XS 		V Position reference Derivative from surface.
//	vec3[]		dPdvrefg_XS 	V Position reference Derivative non-displaced from surface.
//
////////////////////////////////////////////////////////////////////////////////////////////////////
// Custom Shader Attributes
////////////////////////////////////////////////////////////////////////////////////////////////////
//  str[]	CustomAttrNames	Custom attribute names. The values for the attribute at index 'i' are at CustomAttrValues[i].
//  flt[][]	CustomAttrValues A 2D float array containing all the custom attributes values.
//
////////////////////////////////////////////////////////////////////////////////////////////////////
interface PrimitiveCache
{
public:
	interface_methods( PrimitiveCache );

	// Boolean Attributes
	enum EBoolAttribute {
		// Shader Parameter Swicthes
		Add_DescID =	0,
		Add_dPdu = 1,
		Add_dPdug = 2,
		Add_dPduref = 3,
		Add_dPdurefg = 4,
		Add_dPdv = 5,
		Add_dPdvg = 6,
		Add_dPdvref = 7,
		Add_dPdvrefg = 8,
		Add_FaceID = 9,
		Add_GeomID = 10,
		Add_GeomName = 11,
		Add_Length = 12,
		Add_N = 13,
		Add_Ng = 14,
		Add_Nref = 15,
		Add_Nrefg = 16,
		Add_P = 17,
		Add_Pg = 18,
		Add_Pref = 19,
		Add_Prefg = 20,
		Add_PrimitiveID = 21,
		Add_RandomFloat = 22,
		Add_RandomInt = 23,
		Add_Stray = 24,
		Add_T = 25,
		Add_U = 26,
		Add_V = 27,
		Add_Width = 28,

		// Other Attributes
		ConstTaper = 29,
		ConstWidth = 30,
		FaceCamera = 31,
		FlipParam = 32,
		NormalParam = 33,
		PointParam = 34,
		PrimIsArchive = 35,
		PrimIsSpline = 36,
	};
	DECL( bool, EBoolAttribute );

	// Double attributes
	enum EDoubleAttribute {
		PrimitiveBound = 0,
		ArchiveSize = 1
	};
	DECL( double, EDoubleAttribute );

	// Float attributes
	enum EFloatAttribute {
		ConstantWidth = 0,
	};
	DECL( float, EFloatAttribute );

	// Int Attributes
	enum EIntAttribute {
		LodLevels = 0,
	};
	DECL( int, EIntAttribute );

	// String attributes
	enum EStringAttribute {
		PrimitiveType = 0,
	};
	DECL( const char*, EStringAttribute );

	// UInt Attributes
	enum EUIntAttribute {
		CacheCount = 0,
		CacheMax = 1,
		NumMotionSamples = 2,
	};
	DECL( unsigned int, EUIntAttribute );

	// Vec3 Attributes
	enum EVec3Attribute {
		LoTrans = 0,
		MaxVis = 1,
		MinVis = 2,
		UpTrans = 3,
	};
	DECL( const vec3&, EVec3Attribute );

	// Bool Array Attributes
	enum EBoolArrayAttribute {
		ArchiveUseLevel = 0
	};
	DECL_ARRAY_1D( bool, EBoolArrayAttribute );

	// Double Array Attributes
	enum EDoubleArrayAttribute {
		ArchivesFrame_XP = 0,
	};
	DECL_ARRAY_1D( double, EDoubleArrayAttribute );

	// Float Array Attributes
	enum EFloatArrayAttribute {
		Length_XP = 0,
		RandomFloat_XP = 1,
		Shutter = 2,
		U_XS = 3,
		V_XS = 4,
		Widths = 5,
		Width_XP = 6,
	};
	DECL_ARRAY_1D( float, EFloatArrayAttribute );

	// Int Array Attributes
	enum EIntArrayAttribute {
		DescID_XP = 0,
		FaceID_XS = 1,
		GeomID_XS = 2,
		PrimitiveID_XP = 3,
		RandomInt_XP = 4,
		Stray_XP = 5,
	};
	DECL_ARRAY_1D( int, EIntArrayAttribute );

	// String Array Attributes
	enum EStringArrayAttribute {
		Archives = 0,
		ArchivesAbsolute = 1,
		ArchivesMaterial = 5,
		ArchivesObjects = 4,
		CustomAttrNames = 2,
		CVAttrNames = 3
	};
	DECL_ARRAY_1D_STR(EStringArrayAttribute);

	// Vec3 Array Attributes
	enum EVec3ArrayAttribute {
		dPdu_XS = 0,
		dPdug_XS = 1,
		dPduref_XS = 2,
		dPdurefg_XS = 3,
		dPdv_XS = 4,
		dPdvg_XS = 5,
		dPdvref_XS = 6,
		dPdvrefg_XS = 7,
		N_XS = 8,
		Ng_XS = 9,
		Nref_XS = 10,
		Nrefg_XS = 11,
		P_XS = 12,
		Pg_XS = 13,
		Pref_XS = 14,
		Prefg_XS = 15,
		T_XP = 16,
	};
	DECL_ARRAY_1D( vec3, EVec3ArrayAttribute );

	// Float 2D Array Attributes
	enum EFloatArray2DAttribute {
		CustomAttrValues = 0,
		CVAttrValues = 1,
	};
	DECL_ARRAY_2D( float, EFloatArray2DAttribute );

	// Int 2D Array Attributes
	enum EIntArray2DAttribute {
		NumVertices = 0,
	};
	DECL_ARRAY_2D( int, EIntArray2DAttribute );

	// Vec3 2D Array Attributes
	enum EVec3Array2DAttribute {
		Norms = 0,
		Points = 1,
	};
	DECL_ARRAY_2D( vec3, EVec3Array2DAttribute );

	// Transform the point, vector and normal shader parameters using the
	// inverse of primitive specific transformation. This is needed to
	// remove any transformation that not affecting the underlying primitive.
	// This should be called before writing shader parameters.
	// It affects:
	//  P_XS, Pg_XS, Pref_XS, Prefg_XS
	//  N_XS, Ng_XS, Nref_XS, Nrefg_XS
	//  dPdu_XS, dPdug_XS, dPduref_XS, dPdurefg_XS, dPdv_XS, dPdvg_XS, dPdvref_XS, dPdvrefg_XS
	// As well as custom shader parameters with names containing one of the following substrings:
	//  " point ", " point[", " vector ", " vector[", " normal ", " normal["
	//
	// @param i index into param array
	// @param xP transform for points and vectors
	// @param xN transform for normals
	virtual void inverseXformParams( int i, mat44& xP, mat44& xN ) = 0;

	// getArchiveBoundingBox
	//  Returns the cached bounding box for the archive file in out_bbox.
	//  or queries it using ProceduralCallbacks::getArchiveBoundingBox() if it's not cached.
	//  Returns true if it succeeded, false otherwise.
	//  XGen requires the archive bounding box during geometry generation and the user also needs it when declaring a delayed archive.
	//  The same cache can be shared between the two.
	virtual bool getArchiveBoundingBox( const char* in_filename, bbox& out_bbox )= 0;
};

#undef DECL
#undef DECL_ARRAY_1D
#undef DECL_ARRAY_1D_STR
#undef DECL_ARRAY_2D
#undef interface
#undef interface_methods

};

#endif

