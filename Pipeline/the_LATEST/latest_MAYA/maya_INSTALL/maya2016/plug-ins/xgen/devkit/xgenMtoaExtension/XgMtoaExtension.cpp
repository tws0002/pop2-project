// Copyright 2013 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

#define DLLEXPORT

#include <extension/Extension.h>
#include <utils/time.h>

#include <maya/MFileObject.h>

#include "XgMtoaExtension.h"

#include <string>


#ifdef _WIN32
#define PATH_SEPARATOR "\\"
#else
#define PATH_SEPARATOR "/"
#endif

//#define DEBUG_MTOA

using namespace std;

extern "C"
{

DLLEXPORT void initializeExtension(CExtension& extension)
{
	MStatus status;

	extension.Requires("xgenToolkit");
	status = extension.RegisterTranslator("xgmDescription",
		 "",
		 CXgDescriptionTranslator::creator, CXgDescriptionTranslator::NodeInitializer);
}

DLLEXPORT void deinitializeExtension(CExtension& extension)
{
}

}

AtNode* CXgDescriptionTranslator::CreateArnoldNodes()
{
	//AiMsgInfo("[CXgDescriptionTranslator] CreateArnoldNodes()");
	return AddArnoldNode("ginstance");
}

void CXgDescriptionTranslator::Export(AtNode* instance)
{
	//AiMsgInfo("[CXgDescriptionTranslator] Exporting %s", GetMayaNodeName().asChar());
	Update(instance);
}

struct DescInfo
{
	string strScene;
	string strPalette;
	string strDescription;
	vector<string> vecPatches;
	float fFrame;

	bool  bCameraOrtho;
	float fCameraPos[3];
	float fCameraFOV;
	float fCameraInvMat[16];
	float fCamRatio;
	float fBoundingBox[6];

	void setBoundingBox( float xmin, float ymin, float zmin, float xmax, float ymax, float zmax )
	{
		fBoundingBox[0] = xmin;
		fBoundingBox[1] = ymin;
		fBoundingBox[2] = zmin;

		fBoundingBox[3] = xmax;
		fBoundingBox[4] = ymax;
		fBoundingBox[5] = zmax;
	}

	void setCameraPos( float x, float y, float z )
	{
		fCameraPos[0] = x;
		fCameraPos[1] = y;
		fCameraPos[2] = z;
	}

	void setCameraInvMat( 	float m00, float m01, float m02, float m03,
							float m10, float m11, float m12, float m13,
							float m20, float m21, float m22, float m23,
							float m30, float m31, float m32, float m33 )
	{
		fCameraInvMat[ 0] = m00;
		fCameraInvMat[ 1] = m01;
		fCameraInvMat[ 2] = m02;
		fCameraInvMat[ 3] = m03;
		fCameraInvMat[ 4] = m10;
		fCameraInvMat[ 5] = m11;
		fCameraInvMat[ 6] = m12;
		fCameraInvMat[ 7] = m13;
		fCameraInvMat[ 8] = m20;
		fCameraInvMat[ 9] = m21;
		fCameraInvMat[10] = m22;
		fCameraInvMat[11] = m23;
		fCameraInvMat[12] = m30;
		fCameraInvMat[13] = m31;
		fCameraInvMat[14] = m32;
		fCameraInvMat[15] = m33;
	}
};

