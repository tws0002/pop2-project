//
//     Copyright (C) Pixar. All rights reserved.
//
//     This license governs use of the accompanying software. If you
//     use the software, you accept this license. If you do not accept
//     the license, do not use the software.
//
//     1. Definitions
//     The terms 'reproduce,' 'reproduction,' 'derivative works,' and
//     'distribution' have the same meaning here as under U.S.
//     copyright law.  A 'contribution' is the original software, or
//     any additions or changes to the software.
//     A 'contributor' is any person or entity that distributes its
//     contribution under this license.
//     'Licensed patents' are a contributor's patent claims that read
//     directly on its contribution.
//
//     2. Grant of Rights
//     (A) Copyright Grant- Subject to the terms of this license,
//     including the license conditions and limitations in section 3,
//     each contributor grants you a non-exclusive, worldwide,
//     royalty-free copyright license to reproduce its contribution,
//     prepare derivative works of its contribution, and distribute
//     its contribution or any derivative works that you create.
//     (B) Patent Grant- Subject to the terms of this license,
//     including the license conditions and limitations in section 3,
//     each contributor grants you a non-exclusive, worldwide,
//     royalty-free license under its licensed patents to make, have
//     made, use, sell, offer for sale, import, and/or otherwise
//     dispose of its contribution in the software or derivative works
//     of the contribution in the software.
//
//     3. Conditions and Limitations
//     (A) No Trademark License- This license does not grant you
//     rights to use any contributor's name, logo, or trademarks.
//     (B) If you bring a patent claim against any contributor over
//     patents that you claim are infringed by the software, your
//     patent license from such contributor to the software ends
//     automatically.
//     (C) If you distribute any portion of the software, you must
//     retain all copyright, patent, trademark, and attribution
//     notices that are present in the software.
//     (D) If you distribute any portion of the software in source
//     code form, you may do so only under this license by including a
//     complete copy of this license with your distribution. If you
//     distribute any portion of the software in compiled or object
//     code form, you may only do so under a license that complies
//     with this license.
//     (E) The software is licensed 'as-is.' You bear the risk of
//     using it. The contributors give no express warranties,
//     guarantees or conditions. You may have additional consumer
//     rights under your local laws which this license cannot change.
//     To the extent permitted under your local laws, the contributors
//     exclude the implied warranties of merchantability, fitness for
//     a particular purpose and non-infringement.
//

//
// This block of defines looks to not be currently used 
// (either in this file or in the dynamic shader code added by OpenSubdiv)
// Caution should be used if modifying it as the OpenSubdiv dynamic code
// could use it in the future.
//
#if defined(VARYING_COLOR) || defined(FACEVARYING_COLOR)
#undef OSD_USER_VARYING_DECLARE
#define OSD_USER_VARYING_DECLARE \
    vec3 color;

#undef OSD_USER_VARYING_ATTRIBUTE_DECLARE
#define OSD_USER_VARYING_ATTRIBUTE_DECLARE \
    layout(location = 1) in vec3 color;

#undef OSD_USER_VARYING_PER_VERTEX
#define OSD_USER_VARYING_PER_VERTEX() \
    outpt.color = color

#undef OSD_USER_VARYING_PER_CONTROL_POINT
#define OSD_USER_VARYING_PER_CONTROL_POINT(ID_OUT, ID_IN) \
    outpt[ID_OUT].color = inpt[ID_IN].color

#undef OSD_USER_VARYING_PER_EVAL_POINT
#define OSD_USER_VARYING_PER_EVAL_POINT(UV, a, b, c, d) \
    outpt.color = \
        mix(mix(inpt[a].color, inpt[b].color, UV.x), \
            mix(inpt[c].color, inpt[d].color, UV.x), UV.y)
#else
#define OSD_USER_VARYING_DECLARE
#define OSD_USER_VARYING_ATTRIBUTE_DECLARE
#define OSD_USER_VARYING_PER_VERTEX()
#define OSD_USER_VARYING_PER_CONTROL_POINT(ID_OUT, ID_IN)
#define OSD_USER_VARYING_PER_EVAL_POINT(UV, a, b, c, d)
#endif

//--------------------------------------------------------------
// Uniforms / Uniform Blocks
//--------------------------------------------------------------

layout(std140) uniform Transform {
    mat4 ModelViewMatrix;
    mat4 ProjectionMatrix;
    mat4 ModelViewProjectionMatrix;
};

layout(std140) uniform Tessellation {
    float TessLevel;
};

