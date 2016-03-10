
// Helper functions
// OSX seems to be using very strict compiler setting which demand the function
// prototype be defined before the function is implemented.  It seems like we
// only need the function prototype for helper methods, not kernels that are
// used directly.
float4 quatMult(float4 q1, float4 q2);
float4 deformVectorLinear(__global const unsigned int* startInfl, __global const float* startWeight, unsigned int numInfl,
                            float4 initialVector, __global const float4* multMatrices);
float4 deformPositionDualQuat(__global const unsigned int* startInfl, __global const float* startWeight, unsigned int numInfl,
                            float4 initialPosition, __global const float4* influenceVecs);
float4 deformNormalDualQuat(__global const unsigned int* startInfl, __global const float* startWeight, unsigned int numInfl,
                            float4 initialNormal, __global const float4* influenceVecs);



float4 deformVectorLinear(__global const unsigned int* startInfl, __global const float* startWeight, unsigned int numInfl,
                            float4 initialVector, __global const float4* multMatrices)
{
    __global const unsigned int* thisInfl = startInfl;
    __global const unsigned int* endInfl = startInfl + numInfl;
    __global const float* thisWeight = startWeight;
    
	float4 finalVector = (float4)(0.0f, 0.0f, 0.0f, initialVector.w);
    
    for ( ; thisInfl < endInfl; ++thisInfl, ++thisWeight)
    {
		float weight = *thisWeight;
		unsigned int influenceOffset = (*thisInfl) * 4; // This is how far into the matrix array we need to offset to find the matrix we care about.  The matrix array is declared as a float4 array and each matrix is 4 of those, so we have to multiply by an extra 4 to get where we want to be.
		finalVector.x = mad (weight, dot (initialVector, multMatrices[influenceOffset]), finalVector.x);
		finalVector.y = mad (weight, dot (initialVector, multMatrices[influenceOffset+1]), finalVector.y);
		finalVector.z = mad (weight, dot (initialVector, multMatrices[influenceOffset+2]), finalVector.z);
    }

    return finalVector;
}


float4 quatMult(float4 q1, float4 q2)
{
	float4 result;
	result.w = dot((q1 * q2),      (float4)(-1.0f, -1.0f, -1.0f, 1.0f));
	result.x = dot((q1 * q2.wzyx), (float4)(1.0f, -1.0f, 1.0f, 1.0f));
	result.y = dot((q1 * q2.zwxy), (float4)(1.0f, 1.0f, -1.0f, 1.0f));
	result.z = dot((q1 * q2.yxwz), (float4)(-1.0f, 1.0f, 1.0f, 1.0f));
	return result;
}




float4 deformPositionDualQuat(__global const unsigned int* startInfl, __global const float* startWeight, unsigned int numInfl,
                            float4 initialPosition, __global const float4* influenceVecs)
{

	__global const unsigned int* thisInfl = startInfl;
	__global const unsigned int* endInfl = startInfl + numInfl;
	__global const float* thisWeight = startWeight;

	float4 quat0 = (float4)(0.0f, 0.0f, 0.0f, 1.0f);
	float4 quat1 = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
	float4 scale = (float4)(1.0f, 1.0f, 1.0f, 0.0f);

	// Accumulate the weighted influences
	if (thisInfl < endInfl) {
		// no need to combine for the first influence, so move that out of the loop
		float4 weight = *thisWeight;
		unsigned int influenceOffset = (*thisInfl) * 3;  // two float4 quaternions and a float4 scale per influence
		quat0 = influenceVecs[influenceOffset] * weight;
		quat1 = influenceVecs[influenceOffset+1] * weight;
		scale = influenceVecs[influenceOffset+2] * weight;
		++thisInfl;
		++thisWeight;

		for ( ; thisInfl < endInfl; ++thisInfl, ++thisWeight)
		{
			float weight = *thisWeight;
			unsigned int influenceOffset = (*thisInfl) * 3;  // two float4 quaternions per influence

			float4 inflQ0 = influenceVecs[influenceOffset];
			float4 inflQ1 = influenceVecs[influenceOffset+1];
			float4 inflS = influenceVecs[influenceOffset+2];

			// Apply a -1 factor if the dot product is negative.
			float signFactor = (dot(quat0, inflQ0) >= 0.0f) ? 1.0f : -1.0f;
			float signFactoredWeight = signFactor * weight;

			quat0 += inflQ0 * signFactoredWeight;
			quat1 += inflQ1 * signFactoredWeight;
			scale += inflS * weight;
		}
	}

	// Renormalize the accumulated dual-quaternion
	float len = dot(quat0, quat0);
	if ( len > 0.0f) {
		len = rsqrt(len);
		quat0 *= (float4)(len);
		quat1 *= (float4)(len);
	}

	// Apply the accumulated scale
	scale.w = 0.0f;
	float4 scaledPosition = initialPosition * scale;

	// Pre-mult by the dual-quaternion
	float4 temp = quatMult(quat0, scaledPosition) + quat1;

	// Post-mult by conjugate, only need the second component of the result, don't both computing the resulting q0
	float4 conj0 = quat0 * (float4)(-1.0, -1.0, -1.0, 1.0);
	float4 conj1 = quat1 * (float4)(1.0, 1.0, 1.0, -1.0);

	float4 finalPosition = quatMult(quat0, conj1) + quatMult(temp, conj0);

	return finalPosition;
}


