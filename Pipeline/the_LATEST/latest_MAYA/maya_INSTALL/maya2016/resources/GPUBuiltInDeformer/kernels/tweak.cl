__kernel void tweak(
    __global float* finalPos ,
    __global const float* initialPos ,
    __global const float* offsets ,
    const float envelope ,
    const uint positionCount
    )
{
    unsigned int positionId = get_global_id(0);
    if ( positionId >= positionCount ) return;

    float3 initialPosition = vload3( positionId , initialPos );
    float3 offset          = vload3( positionId , offsets );
    float3 finalPosition = initialPosition + envelope * offset;
    vstore3( finalPosition , positionId , finalPos );
}
