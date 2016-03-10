// Display mesh kernels

// The buffers through the deformer pipeline are standardized on float3.  But the
// buffers that are rendering can sometimes be float4 instead.  Plugin shaders can
// ask for any abitrary combination of formats, but for complexity reasons we only
// support either all float3 or all float4 here.  The "FinalBuffersAsFloat4" define
// specifies that the final render buffers for positions, normals, tangents, and
// bitangents are float4.  If "FinalBuffersAsFloat4" is not defined then they all
// must be float3.  UVs used for tangentSets must always to be float2.


__kernel void displayMesh_convertPositionsToVertexPositions(
	__global float* vertexPositions, // float3 or float4
	__global const float* positions, // float3
	__global const unsigned int* sharedIdxToVertex,
	const uint vertexCount)
{
	unsigned int index = get_global_id(0);
	if (index >= vertexCount) return;

    float3 pos = vload3(sharedIdxToVertex[index], positions);
#ifdef FinalBuffersAsFloat4
    float4 pos4 = (float4)(pos, 1.0f);
    vstore4(pos4, index, vertexPositions);
#else
    vstore3(pos, index, vertexPositions);
#endif
}


__kernel void displayMesh_convertNormalsToVertexNormals(
	__global float* vertexNormals, //float3 or float4
	__global const float* normals, //float3
	__global const unsigned int* sharedIdxToNormalId,
	const unsigned int vertexCount)
{
	unsigned int vertexNormalId = get_global_id(0);
	if (vertexNormalId >= vertexCount) return;

    float3 norm = vload3(sharedIdxToNormalId[vertexNormalId], normals);
#ifdef FinalBuffersAsFloat4
    float4 norm4 = (float4)(norm, 0.0f);
    vstore4(norm4, vertexNormalId, vertexNormals);
#else
    vstore3(norm, vertexNormalId, vertexNormals);
#endif
}


// Copies a contiguous range of source float[3] values to i*2 in the destination buffer
__kernel void displayMesh_remapExpandByTwo(
	__global float* dest,	   //float3
	__global const float* src, //float3
	const unsigned int count)
{
	unsigned int idx = get_global_id(0);
	if (idx >= count) return;
	
    float3 val = vload3(idx, src);
    vstore3(val, idx * 2, dest);
}


__kernel void displayMesh_generateVertexNormalsUsingMap(
	__global const float* vertexPositions,  //float3 or float4
	__global float* vertexNormals,          //float3 or float4
	__global const unsigned int* vertexIdToTriangleMap,
	__global const unsigned int* vertexIdToTriangleMapOffsets,
	const uint vertexCount)
{
	unsigned int vertexId = get_global_id(0);
	if (vertexId >= vertexCount) return;

	// loop over the faces, compute the face normals and accumulate them
	// then normalize the result and store it in vertexNormals

	float4 accumulatedNormal = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	unsigned int start = vertexIdToTriangleMapOffsets[vertexId];
	unsigned int end = vertexIdToTriangleMapOffsets[vertexId+1];
	for (unsigned int i = start; i < end; i++)
	{
        uint3 triangleVerts = vload3(i, vertexIdToTriangleMap);
#ifdef FinalBuffersAsFloat4
		float4 vertex1 = vload4(triangleVerts.s0, vertexPositions);
		float4 vertex2 = vload4(triangleVerts.s1, vertexPositions);
		float4 vertex3 = vload4(triangleVerts.s2, vertexPositions);
#else
		float4 vertex1 = (float4)(vload3(triangleVerts.s0, vertexPositions), 0.0f);
		float4 vertex2 = (float4)(vload3(triangleVerts.s1, vertexPositions), 0.0f);
		float4 vertex3 = (float4)(vload3(triangleVerts.s2, vertexPositions), 0.0f);
#endif

		// TODO: winding order? I just made this part up so it could be wrong
		// Guesses so far: 2-1, 3-1
		float4 vector1 = vertex2 - vertex1;
		float4 vector2 = vertex3 - vertex1;

		// Area of a triangle is half the length of the cross-product of two sides.
		// So to area-weight the normal contributions, don't normalize the cross product.
		float4 crossProd = cross(vector1, vector2);

		//accumulatedNormal += normalize(crossProd);
		accumulatedNormal += crossProd;

	}

	accumulatedNormal = normalize(accumulatedNormal);
#ifdef FinalBuffersAsFloat4
    vstore4(accumulatedNormal, vertexId, vertexNormals);
#else
    vstore3(accumulatedNormal.xyz, vertexId, vertexNormals);
#endif
}