float4 deformNormalDualQuat(__global const unsigned int* startInfl, __global const float* startWeight, unsigned int numInfl,
                            float4 initialNormal, __global const float4* influenceVecs)
{

    __global const unsigned int* thisInfl = startInfl;
    __global const unsigned int* endInfl = startInfl + numInfl;
    __global const float* thisWeight = startWeight;

	float4 quat0 = (float4)(0.0f, 0.0f, 0.0f, 1.0f);
	float4 scale = (float4)(1.0f, 1.0f, 1.0f, 0.0f);

	// Accumulate the weighted influences
	// Similar to deformPositionDualQuat(), but ignore the second component of the dual quaternion influences.
	if (thisInfl < endInfl) {
		// no need to combine for the first influence, so move that out of the loop
		float4 weight = *thisWeight;
		unsigned int influenceOffset = (*thisInfl) * 3;  // two float4 quaternions and a float4 scale per influence
		quat0 = influenceVecs[influenceOffset] * weight;
		scale = influenceVecs[influenceOffset+2] * weight;
		++thisInfl;
		++thisWeight;

		for ( ; thisInfl < endInfl; ++thisInfl, ++thisWeight)
		{
			float weight = *thisWeight;
			unsigned int influenceOffset = (*thisInfl) * 3;  // two float4 quaternions per influence

			float4 inflQ0 = influenceVecs[influenceOffset];
			float4 inflS = influenceVecs[influenceOffset+2];

			// Apply a -1 factor if the dot product is negative.
			float signFactor = (dot(quat0, inflQ0) >= 0.0f) ? 1.0f : -1.0f;
			float signFactoredWeight = signFactor * weight;

			quat0 += inflQ0 * signFactoredWeight;
			scale += inflS * weight;

		}
	}

	// Renormalize the accumulated quaternion
	quat0 = normalize(quat0);

	// Apply the accumulated scale
	scale.w = 0.0f;
	float4 normal = initialNormal * scale;

	// Pre-mult by the quaternion
	normal = quatMult(quat0, normal);

	// Post-mult by conjugate
	float4 conj0 = quat0 * (float4)(-1.0, -1.0, -1.0, 1.0);
	normal = quatMult(normal, conj0);

	return normal;
}


/*
	Skin deformation kernels.
*/

__kernel void skinCluster_deformPositions(
	__global float* finalPos,							//float3
	__global const float* initialPos,					//float3
	__global const float* weights,
	__global const unsigned int* influences,
	__global const unsigned int* offsets,
	__global const float4* multMatrices,
	const uint positionCount)
{
	unsigned int positionId = get_global_id(0);				// access finalPos and initialPos using this value
	if (positionId >= positionCount ) return;					// We create an execute unit for more indices then we have data for, just exit early if this guy if one of the extras
	unsigned int positionOffset = positionId * 3;				// Base positions are float3 when they come in here!
	float4 initialPosition = (float4)(initialPos[positionOffset], initialPos[positionOffset+1], initialPos[positionOffset+2], 1.0f);

    unsigned int start = offsets[positionId];
	unsigned int end = offsets[positionId+1];
    unsigned int numInfl = (end > start) ? (end - start) : 0;
    
	float4 finalPosition = deformVectorLinear(&influences[start], &weights[start], numInfl,
                                              initialPosition, multMatrices);
                                                
	// write the finalPosition to the output buffer
	finalPos[positionOffset] = finalPosition.x;
	finalPos[positionOffset+1] = finalPosition.y;
	finalPos[positionOffset+2] = finalPosition.z;
}