uniform int GregoryQuadOffsetBase;
uniform int PrimitiveIdBase;

//--------------------------------------------------------------
// Osd external functions
//--------------------------------------------------------------

mat4 OsdModelViewMatrix()
{
    return ModelViewMatrix;
}
mat4 OsdProjectionMatrix()
{
    return ProjectionMatrix;
}
mat4 OsdModelViewProjectionMatrix()
{
    return ModelViewProjectionMatrix;
}
float OsdTessLevel()
{
    return TessLevel;
}
int OsdGregoryQuadOffsetBase()
{
    return GregoryQuadOffsetBase;
}
int OsdPrimitiveIdBase()
{
    return PrimitiveIdBase;
}
int OsdBaseVertex()
{
    return 0;
}

//--------------------------------------------------------------
// Global Defines
//--------------------------------------------------------------

//--------------------------------------------------------------
// Vertex Shader
//--------------------------------------------------------------
#ifdef VERTEX_SHADER

layout (location=0) in vec4 position;
layout (location=1) in vec3 normal;

out block {
    OutputVertex v;
} outpt;

void main()
{
    outpt.v.position = ModelViewMatrix * position;
    outpt.v.normal = (ModelViewMatrix * vec4(normal, 0.0)).xyz;
}

#endif

//--------------------------------------------------------------
// Geometry Shader
//--------------------------------------------------------------
#ifdef GEOMETRY_SHADER

#if defined(TEXTURE_DISPLACEMENT)
uniform vec4 uvScaleOffsetDisplacement = vec4(1.0f, 1.0f, 0.0f, 0.0f);
uniform int upsideDownDisplacementTexture = 0;

uniform sampler2D g_displacementTexture;
uniform float g_displacementGain = 1.0f;
#endif

#if defined(TEXTURE_FILTERFACES)
uniform isamplerBuffer g_filterFacesMap;
#endif


#ifdef PRIM_QUAD

    layout(lines_adjacency) in;

    layout(triangle_strip, max_vertices = 4) out;

    #define EDGE_VERTS 4

    in block {
        OutputVertex v;
    } inpt[4];

#endif // PRIM_QUAD

#ifdef  PRIM_TRI

    layout(triangles) in;

    layout(triangle_strip, max_vertices = 3) out;

    #define EDGE_VERTS 3

    in block {
        OutputVertex v;
    } inpt[3];

#endif // PRIM_TRI

#ifdef PRIM_PATCH_CV

    layout(points) in;
    layout(points, max_vertices = 1) out;

    in block {
        OutputVertex v;
    } inpt[1];

#endif // PRIM_PATCH_CV

out block {
    OutputVertex v;
    out vec2 texCoord;
#if defined(FACEVARYING_COLOR)
    out vec4 vcolor;
#endif
#if defined(GEOMETRY_OUT_WIRE)
  #if defined(SHOW_TESSELLATION_WIREFRAME)
    noperspective out vec4 edgeDistance;
  #else
    out float pixelToPatchCoordScale;
  #endif
#endif
} outpt;


uniform int OsdFVarDataWidth = 2;
uniform int fvarIndex_uvMap = 0;
uniform int fvarIndex_colorSet = 0;

#if defined(TEXTURE_DISPLACEMENT)
vec4 displacement(vec4 position, vec3 normal, vec2 patchCoord)
{
    vec2 uv = vec2(uvScaleOffsetDisplacement[2], uvScaleOffsetDisplacement[3]) + patchCoord * vec2(uvScaleOffsetDisplacement[0], uvScaleOffsetDisplacement[1]);
	if (upsideDownDisplacementTexture==1)
		uv[1] = 1.0f - uv[1];

    float disp = texture(g_displacementTexture, uv).x * g_displacementGain;
    return position + vec4(disp * normalize(normal), 0);
}
#if defined(VECTOR_DISPLACEMENT)
vec4 vectorDisplacement(vec4 position, vec2 patchCoord)
{
    vec2 uv = vec2(uvScaleOffsetDisplacement[2], uvScaleOffsetDisplacement[3]) + patchCoord * vec2(uvScaleOffsetDisplacement[0], uvScaleOffsetDisplacement[1]);
	if (upsideDownDisplacementTexture==1)
		uv[1] = 1.0f - uv[1];

    vec3 disp = texture(g_displacementTexture, uv).xyz;

	disp = (ModelViewMatrix * vec4(disp, 1.0f)).xyz;

    return position + vec4(disp, 0);
}
#endif
#endif

