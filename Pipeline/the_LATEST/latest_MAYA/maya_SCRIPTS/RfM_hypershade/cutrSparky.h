/* Created by Malcolm Kesson
*/

#ifndef cutrSparky_h
#define cutrSparky_h

/*
<rman id="rslt">
slim 1 extensions cutter {
	extensions fundza cutr {
		template void Sparky {
			userdata {
				rfm_nodeid 1053514
				rfm_classification rendernode/RenderMan/utility
				}
			parameter float age {
				label {Age}
				subtype {slider}
				range {0 1 0.05}
				default {0.5}
				}
			parameter float width {
				label {Width}
				subtype {slider}
				range {0 1 0.05}
				default {0.01}
				}				
			parameter float rearblur {
				label {Rear Blur}
				subtype {slider}
				range {0 1 0.05}
				default {0.05}
				}
			parameter float frontblur {
				label {Front Blur}
				subtype {slider}
				range {0 1 0.05}
				default {0.0}
				}
			parameter color start {
				label {Start}
				default { 1 1 1 }
				}
			parameter color end {
				label {End}
				default { 0.5 0.8 1 }
				}
			parameter {output color} resultC {
				detail mustvary
				}
			parameter {output float} mask {
				detail mustvary
				}
			RSLPlugin RfMShadeops
			RSLInclude "[file join [GetEnv RfM_HYPERSHADE_DIR] cutrSparky.h]"
			RSLFunction {}
			}
		}
	}
</rman>
*/

void cutrSparky(float  	age, width, rearblur, frontblur; color   start, end; 
				output varying color resultC; output varying float mask) 
{
//resultC = mix(start, end, age);
mask = smoothstep(age - rearblur, width + age, v) * (1 - smoothstep(age, age + frontblur + width, v));
resultC = mix(start, end, mask);
}

#endif