__kernel void skinCluster_deformPositionsDualQuat(
	__global float* finalPos,							//float3
	__global const float* initialPos,					//float3
	__global const float* weights,
	__global const unsigned int* influences,
	__global const unsigned int* offsets,
	__global const float4* dqMultMatrices,
	__global const float4* dqInfluenceVecs,
	const uint             dqHasNonRigidTransforms,
	const uint             positionCount)
{
	unsigned int positionId = get_global_id(0);				// access finalPos and initialPos using this value
	if (positionId >= positionCount ) return;					// We create an execute unit for more indices then we have data for, just exit early if this guy if one of the extras
	unsigned int positionOffset = positionId * 3;				// Base positions are float3 when they come in here!
	float4 initialPosition = (float4)(initialPos[positionOffset], initialPos[positionOffset+1], initialPos[positionOffset+2], 1.0f);

	unsigned int start = offsets[positionId];
	unsigned int end = offsets[positionId+1];
	unsigned int numInfl = (end > start) ? (end - start) : 0;

	float4 finalPosition = initialPosition;
	if ( dqHasNonRigidTransforms ) {
		// Perform 1st phase LBS on non-rigid transformations
		finalPosition = deformVectorLinear(&influences[start], &weights[start], numInfl,
                                            finalPosition, dqMultMatrices);
	}

	// Perform 2nd phase DQS on rigid transformations
	finalPosition = deformPositionDualQuat(&influences[start], &weights[start], numInfl,
                                            finalPosition, dqInfluenceVecs);

	// write the finalPosition to the output buffer
	finalPos[positionOffset] = finalPosition.x;
	finalPos[positionOffset+1] = finalPosition.y;
	finalPos[positionOffset+2] = finalPosition.z;
}


__kernel void skinCluster_deformNormals(
	__global float* finalNormal,						//float3
	__global const float* initialNormal,				//float3
	__global const unsigned int* normalToPositionMap,
	__global const float* weights,
	__global const unsigned int* influences,
	__global const unsigned int* offsets,
	__global const float4* multMatrices, //__constant
	const uint normalCount)
{
    unsigned int normalId = get_global_id(0);			// access finalPos and initialPos using this value
	if (normalId >= normalCount) return;				// This allows us to have a larger block size without worrying if the buffer if a multiple of 512
	unsigned int normalOffset = normalId * 3; // it is a float3
	unsigned int positionId = normalToPositionMap[normalId];
	float4 initialNorm = (float4)(initialNormal[normalOffset], initialNormal[normalOffset+1], initialNormal[normalOffset+2], 0.0f);
	
    unsigned int start = offsets[positionId];
	unsigned int end = offsets[positionId+1];
    unsigned int numInfl = (end > start) ? (end - start) : 0;
    
	float4 finalNorm = deformVectorLinear(&influences[start], &weights[start], numInfl,
                                          initialNorm, multMatrices);

	finalNorm = normalize(finalNorm);

	// write output
    finalNormal[normalOffset] = finalNorm.x;
	finalNormal[normalOffset + 1] = finalNorm.y;
	finalNormal[normalOffset + 2] = finalNorm.z;
}


__kernel void skinCluster_deformNormalsDualQuat(
	__global float* finalNormal,						//float3
	__global const float* initialNormal,				//float3
	__global const unsigned int* normalToPositionMap,
	__global const float* weights,
	__global const unsigned int* influences,
	__global const unsigned int* offsets,
	__global const float4* dqMultMatrices,
	__global const float4* dqInfluenceVecs,
	const uint             dqHasNonRigidTransforms,
	const uint             normalCount)
{
    unsigned int normalId = get_global_id(0);			// access finalPos and initialPos using this value
	if (normalId >= normalCount) return;				// This allows us to have a larger block size without worrying if the buffer if a multiple of 512
	unsigned int normalOffset = normalId * 3; // it is a float3
	unsigned int positionId = normalToPositionMap[normalId];
	float4 initialNorm = (float4)(initialNormal[normalOffset], initialNormal[normalOffset+1], initialNormal[normalOffset+2], 0.0f);
	
    unsigned int start = offsets[positionId];
	unsigned int end = offsets[positionId+1];
    unsigned int numInfl = (end > start) ? (end - start) : 0;

	float4 finalNorm = initialNorm;
	if ( dqHasNonRigidTransforms ) {
		// Perform 1st phase LBS on non-rigid transformations
		finalNorm = deformVectorLinear(&influences[start], &weights[start], numInfl,
                                        finalNorm, dqMultMatrices);
	}

	// Perform 2nd phase DQS on rigid transformations
	finalNorm = deformNormalDualQuat(&influences[start], &weights[start], numInfl,
                                      finalNorm, dqInfluenceVecs);

	finalNorm = normalize(finalNorm);

	// write output
	finalNormal[normalOffset] = finalNorm.x;
	finalNormal[normalOffset + 1] = finalNorm.y;
	finalNormal[normalOffset + 2] = finalNorm.z;
}