vec2 fetchFVarUV(int index)
{
    // We fetch each uv component separately since the texture buffer
    // has a single component internal format, i.e. R32F instead of RG32F.
    // Start with an offset representing 4 verts per primitive and
    // multiply by 2 on each fetch to account for two floats per UV.
    // uvFVarBuffer is a flat array of floats, but is accessed as if it
    // has the structure of float[p][4][2] where p=primitiveID:
    //      [ [ uv uv uv uv ] [ uv uv uv uv ] [ ... ] ]
    //            prim 0           prim 1

    // Note: With CatmarkUniform, OsdPrimitiveIdBase=0
    int uvOffset = (gl_PrimitiveID+OsdPrimitiveIdBase()) * 4;

    return
        vec2( texelFetch( OsdFVarDataBuffer, (uvOffset+index)*OsdFVarDataWidth + fvarIndex_uvMap     ).s,
              texelFetch( OsdFVarDataBuffer, (uvOffset+index)*OsdFVarDataWidth + fvarIndex_uvMap + 1 ).s );
}

vec4 fetchFVarColor(int index)
{
    // Note: With CatmarkUniform, OsdPrimitiveIdBase=0
    int uvOffset = (gl_PrimitiveID+OsdPrimitiveIdBase()) * 4;

    // ASSUMPTION: RGBA (4 color channels) stored in fvar data
    return 
        vec4( texelFetch( OsdFVarDataBuffer, (uvOffset+index)*OsdFVarDataWidth + fvarIndex_colorSet ).s,
              texelFetch( OsdFVarDataBuffer, (uvOffset+index)*OsdFVarDataWidth + fvarIndex_colorSet + 1 ).s,
              texelFetch( OsdFVarDataBuffer, (uvOffset+index)*OsdFVarDataWidth + fvarIndex_colorSet + 2 ).s,
              texelFetch( OsdFVarDataBuffer, (uvOffset+index)*OsdFVarDataWidth + fvarIndex_colorSet + 3 ).s );
}

vec4 GeneratePatchCoordForUniformSubdiv(vec2 localFaceCoord)
{
    // Manually construct the inputVertex.v.patchCoord that comes in from
    // the tess program with the Adaptive Subdiv.
    //
    ivec2 ptexIndex = texelFetch(OsdPatchParamBuffer, gl_PrimitiveID).xy;
    int faceID = ptexIndex.x;
	int lv = 1 << ((ptexIndex.y & 0xf) - ((ptexIndex.y >> 4) & 1));
    int u = (ptexIndex.y >> 17) & 0x3ff;
    int v = (ptexIndex.y >> 7) & 0x3ff;
    vec2 uv = localFaceCoord;
    uv = (uv * vec2(1.0)/lv) + vec2(u, v)/lv;
    
    return vec4(uv.x, uv.y, lv+0.5, faceID+0.5);
}


void emit(int index, vec3 normal, vec2 uvs[4])
{
    // PatchCoord
#ifdef FVAR_ADAPTIVE
    outpt.v.patchCoord = inpt[index].v.patchCoord; // patchCoord(patchS, patchT, level, faceId)
#else 
    // Note: The outpt.v.patchCoord for Uniform is handled in the (PRIM_QUAD) main() function before it calls emit()
#endif

    // == Color
#ifdef FACEVARYING_COLOR
    outpt.vcolor = fetchFVarColor(index);
#endif

    // == UV
#ifdef FVAR_ADAPTIVE
    // For Feature-Adaptive Subdiv
    // Bi-linear interpolation within the patch, using the passed-in uvs
    vec2 st = inpt[index].v.tessCoord;

    outpt.texCoord.st =
        vec2( mix( mix(uvs[0].x, uvs[1].x, st.s ), mix(uvs[3].x, uvs[2].x, st.s ), st.t),
              mix( mix(uvs[0].y, uvs[1].y, st.s ), mix(uvs[3].y, uvs[2].y, st.s ), st.t)  );
#else
    // perform a direct fetch and ignore the uvs passed in
    outpt.texCoord.st = fetchFVarUV(index);
#endif

    // == Normal
#ifdef SMOOTH_NORMALS
    outpt.v.normal = inpt[index].v.normal;
#else
    outpt.v.normal = normal;
#endif

    // == Position
    // Displace position if have a displacement texture
#if defined(TEXTURE_DISPLACEMENT)
#if defined(VECTOR_DISPLACEMENT)
		outpt.v.normal = normal;
		outpt.v.position = vectorDisplacement(inpt[index].v.position, outpt.texCoord.st);
#else
		outpt.v.position = displacement(inpt[index].v.position, outpt.v.normal, outpt.texCoord.st);
#endif
#else
		outpt.v.position =  inpt[index].v.position;
#endif

    gl_Position = ProjectionMatrix * outpt.v.position;
    EmitVertex();
}

