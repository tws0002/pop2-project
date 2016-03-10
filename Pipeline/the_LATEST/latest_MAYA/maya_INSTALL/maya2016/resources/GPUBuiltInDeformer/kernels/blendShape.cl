__kernel void blendShape(
    __global float* finalPos ,
    __global const float* initialPos ,
    __global const float* targetPosDelta ,
    const float weight ,
    const uint positionCount
    )
{
    unsigned int positionId = get_global_id(0);
    if ( positionId >= positionCount ) return;

    float3 initialPosition = vload3( positionId , initialPos );
    float3 targetPositionDelta = vload3( positionId , targetPosDelta );
    float3 finalPosition = initialPosition + targetPositionDelta * weight;
    vstore3( finalPosition , positionId , finalPos );
}