// Blended does both classic linear and dual-quat skinning and blends them together based on an extra weight array.
__kernel void skinCluster_deformPositionsBlended(
	__global float* finalPos,							//float3
	__global const float* initialPos,					//float3
	__global const float* weights,
	__global const unsigned int* influences,
	__global const unsigned int* offsets,
	__global const float4* lbsMultMatrices,
	__global const float4* dqMultMatrices,
	__global const float4* dqInfluenceVecs,
	const uint             dqHasNonRigidTransforms,
	__global const float*  blendWeights,
	const uint             positionCount)
{
	unsigned int positionId = get_global_id(0);				// access finalPos and initialPos using this value
	if (positionId >= positionCount ) return;				// We create an execute unit for more indices then we have data for, just exit early if this guy if one of the extras
	unsigned int positionOffset = positionId * 3;			// Base positions are float3 when they come in here!
	float4 initialPosition = (float4)(initialPos[positionOffset], initialPos[positionOffset+1], initialPos[positionOffset+2], 1.0f);

	unsigned int start = offsets[positionId];
	unsigned int end = offsets[positionId+1];
	unsigned int numInfl = (end > start) ? (end - start) : 0;

	float blendWeight = blendWeights[positionId];

	float4 linearPosition   = initialPosition;
	float4 dualQuatPosition = initialPosition;
    
	// weight 0 is all linear, weight 1 is all dual-quat
	// Large patches of verts with exactly 1 or 0 will be common, so this can skip a lot of work.
	if (blendWeight != 1.0f) {
		linearPosition = deformVectorLinear(&influences[start], &weights[start], numInfl,
                                             linearPosition, lbsMultMatrices);
	}

	if (blendWeight != 0.0f) {
		if ( dqHasNonRigidTransforms ) {
			// 1st phase LBS on non-rigid transforms
			dualQuatPosition = deformVectorLinear(&influences[start], &weights[start], numInfl,
                                                   dualQuatPosition, dqMultMatrices);
		}

		// 2nd phase DQS on rigid transforms
		dualQuatPosition = deformPositionDualQuat(&influences[start], &weights[start], numInfl,
                                                   dualQuatPosition, dqInfluenceVecs);
	}
	
	float4 finalPosition = (dualQuatPosition * blendWeight) + (linearPosition * (1.0f - blendWeight));

	// write the finalPosition to the output buffer
	finalPos[positionOffset] = finalPosition.x;
	finalPos[positionOffset+1] = finalPosition.y;
	finalPos[positionOffset+2] = finalPosition.z;
}




// Blended does both classic linear and dual-quat skinning and blends them together based on an extra weight array.
__kernel void skinCluster_deformNormalsBlended(
	__global float* finalNormal,							//float3
	__global const float* initialNormal,					//float3
	__global const unsigned int* normalToPositionMap,
	__global const float* weights,
	__global const unsigned int* influences,
	__global const unsigned int* offsets,
	__global const float4* lbsMultMatrices,
	__global const float4* dqMultMatrices,
	__global const float4* dqInfluenceVecs,
	const uint             dqHasNonRigidTransforms,
	__global const float*  blendWeights,
	const uint             normalCount)
{
	unsigned int normalId = get_global_id(0);			// access finalPos and initialPos using this value
	if (normalId >= normalCount) return;				// This allows us to have a larger block size without worrying if the buffer if a multiple of 512
	unsigned int normalOffset = normalId * 3; // it is a float3
	unsigned int positionId = normalToPositionMap[normalId];
	float4 initialNorm = (float4)(initialNormal[normalOffset], initialNormal[normalOffset+1], initialNormal[normalOffset+2], 0.0f);

	unsigned int start = offsets[positionId];
	unsigned int end = offsets[positionId+1];
	unsigned int numInfl = (end > start) ? (end - start) : 0;

	float blendWeight = blendWeights[positionId];

	float4 linearNormal   = initialNorm;
	float4 dualQuatNormal = initialNorm;
    
	// weight 0 is all linear, weight 1 is all dual-quat
	// Large patches of verts with exactly 1 or 0 will be common, so this can skip a lot of work.
	if (blendWeight != 1.0f) {
		linearNormal = deformVectorLinear(&influences[start], &weights[start], numInfl,
                                           linearNormal, lbsMultMatrices);
	}

	if (blendWeight != 0.0f) {
		if ( dqHasNonRigidTransforms ) {
			// 1st phase LBS on non-rigid transforms
			dualQuatNormal = deformVectorLinear(&influences[start], &weights[start], numInfl,
                                                 dualQuatNormal, dqMultMatrices);
		}

		// 2nd phase DQS on rigid transforms
		dualQuatNormal = deformNormalDualQuat(&influences[start], &weights[start], numInfl,
                                               dualQuatNormal, dqInfluenceVecs);
	}
	
	float4 finalNorm = (dualQuatNormal * blendWeight) + (linearNormal * (1.0f - blendWeight));
	finalNorm = normalize(finalNorm);

	// write the finalPosition to the output buffer
	finalNormal[normalOffset] = finalNorm.x;
	finalNormal[normalOffset+1] = finalNorm.y;
	finalNormal[normalOffset+2] = finalNorm.z;
}