#if defined(GEOMETRY_OUT_WIRE)
const float VIEWPORT_SCALE = 1024.0; // XXXdyu

float edgeDistance(vec4 p, vec4 p0, vec4 p1)
{
    return VIEWPORT_SCALE *
        abs((p.x - p0.x) * (p1.y - p0.y) -
            (p.y - p0.y) * (p1.x - p0.x)) / length(p1.xy - p0.xy);
}

#if defined(SHOW_TESSELLATION_WIREFRAME)
void emitEdgeDistances_patch(int index, vec4 edgeVerts[EDGE_VERTS])
{
    outpt.edgeDistance[0] =
        edgeDistance(edgeVerts[index], edgeVerts[0], edgeVerts[1]);
    outpt.edgeDistance[1] =
        edgeDistance(edgeVerts[index], edgeVerts[1], edgeVerts[2]);
#ifdef PRIM_TRI
    outpt.edgeDistance[2] =
        edgeDistance(edgeVerts[index], edgeVerts[2], edgeVerts[0]);
#endif
#ifdef PRIM_QUAD
    outpt.edgeDistance[2] =
        edgeDistance(edgeVerts[index], edgeVerts[2], edgeVerts[3]);
    outpt.edgeDistance[3] =
        edgeDistance(edgeVerts[index], edgeVerts[3], edgeVerts[0]);
#endif
}
#endif // defined(SHOW_TESSELLATION_WIREFRAME)

#ifdef PRIM_TRI
float calcScreenPixelToPatchCoordScale_Adaptive(vec4 edgeVerts[EDGE_VERTS])
{
    vec2 minVert = min(min(edgeVerts[0].xy, edgeVerts[1].xy), edgeVerts[2].xy);
    vec2 maxVert = max(max(edgeVerts[0].xy, edgeVerts[1].xy), edgeVerts[2].xy);

    vec2 minPatch = min(min(inpt[0].v.patchCoord.st, inpt[1].v.patchCoord.st), inpt[2].v.patchCoord.st);
    vec2 maxPatch = max(max(inpt[0].v.patchCoord.st, inpt[1].v.patchCoord.st), inpt[2].v.patchCoord.st);

    float pixelToPatchCoordScale = length(maxVert - minVert) / length(maxPatch - minPatch);
    pixelToPatchCoordScale *= VIEWPORT_SCALE;
    pixelToPatchCoordScale *= 0.5;
    return pixelToPatchCoordScale;
}
#endif

#ifdef PRIM_QUAD
float calcScreenPixelToPatchCoordScale_Uniform(vec4 edgeVerts[EDGE_VERTS], const vec4 patchCoords[EDGE_VERTS])
{
    vec2 minVert = min(min(edgeVerts[0].xy, edgeVerts[1].xy), min(edgeVerts[2].xy, edgeVerts[3].xy));
    vec2 maxVert = max(max(edgeVerts[0].xy, edgeVerts[1].xy), max(edgeVerts[2].xy, edgeVerts[3].xy));

    vec2 minPatch = min(min(patchCoords[0].st, patchCoords[1].st), min(patchCoords[2].st, patchCoords[3].st));
    vec2 maxPatch = max(max(patchCoords[0].st, patchCoords[1].st), max(patchCoords[2].st, patchCoords[3].st));

    float pixelToPatchCoordScale = length(maxVert - minVert)/ length(maxPatch - minPatch);
    pixelToPatchCoordScale *= VIEWPORT_SCALE;
    pixelToPatchCoordScale *= 0.5;
    return pixelToPatchCoordScale;
}
#endif

#endif // defined(GEOMETRY_OUT_WIRE)


#ifdef PRIM_PATCH_CV
void main()
{
    gl_PrimitiveID = gl_PrimitiveIDIn;
    vec2 uvs[4];
    emit(0, vec3(0), uvs);
    EndPrimitive();
}
#endif // PRIM_PATCH_CV