void CXgDescriptionTranslator::Update(AtNode* instance)
{
	//AiMsgInfo("[CXgDescriptionTranslator] Update()");

	// Export the transform matrix
	ExportMatrix(instance, 0);

	// Get the visibiliy and render flags set.
	ProcessRenderFlags(instance);

	// Build the path to the procedural dso
	static string strDSO = string(getenv("MTOA_PATH")) + string("/procedurals/libXgArnoldProcedural.so");

	// Get strings based on the current scene name.
	string strScenePath; // The path to the directory containing the scene.
	string strSceneFile; // The filename of the scene with the extension.
	string strSceneName; // The filename of the scene without the extension.
	{
		MString mstrCurrentScene;
		MGlobal::executeCommand("file -q -sn", mstrCurrentScene);
#ifdef DEBUG_MTOA
		printf("mstrCurrentScene=%s\n",mstrCurrentScene.asChar() );
#endif
		MFileObject fo;
		fo.setRawFullName( mstrCurrentScene );

		strScenePath = fo.resolvedPath().asChar();
		strSceneFile = fo.resolvedName().asChar();
		strSceneName = strSceneFile.substr( 0, strSceneFile.size()-3 );
	}

#ifdef DEBUG_MTOA
	printf("strDSO=%s\n",strDSO.c_str() );
	printf("strScenePath=%s\n",strScenePath.c_str() );
	printf("strSceneFile=%s\n",strSceneFile.c_str() );
	printf("strSceneName=%s\n",strSceneName.c_str() );
#endif

	// Get current units
	string strUnitConvMat;
	float fUnitConvFactor = 1.f;
	{
		string strCurrentUnits;
		{
			MString mstrCurrentUnits;
			MGlobal::executeCommand("currentUnit -q -linear", mstrCurrentUnits);
			strCurrentUnits = mstrCurrentUnits.asChar();
		}


		static map<string, pair<string,float> > s_mapUnitsConv;
		if( s_mapUnitsConv.empty() )
		{
			s_mapUnitsConv["in"] = pair<string,float>( "2.54", 2.54 );
			s_mapUnitsConv["ft"] = pair<string,float>( "30.48", 30.48 );
			s_mapUnitsConv["yd"] = pair<string,float>( "91.44", 91.44 );
			s_mapUnitsConv["mi"] = pair<string,float>( "160934.4", 160934.4 );
			s_mapUnitsConv["mm"] = pair<string,float>( "0.1", 0.1f );
			s_mapUnitsConv["km"] = pair<string,float>( "100000.0", 100000. );
			s_mapUnitsConv["m"] =  pair<string,float>( "100.0", 100. );
			s_mapUnitsConv["dm"] = pair<string,float>( "10.0", 10. );
		}

		string factor = "1";
		map<string, pair<string,float> >::const_iterator it = s_mapUnitsConv.find( strCurrentUnits );
		if( it!=s_mapUnitsConv.end() )
		{
			factor = it->second.first;
			fUnitConvFactor = it->second.second;
		}
		strUnitConvMat = " -world "+factor+";0;0;0;0;"+factor+";0;0;0;0;"+factor+";0;0;0;0;1";
	}

	// Extract description info from the current maya shape node.
	DescInfo info;
	{
		// Get Description and Palette from the dag paths.
		// The current dag path points to the desciption.
		// We get the parent to get the palette name.
		{
			MDagPath palDagPath = m_dagPath;
			palDagPath.pop();
			palDagPath.pop();
			info.strPalette = palDagPath.fullPathName().asChar();
			info.strPalette = info.strPalette.substr( 1 );
#ifdef DEBUG_MTOA
			printf("strPalette=%s\n",info.strPalette.c_str() );
#endif

			MDagPath descDagPath = m_dagPath;
			descDagPath.pop();
			info.strDescription = descDagPath.fullPathName().asChar();
			info.strDescription = info.strDescription.substr( 1 + info.strPalette.size() + 1 );
#ifdef DEBUG_MTOA
			printf("strDescription=%s\n",info.strDescription.c_str() );
#endif
			unsigned int c = descDagPath.childCount();
			for( unsigned int i=0; i<c; ++i )
			{
				MDagPath childDagPath;
				MDagPath::getAPathTo( descDagPath.child(i),childDagPath );

				string strChild = childDagPath.fullPathName().asChar();
				strChild = strChild.substr( 1+ info.strPalette.size() + 1 + info.strDescription.size() + 1 );

				// Ignore the first child. It should be the description shape
				if( i==0 )
				{
#ifdef DEBUG_MTOA
					printf("strChild=%s\n",strChild.c_str() );
#endif
				}
				// Look for patches
				else
				{
					// Perform a check on the description suffix.
					string strCheckDesc = strChild.substr( strChild.size()-info.strDescription.size() );
#ifdef DEBUG_MTOA
					printf( "%s == %s\n", strCheckDesc.c_str(), info.strDescription.c_str() );
#endif
					if( strCheckDesc == info.strDescription )
					{
						strChild = strChild.substr( 0, strChild.size() - (info.strDescription.size() + 1) );
#ifdef DEBUG_MTOA
						printf("strPatch=%s\n",strChild.c_str() );
#endif
						info.vecPatches.push_back( strChild );
					}
				}
			}
		}

		info.strScene = strScenePath + strSceneName;
		info.fFrame = MAnimControl::currentTime().value();

		// Hardcoded values for now.
		float s = 10000.f * fUnitConvFactor;
		info.setBoundingBox( -s,-s,-s, s, s, s );
		info.bCameraOrtho = false;
		info.setCameraPos( -48.4233, 29.8617, -21.2033 );
		info.fCameraFOV = 54.432224;
		info.setCameraInvMat( -0.397148,0.446873,0.80161,0,5.55112e-17,0.873446,-0.48692,0,0.917755,0.193379,0.346887,0,0.228188,-0.343197,60.712,1 );
		info.fCamRatio = 1.0;
	}

	char buf[512];

	AtNode* rootShader = NULL;

	// The geom cache file should contain all the patches the palette uses.
	// Xgen gives an error if a patch used in the palette isn't found: Caf error. No geometry named 'pPlane1' found in caf file(frame):
	string strGeomFile = info.strScene + "__" + info.strPalette + ".caf";

	for( unsigned int i=0; i<info.vecPatches.size(); ++i )
	{
		const string& strPatch = info.vecPatches[i];

		// Create a nested procedural node
		AtNode* shape = AiNode("procedural");
		AiNodeSetStr(shape, "name", NodeUniqueName(shape, buf));

		// First patch, we use current ginstance, and create the shaders
		if( i==0 )
		{
			AiNodeSetPtr( instance, "node", shape );

			// Export shaders
			rootShader = ExportShaders( instance );
		}
		// For other patches we reuse the shaders and create new ginstance
		else
		{
			AtNode* otherInstance = AiNode("ginstance");
			AiNodeSetStr(otherInstance, "name", NodeUniqueName(otherInstance, buf));
			AiNodeSetPtr( otherInstance, "node", shape );
			AiNodeSetPtr( otherInstance, "shader", rootShader );

			ExportMatrix(otherInstance, 0);
			ProcessRenderFlags(otherInstance);
		}

		AiNodeSetPtr( shape, "shader", rootShader );

		// Set the procedural arguments
		{
			// Build the data argument
			string strData;
			strData =  "-debug 1 -warning 1 -stats 1 ";
			sprintf(buf,"%f",info.fFrame );
			strData += " -frame "+ string(buf) +" -shutter 0.0";
			strData += " -file " + info.strScene + "__" + info.strPalette + ".xgen";
			strData += " -palette " + info.strPalette;
			strData += " -geom " + strGeomFile;
			strData += " -patch " + strPatch;
			strData += " -description " + info.strDescription;

			strData += strUnitConvMat;

#ifdef DEBUG_MTOA
			printf("strData=%s\n",strData.c_str() );
#endif
			// Set other arguments
			AiNodeSetBool( shape, "load_at_init", false );
			AiNodeSetStr( shape, "dso", strDSO.c_str() );
			AiNodeSetStr( shape, "data", strData.c_str() );
			AiNodeSetPnt( shape, "min", info.fBoundingBox[0], info.fBoundingBox[1], info.fBoundingBox[2] );
			AiNodeSetPnt( shape, "max", info.fBoundingBox[3], info.fBoundingBox[4], info.fBoundingBox[5] );

			AiNodeDeclare( shape, "irRenderCam", "constant STRING" );
			AiNodeDeclare( shape, "irRenderCamFOV", "constant STRING" );
			AiNodeDeclare( shape, "irRenderCamXform", "constant STRING" );
			AiNodeDeclare( shape, "irRenderCamRatio", "constant STRING" );

			sprintf(buf,"%s,%f,%f,%f", info.bCameraOrtho? "true":"false", info.fCameraPos[0], info.fCameraPos[1], info.fCameraPos[2] );
			AiNodeSetStr( shape, "irRenderCam", buf );

			sprintf(buf,"%f", info.fCameraFOV );
			AiNodeSetStr( shape, "irRenderCamFOV",buf );

			sprintf(buf,"%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f",
					info.fCameraInvMat[0],info.fCameraInvMat[1],info.fCameraInvMat[2],info.fCameraInvMat[3],
					info.fCameraInvMat[4],info.fCameraInvMat[5],info.fCameraInvMat[6],info.fCameraInvMat[7],
					info.fCameraInvMat[8],info.fCameraInvMat[9],info.fCameraInvMat[10],info.fCameraInvMat[11],
					info.fCameraInvMat[12],info.fCameraInvMat[13],info.fCameraInvMat[14],info.fCameraInvMat[15] );
			AiNodeSetStr( shape, "irRenderCamXform",buf );

			sprintf(buf,"%f", info.fCamRatio );
			AiNodeSetStr( shape, "irRenderCamRatio", buf );
		}
	}
}

void CXgDescriptionTranslator::ExportMotion(AtNode* shape, unsigned int step)
{
	// Check if motionblur is enabled and early out if it's not.
	if (!IsMotionBlurEnabled()) return;

	// Set transform matrix
	ExportMatrix(shape, step);
}

void CXgDescriptionTranslator::NodeInitializer(CAbTranslator context)
{
	CExtensionAttrHelper helper(context.maya, "ginstance");
	CShapeTranslator::MakeCommonAttributes(helper);
}

AtNode* CXgDescriptionTranslator::ExportShaders(AtNode* instance)
{
   MPlug shadingGroupPlug = GetNodeShadingGroup(m_dagPath.node(), 0);
   if (!shadingGroupPlug.isNull())
   {
      AtNode *rootShader = ExportNode(shadingGroupPlug);
      if (rootShader != NULL)
      {
         AiNodeSetPtr(instance, "shader", rootShader);
         return rootShader;
      }
   }

   return NULL;
}