// Old versions, to be removed

__kernel void skinCluster_deformPositions_old(
	__global float* finalPos,							//float3
	__global const float* initialPos,					//float3
	__global const float* weights,
	__global const unsigned int* influences,
	__global const unsigned int* offsets,
	__global const float4* multMatrices,
	const uint positionCount)
{
	unsigned int positionId = get_global_id(0);				// access finalPos and initialPos using this value
	if (positionId >= positionCount ) return;					// We create an execute unit for more indices then we have data for, just exit early if this guy if one of the extras
	unsigned int positionOffset = positionId * 3;				// Base positions are float3 when they come in here!
	float4 initialPosition;
	initialPosition.x = initialPos[positionOffset];
	initialPosition.y = initialPos[positionOffset+1];
	initialPosition.z = initialPos[positionOffset+2];
	initialPosition.w = 1.0f;

	float4 finalPosition;
	finalPosition.x = 0.0f;
	finalPosition.y = 0.0f;
	finalPosition.z = 0.0f;
	finalPosition.w = 1.0f;

	unsigned int end = offsets[positionId+1];
	for(unsigned int start = offsets[positionId]; start<end; start++)
	{
		float weight = weights[start];
		unsigned int influence = (influences[start]) * 4; // This is how far into the matrix array we need to offset to find the matrix we care about.  The matrix array is declared as a float4 array and each matrix is 4 of those, so we have to multiply by an extra 4 to get where we want to be.
		finalPosition.x = mad (weight, dot (initialPosition, multMatrices[influence]), finalPosition.x);
		finalPosition.y = mad (weight, dot (initialPosition, multMatrices[influence+1]), finalPosition.y);
		finalPosition.z = mad (weight, dot (initialPosition, multMatrices[influence+2]), finalPosition.z);
	}

	// write the finalPosition to the output buffer
	finalPos[positionOffset] = finalPosition.x;
	finalPos[positionOffset+1] = finalPosition.y;
	finalPos[positionOffset+2] = finalPosition.z;
}


__kernel void skinCluster_deformNormals_old(
	__global float* finalNormal,						//float3
	__global const float* initialNormal,				//float3
	__global const unsigned int* normalToPositionMap,
	__global const float* weights,
	__global const unsigned int* influences,
	__global const unsigned int* offsets,
	__global const float4* multMatrices, //__constant
	const uint normalCount)
{
    unsigned int normalId = get_global_id(0);			// access finalPos and initialPos using this value
	if (normalId >= normalCount) return;							// This allows us to have a larger block size without worrying if the buffer if a multiple of 512
	unsigned int normalOffset = normalId * 3; // it is a float3
	unsigned int positionId = normalToPositionMap[normalId];
	float4 initialNorm;
	initialNorm.x = initialNormal[normalOffset];
	initialNorm.y = initialNormal[normalOffset+1];
	initialNorm.z = initialNormal[normalOffset+2];
	initialNorm.w = 1.0f;
	
	float4 finalNorm;
	finalNorm.x = 0.0f;
	finalNorm.y = 0.0f;
	finalNorm.z = 0.0f;
	finalNorm.w = 0.0f;

	unsigned int end = offsets[positionId+1];
	for (unsigned int start = offsets[positionId]; start < end; start++)
	{
		float weight = weights[start];
		unsigned int influence = influences[start];

		finalNorm.x = mad( weight, dot(initialNorm, multMatrices[influence*4]),   finalNorm.x);		
		finalNorm.y = mad( weight, dot(initialNorm, multMatrices[influence*4+1]), finalNorm.y);
		finalNorm.z = mad( weight, dot(initialNorm, multMatrices[influence*4+2]), finalNorm.z);
	}
	finalNorm = normalize(finalNorm);

	// write output
    finalNormal[normalOffset] = finalNorm.x;
	finalNormal[normalOffset + 1] = finalNorm.y;
	finalNormal[normalOffset + 2] = finalNorm.z;
}