#ifdef PRIM_QUAD  // For Uniform Subdiv
void main()
{
    gl_PrimitiveID = gl_PrimitiveIDIn;

    vec2 uvs[4]; // stub: unused here.  Calculated directly in the emit() function

    // Have to manually generate the patchCoords since it is not 
    // supplied as with the Adaptive Subdiv from the tess shader
    vec4 patchCoords[4];
    patchCoords[0] = GeneratePatchCoordForUniformSubdiv(vec2(0, 0));
    patchCoords[1] = GeneratePatchCoordForUniformSubdiv(vec2(1, 0));
    patchCoords[2] = GeneratePatchCoordForUniformSubdiv(vec2(1, 1));
    patchCoords[3] = GeneratePatchCoordForUniformSubdiv(vec2(0, 1));

    #if defined(GEOMETRY_OUT_WIRE)
    vec4 edgeVerts[EDGE_VERTS];
    edgeVerts[0] = ProjectionMatrix * inpt[0].v.position;
    edgeVerts[1] = ProjectionMatrix * inpt[1].v.position;
    edgeVerts[2] = ProjectionMatrix * inpt[2].v.position;
    edgeVerts[3] = ProjectionMatrix * inpt[3].v.position;

    edgeVerts[0].xy /= edgeVerts[0].w;
    edgeVerts[1].xy /= edgeVerts[1].w;
    edgeVerts[2].xy /= edgeVerts[2].w;
    edgeVerts[3].xy /= edgeVerts[3].w;

    float pixelToPatchCoordScale = calcScreenPixelToPatchCoordScale_Uniform(edgeVerts, patchCoords);
    #endif

    // If filtering, reject faces that are filtered out
#if defined(TEXTURE_FILTERFACES)
    int ptexFaceIndex = int(patchCoords[0].w);
    bool faceShow = bool(texelFetch( g_filterFacesMap, ptexFaceIndex ).x);
    if (faceShow == false) return;
#endif

    vec3 n0 = vec3(0);

#if !defined(SMOOTH_NORMALS)
    // If using face normals, then pre-calculate the normal for all the verts
    // Otherwise the normals are calculated in the emit() function
    vec3 A = (inpt[0].v.position - inpt[1].v.position).xyz;
    vec3 B = (inpt[3].v.position - inpt[1].v.position).xyz;
    n0 = normalize(cross(B, A));
#endif

#if defined(TEXTURE_DISPLACEMENT)
#if defined(VECTOR_DISPLACEMENT)
	vec3 A = (vectorDisplacement(inpt[0].v.position, fetchFVarUV(0)) - vectorDisplacement(inpt[1].v.position, fetchFVarUV(1))).xyz;
	vec3 B = (vectorDisplacement(inpt[3].v.position, fetchFVarUV(3)) - vectorDisplacement(inpt[1].v.position, fetchFVarUV(1))).xyz;
    n0 = normalize(cross(B, A));
#endif
#endif

    // emit positions, normals, and uvs
    const int vertexEmitOrdering[4] =  int[](0,1,3,2); // Need to emit the verts in this order
    for (int i=0; i < 4; i++) {
        #if defined(GEOMETRY_OUT_WIRE)
            #if defined(SHOW_TESSELLATION_WIREFRAME)
                emitEdgeDistances_patch(vertexEmitOrdering[i], edgeVerts);
            #else 
                outpt.pixelToPatchCoordScale = pixelToPatchCoordScale;
            #endif
        #endif
        outpt.v.patchCoord = patchCoords[ vertexEmitOrdering[i] ];
        emit(vertexEmitOrdering[i], n0, uvs);
    }

    EndPrimitive();
}
#endif // PRIM_QUAD