__kernel void displayMesh_generateTangentsBitangentsUsingMap(
	__global const float* vertexPositions,  //float3 or float4
	__global const float* vertexNormals,    //float3 or float4
    __global const float* vertexUVs,        //float2
    __global float* vertexTangents,         //float3 or float4
    __global float* vertexBitangents,       //float3 or float4
	__global const unsigned int* vertexIdToTriangleMap,
	__global const unsigned int* vertexIdToTriangleMapOffsets,
    __global const unsigned int* bitanFlippedBitfield,  
	const uint vertexCount)
{
	unsigned int vertexId = get_global_id(0);
	if (vertexId >= vertexCount) return;

	// loop over the faces, compute the face normals and accumulate them
	// then normalize the result and store it in vertexNormals

	float4 accumulatedTangent = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

#ifdef FinalBuffersAsFloat4
    float4 surfNormal = vload4(vertexId, vertexNormals);
#else
    float4 surfNormal = (float4)(vload3(vertexId, vertexNormals), 0.0f);
#endif

	unsigned int start = vertexIdToTriangleMapOffsets[vertexId];
	unsigned int end = vertexIdToTriangleMapOffsets[vertexId+1];
	for (unsigned int i = start; i < end; i++)
	{
		// still need to multiply vertex index by 2 to get the offset into the uv array
        uint3 vertexIds = vload3(i, vertexIdToTriangleMap);

#ifdef FinalBuffersAsFloat4
		float4 pos0 = vload4(vertexIds.s0, vertexPositions);
		float4 pos1 = vload4(vertexIds.s1, vertexPositions);
		float4 pos2 = vload4(vertexIds.s2, vertexPositions);
#else
		float4 pos0 = (float4)(vload3(vertexIds.s0, vertexPositions), 0.0f);
		float4 pos1 = (float4)(vload3(vertexIds.s1, vertexPositions), 0.0f);
		float4 pos2 = (float4)(vload3(vertexIds.s2, vertexPositions), 0.0f);
#endif

        float2 uv0 = vload2(vertexIds.s0, vertexUVs);
        float2 uv1 = vload2(vertexIds.s1, vertexUVs);
        float2 uv2 = vload2(vertexIds.s2, vertexUVs);

        float2 uvDelta1 = uv1 - uv0;
        float2 uvDelta2 = uv2 - uv0;

        float4 posDelta1 = pos1 - pos0;
        float4 posDelta2 = pos2 - pos0;

        // x,s,t.  s and t vectors are re-used.
        float4 edge1 = (float4)(posDelta1.x, uvDelta1, 0.0f);
        float4 edge2 = (float4)(posDelta2.x, uvDelta2, 0.0f);
        float4 crossP = normalize(cross(edge1, edge2));
        if (fabs(crossP.x) < 0.0001f)  //check for degen
            crossP.x = 1.0f;
        float4 tangent;
        tangent.x = -crossP.y/crossP.x;

        // y,s,t
        edge1.x = posDelta1.y;
        edge2.x = posDelta2.y;
        crossP = normalize(cross(edge1, edge2));
        if (fabs(crossP.x) < 0.0001f)  //check for degen
            crossP.x = 1.0f;
        tangent.y = -crossP.y/crossP.x;

        //z,s,t
        edge1.x = posDelta1.z;
        edge2.x = posDelta2.z;
        crossP = normalize(cross(edge1, edge2));
        if (fabs(crossP.x) < 0.0001f)  //check for degen
            crossP.x = 1.0f;
        tangent.z = -crossP.y/crossP.x;
        tangent.w = 0.0f;

        // Project it into the correct plane and renormalize
        tangent = normalize(tangent - surfNormal * dot(tangent, surfNormal));

		accumulatedTangent += tangent;
	}

	float4 finalTangent = normalize(accumulatedTangent);

    unsigned int bitfieldChunk = bitanFlippedBitfield[vertexId / 32];
    unsigned int flippedRem = vertexId % 32;
    unsigned int flipped = bitfieldChunk & (1 << flippedRem);
    float flippedFactor = (flipped != 0) ? -1.0f : 1.0f;

    float4 bitangent = cross(surfNormal, finalTangent) * flippedFactor;

    // write the output
#ifdef FinalBuffersAsFloat4
    vstore4(finalTangent, vertexId, vertexTangents);
    vstore4(bitangent, vertexId, vertexBitangents);
#else
    vstore3(finalTangent.xyz, vertexId, vertexTangents);
    vstore3(bitangent.xyz, vertexId, vertexBitangents);
#endif
}
