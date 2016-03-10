// OPTME: We could optimize this kernel by using __constant keyword
// for kernel parameter:
// - const struct TransformationMatrix* matrices
//
// This was done because of a bug with __constant on older hardware 
// that could be detected at run-time instead, but that would require
// inelegant tricks to do so.


float3 mul( float16 matrix , float3 point )
{
    const float4 homogeneousPoint = (float4)( point.xyz , 1.0 );
    const float4 transformedPoint = (float4)(
        dot( homogeneousPoint , matrix.s048c ) ,
        dot( homogeneousPoint , matrix.s159d ) ,
        dot( homogeneousPoint , matrix.s26ae ) ,
        dot( homogeneousPoint , matrix.s37bf )
        );
    return transformedPoint.xyz / transformedPoint.w;
}


__kernel void clusterRigidTransform(
    __global float* finalPos ,
    __global const float* initialPos ,
    const float16 rigidTransform ,
    const uint positionCount
    )
{
    unsigned int positionId = get_global_id(0);
    if ( positionId >= positionCount ) return;

    float3 initialPosition = vload3( positionId , initialPos );
    float3 finalPosition = mul( rigidTransform , initialPosition );
    vstore3( finalPosition , positionId , finalPos );
}




__kernel void clusterConstantWeights(
    __global float* finalPos ,
    __global const float* initialPos ,
    const float16 rigidTransform ,
    const uint positionCount
    )
{
    // OPTME: We could use the same kernel.
    clusterRigidTransform( finalPos , initialPos , rigidTransform , positionCount );
}




// Utility functions to manipulate vectors and quaternions.
float3 lerp( const float3 a , const float3 b , const float factor )
{
    return a + factor * ( b - a );
}

float4 quaternion_conjugate( const float4 quaternion )
{
    return (float4)( -quaternion.xyz , quaternion.w );
}

float4 quaternion_multiply( const float4 q1 , const float4 q2 )
{
    return quaternion_conjugate(
        q1.zxyw*q2.yzxw - q1.ywzx*q2.zywx - q1.wyxz*q2.xwyz - q1.xzwy*q2.wxzy
        );
}

float3 quaternion_transform( const float4 q , const float3 p )
{
    const float3 v = p + p;
    const float3 qv = q.xyz * v;
    const float3 result = q.w*(cross(q.xyz, v) + q.w*v) + q.xyz*(qv.xyz + qv.yzx + qv.zxy) - p;
    return result;
}

float4 quaternion_lerp( const float4 a , const float4 b , const float factor )
{
    return normalize( a + factor * ( b - a ) );
}

// OPTME: Other slerp implementations might be more optimal.
float4 quaternion_slerp( const float4 q1 , const float4 q2 , const float factor )
{
    float2 weights = (float2)( 1.0 - factor , factor );

    const float cosTheta = dot( q1 , q2 );

    // Perform linear interpolation if quaternions are too close to each other.
    // Hard-coded threshold is kind of arbitrary.
    if ( fabs( cosTheta ) < ( 1.0 - 0.000001 ) )
    {
        // No need for inverseSinTheta if we normalize at the end.
        // const float inverseSinTheta = rsqrt( 1.0 - cosTheta * cosTheta );
        const float theta = acos( cosTheta );
        
        weights = sin( weights * theta ); // * inverseSinTheta;
    }

    return normalize( weights.x * q1 + weights.y * q2 );
}


struct TransformationMatrix
{
    float16 matrix;

    float3 scalePivotPoint;
    float3 scale;
    float3 shear;
    float3 scalePivotTranslation;
    float3 rotatePivotPoint;
    float4 rotationOrientation;
    float4 rotation;
    float3 rotatePivotTranslation;
    float3 translation;

    float4 padding[3];
};


__kernel void clusterPerVertexWeights(
    __global float* finalPos ,
    __global const float* initialPos ,
    __global const float* weights ,
    const struct TransformationMatrix matrixA,
    const struct TransformationMatrix matrixB,
    const float envelope ,
    const uint positionCount
    )
{
    unsigned int positionId = get_global_id(0);
    if ( positionId >= positionCount ) return;

    const float weight = envelope * weights[ positionId ];

    float3 initialPosition = vload3( positionId , initialPos );

    // Perform interpolation at the same time as transformation of the point.
    // Because the resulting blended transformation is used only once, it's
    // better to apply transformation as we go instead of building a
    // transformation matrix.
    float3 finalPosition = initialPosition;

    // Before matrix is in matrixA.
    finalPosition = mul( matrixA.matrix , finalPosition );

    // [Sp]^-1
    float3 scalePivotPoint = matrixB.scalePivotPoint;
    finalPosition -= scalePivotPoint;
    // [S]
    float3 scale = lerp( matrixA.scale , matrixB.scale , weight );
    finalPosition *= scale;
    // [Sh]
    float3 shear = lerp( matrixA.shear , matrixB.shear , weight );
    finalPosition = (float3)(
        finalPosition.x + shear.s0 * finalPosition.y + shear.s1 * finalPosition.z ,
        finalPosition.y + shear.s2 * finalPosition.z ,
        finalPosition.z
        );
    // [Sp]
    finalPosition += scalePivotPoint;
    // [St]
    float3 scalePivotTranslation = lerp( matrixA.scalePivotTranslation , matrixB.scalePivotTranslation , weight );
    finalPosition += scalePivotTranslation;
    // [Rp]^-1
    float3 rotatePivotPoint = matrixB.rotatePivotPoint;
    finalPosition -= rotatePivotPoint;
    // [Ro]
    float4 rotationOrientation = quaternion_slerp( matrixA.rotationOrientation , matrixB.rotationOrientation , weight );
    // [R]
    float4 rotation = quaternion_slerp( matrixA.rotation , matrixB.rotation , weight );
    finalPosition = quaternion_transform(
        quaternion_multiply( rotation , rotationOrientation ) ,
        finalPosition
        );
    // [Rp]
    finalPosition += rotatePivotPoint;
    // [Rt]
    float3 rotatePivotTranslation = lerp( matrixA.rotatePivotTranslation , matrixB.rotatePivotTranslation , weight );
    finalPosition += rotatePivotTranslation;
    // [T]
    float3 translation = lerp( matrixA.translation , matrixB.translation , weight );
    finalPosition += translation;

    // After matrix is in matrixB.
    finalPosition = mul( matrixB.matrix , finalPosition );

    vstore3( finalPosition , positionId , finalPos );
}