#ifdef PRIM_TRI
void main()
{
    gl_PrimitiveID = gl_PrimitiveIDIn;
    vec2 uvs[4];

    vec3 n0 = vec3(0);
    // Calculate face-normals
    #if !defined(SMOOTH_NORMALS)
    // If using face normals, then pre-calculate the normal for all the verts
    // Otherwise the normals are calculated in the emit() function
    vec3 A = (inpt[1].v.position - inpt[0].v.position).xyz;
    vec3 B = (inpt[2].v.position - inpt[0].v.position).xyz;
    n0 = normalize(cross(B, A));
    #endif

    #ifdef FVAR_ADAPTIVE
    // construct the uvs to pass into the emit() so they can be mixed together
    // otherwise handled in the emit() function
    // only used in feature adaptive, so only needed for PRIM_TRI
    uvs[0] = fetchFVarUV(0);
    uvs[1] = fetchFVarUV(1);
    uvs[2] = fetchFVarUV(2);
    uvs[3] = fetchFVarUV(3);
    #endif

    #if defined(GEOMETRY_OUT_WIRE)
    vec4 edgeVerts[EDGE_VERTS];
    edgeVerts[0] = ProjectionMatrix * inpt[0].v.position;
    edgeVerts[1] = ProjectionMatrix * inpt[1].v.position;
    edgeVerts[2] = ProjectionMatrix * inpt[2].v.position;

    edgeVerts[0].xy /= edgeVerts[0].w;
    edgeVerts[1].xy /= edgeVerts[1].w;
    edgeVerts[2].xy /= edgeVerts[2].w;

    float pixelToPatchCoordScale = calcScreenPixelToPatchCoordScale_Adaptive(edgeVerts);
    #endif

    // If filtering, reject faces that are filtered out
#if defined(TEXTURE_FILTERFACES)
    int ptexFaceIndex = int(inpt[0].v.patchCoord.w);
    bool faceShow = bool(texelFetch( g_filterFacesMap, ptexFaceIndex ).x);
    if (faceShow == false) return;
#endif

    // Emit Vertices
    for (int i=0; i < 3; i++) {
        #if defined(GEOMETRY_OUT_WIRE)
            #if defined(SHOW_TESSELLATION_WIREFRAME)
                emitEdgeDistances_patch(i, edgeVerts); // emit edge distances
            #else 
                outpt.pixelToPatchCoordScale = pixelToPatchCoordScale;
            #endif
        #endif
        emit(i, n0, uvs); // emit positions, normals, and uvs
    }

    EndPrimitive();
}
#endif // PRIM_TRI =================

#endif // GEOMETRY_SHADER

//--------------------------------------------------------------
// Fragment Shader
//--------------------------------------------------------------
#ifdef FRAGMENT_SHADER

in block {
    OutputVertex v;
    in vec2 texCoord;
#if defined(FACEVARYING_COLOR)
    in vec4 vcolor;
#endif
#if defined(GEOMETRY_OUT_WIRE)
  #if defined(SHOW_TESSELLATION_WIREFRAME)
    noperspective in vec4 edgeDistance;
  #else
    in float pixelToPatchCoordScale;
  #endif
#endif
} inpt;

out vec4 outColor;

#define MAX_LIGHTS 8

struct LightSource {
    vec4 position;
    vec4 ambient;
    vec4 diffuse;
    vec4 specular;
};

layout(std140) uniform Lighting {
    LightSource lightSource[MAX_LIGHTS];
};
uniform int numLights = 1;

uniform vec4 diffuseColor = vec4(1);
uniform vec4 ambientColor = vec4(1);
uniform vec4 specularColor= vec4(1);
uniform float shininess = 500.0f;
uniform vec4 transparency = vec4(1);

uniform vec4 uvScaleOffsetDiffuse = vec4(1.0f, 1.0f, 0.0f, 0.0f);
uniform int upsideDownDiffuseTexture = 0;

#if defined(TEXTURE_DIFFUSE)
uniform sampler2D g_diffuseTexture;
#endif

#if defined(TEXTURE_DISPLACEMENT)
uniform vec4 uvScaleOffsetDisplacement = vec4(1.0f, 1.0f, 0.0f, 0.0f);
uniform int upsideDownDisplacementTexture = 0;

uniform sampler2D g_displacementTexture;
uniform float g_displacementGain = 1.0f;
#endif

#if defined(TEXTURE_SPECULAR)
uniform sampler2D g_specularTexture;
#endif

// Calculate the distance for a particular pixel's patchCoord to the 
// cage mesh's face edge.
// Note: This cannot be done in the geometry shader as if there is limited
//       tessellation and all the verts are along the cage mesh edges, then it will 
//       interpolate across the face as 0
//
vec4 calcEdgeDistances_cage(const vec4 patchCoord, float pixelToPatchCoordScale)
{
    vec4 edgeDist = vec4(pixelToPatchCoordScale); // Give init values a large value so it will not be relevant
    edgeDist.s = min(patchCoord.s, 1.0f - patchCoord.s)*pixelToPatchCoordScale;
    edgeDist.t = min(patchCoord.t, 1.0f - patchCoord.t)*pixelToPatchCoordScale;
    return edgeDist;
}


#if defined(TEXTURE_DISPLACEMENT)
vec3
perturbNormalFromDisplacement(vec3 position, vec3 normal, vec2 texCoord)
{
    // by Morten S. Mikkelsen
    // http://mmikkelsen3d.blogspot.com
    
    // Note: there appears to be moire patterns, likely due to the lower-precision dFdx/dFdy functions.
    // It is recommended to use a higher-precision dFdx/dFdy function.

    vec3 vSigmaS = dFdx(position);
    vec3 vSigmaT = dFdy(position);
    vec3 vN = normal;
    vec3 vR1 = cross(vSigmaT, vN);
    vec3 vR2 = cross(vN, vSigmaS);
    float fDet = dot(vSigmaS, vR1);

    // WORK IN PROGRESS: Neither method works as expected.  Resulting normals are mottled.
    // REVISIT AND FIX: Working with Pixar engineers on it.

    vec2 uv = vec2(uvScaleOffsetDisplacement[2], uvScaleOffsetDisplacement[3]) + texCoord.st * vec2(uvScaleOffsetDisplacement[0], uvScaleOffsetDisplacement[1]);
	if (upsideDownDisplacementTexture==1)
		uv[1] = 1.0f - uv[1];

#if 1
    float disp = texture(g_displacementTexture, uv).x * g_displacementGain;
    float dBs = dFdx(disp);
    float dBt = dFdy(disp);
#else
    vec2 texDx = dFdx(uv);
    vec2 texDy = dFdy(uv);
    
    // limit forward differencing to the width of ptex gutter
    //const float resolution = 128.0;
    float d = 1.0; //min(1, (0.5/resolution)/max(length(texDx), length(texDy)));
    
    vec2 STll = uv;
    vec2 STlr = uv + d * vec2(texDx.x, texDx.y);
    vec2 STul = uv + d * vec2(texDy.x, texDy.y);

    float Hll = textureLod(g_displacementTexture, STll.st, 0).x * g_displacementGain;
    float Hlr = textureLod(g_displacementTexture, STlr.st, 0).x * g_displacementGain;
    float Hul = textureLod(g_displacementTexture, STul.st, 0).x * g_displacementGain;

    float dBs = (Hlr - Hll)/d;
    float dBt = (Hul - Hll)/d;
#endif
    
    vec3 vSurfGrad = sign(fDet) * (dBs * vR1 + dBt * vR2);
    return normalize(abs(fDet) * vN - vSurfGrad);
}
#endif // defined(TEXTURE_DISPLACEMENT)

vec4
lighting(vec3 Peye, vec3 Neye)
{
    vec4 color = vec4(0);

    // Determine diffuse color or texture value
#if defined(TEXTURE_DIFFUSE)
    vec2 uv = vec2(uvScaleOffsetDiffuse[2], uvScaleOffsetDiffuse[3]) + inpt.texCoord.st * vec2(uvScaleOffsetDiffuse[0], uvScaleOffsetDiffuse[1]);
	if (upsideDownDiffuseTexture==1)
		uv[1] = 1.0f - uv[1];

	vec4 tmpDiffuseColor = texture(g_diffuseTexture, uv);

    #if defined(FACEVARYING_COLOR)
        // multiply diffuse texture with the vertex color 
		if (inpt.vcolor.r >= 0.0)
        	tmpDiffuseColor = tmpDiffuseColor * inpt.vcolor; // multiply by vertex color
    #endif
#else
    vec4 tmpDiffuseColor = diffuseColor;
    #if defined(FACEVARYING_COLOR)
        // replace the diffuse color with the vertex color
		if (inpt.vcolor.r >= 0.0)
			tmpDiffuseColor = inpt.vcolor; // replace with vertex color
    #endif
#endif

#if defined(TEXTURE_SPECULAR)
    vec4 tmpSpecularColor = texture(g_specularTexture, inpt.texCoord.st);
#else
    vec4 tmpSpecularColor = specularColor;
#endif

    // Loop over lights and accumulate color
    for (int i = 0; i < numLights; ++i) {  // MAX_LIGHTS

        vec4 Plight = lightSource[i].position;

        // w==0 -> directional
        // w==1 -> point
        vec3 l = (Plight.w == 0.0)
                    ? normalize(Plight.xyz) : normalize(Plight.xyz - Peye);

        vec3 n = normalize(Neye);
        vec3 h = normalize(l + vec3(0,0,1));    // directional viewer

        float d = max(0.0, dot(n, l));
        float s = pow(max(0.0, dot(n, h)), shininess);

        color += lightSource[i].ambient * ambientColor
            + d * lightSource[i].diffuse * tmpDiffuseColor
            + s * lightSource[i].specular * tmpSpecularColor;
    }

    color.a = 1;

	// This doesn't exactly match the shading math in Maya's default shaders. Here 
	// the specularity is affected by the transparency (cutout effect). However, the 
	// specularity in the default shaders in Maya is not affected by transparency (glass effect).
	// The luminance calculation is taken from https://en.wikipedia.org/wiki/Luminance_%28relative%29
	// and assumes an sRGB color space.
	float lum = 1.0 - (0.2126*transparency.x + 0.7152*transparency.y + 0.0722*transparency.z);
	vec4 invTrans = vec4(1);
	invTrans = invTrans - transparency;
	color = color * invTrans;
	color.a = lum;
    return color;
}


#if defined(GEOMETRY_OUT_WIRE)
uniform vec4 wireframeColor = vec4(1.0, 0.0, 0.0, 1.0);

vec4
edgeColor(vec4 Cfill, vec4 edgeDistance)
{
    float d = min(edgeDistance[0], min(edgeDistance[1], edgeDistance[2]));
    #ifdef PRIM_QUAD
    d = min(d, edgeDistance[3]);
    #endif

    // Use a function that creates a spike near 0
    float p = exp2(-2 * d * d);

#if !defined(GEOMETRY_OUT_FILL)
    if (p < 0.25) discard;
    // Use the wireframe color if only drawing wireframe.
    Cfill.rgb = wireframeColor.rgb;
#else
    // If drawing the surface, blend with the surface color
    Cfill.rgb = mix(Cfill.rgb, wireframeColor.rgb, p);
#endif

    return Cfill;
}

#endif


#if defined(PRIM_PATCH_CV) || defined(GEOMETRY_OUT_POINTS)
uniform vec4 pointColor = vec4(1.0, 0.0, 0.0, 1.0);
void
main()
{
    outColor = pointColor;
}
#endif


#if (defined(PRIM_QUAD) || defined(PRIM_TRI)) && !defined(GEOMETRY_OUT_POINTS)
void
main()
{
#if !defined(GEOMETRY_OUT_FILL)
    // if only drawing the wireframe, then skip lighting and normal calculations
    vec4 Cf = wireframeColor; 
#else
    // Determine normal used with lighting
    vec3 N = inpt.v.normal;

    // Perturb normal if doing displacement mapping
#if defined(TEXTURE_DISPLACEMENT)
#if defined(VECTOR_DISPLACEMENT)
	// Don't perturb normal.  Just use face normal.
#else
        N = perturbNormalFromDisplacement(inpt.v.position.xyz,
                                          N,
                                          inpt.texCoord.st);
#endif
#endif

    // Revisit: Is this accurate after the normal perturbation?
    if (!gl_FrontFacing) {
        N = -N;
    }

    // Perform lighting calcuations for the surface
    vec4 Cf = lighting(inpt.v.position.xyz, N);
#endif

    // DEBUG: Use UV Coordinates as the outColor
    //outColor = vec4(inpt.texCoord.s, inpt.texCoord.t, 0, 1);
    //outColor = vec4(inpt.v.patchCoord.s, inpt.v.patchCoord.t, 0, 1);
    //outColor = vec4(inpt.v.patchCoord.w*.1, 0, 0, 1);
    //return;

    //outColor = vec4(inpt.edgeDistance.x*.01, inpt.edgeDistance.y*.01, 0, 1);
    //return;

    //outColor = vec4(min(inpt.edgeDistance[0], inpt.edgeDistance[1])*.01, 0, 0, 1);
    //return;

    // DEBUG: For texture display
    //outColor = texture(g_diffuseTexture, inpt.texCoord.st);
    //outColor = texture(g_displacementTexture, inpt.texCoord.st);
    //return;

    // DEBUG: Use N as the outColor
    //outColor = vec4(N.x, N.y, N.z, 1);
    //return;

    #if defined(GEOMETRY_OUT_WIRE)
        #if defined(SHOW_TESSELLATION_WIREFRAME)
            Cf = edgeColor(Cf, inpt.edgeDistance);
        #else
            vec4 distFromPatchEdge = calcEdgeDistances_cage(inpt.v.patchCoord, inpt.pixelToPatchCoordScale);
            Cf = edgeColor(Cf, distFromPatchEdge);
        #endif
    #endif

    outColor = Cf;
}
#endif

#endif
