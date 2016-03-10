#ifndef cutrColorByHeight_h
#define cutrColorByHeight_h

/*
<rman id="rslt">
slim 1 extensions cutter {
	extensions fundza cutr {
		template void ColorByHeight {
			userdata {
				rfm_nodeid 1053503
				rfm_classification rendernode/RenderMan/utility
				}
			parameter float high {
				label {High}
				subtype {slider}
				range {0 10 0.05}
				default {10}
				}
			parameter float low {
				label {Low}
				subtype {slider}
				range {0 10 0.05}
				default {0}
				}
			parameter color highcolor {
				label {Color at High}
				default {0.3 0.6 0.2}
				}
			parameter color lowcolor {
				label {Color at Low}
				default {0.7 0.4 0.4}
				}
			parameter {output color} result {
				detail mustvary
				}
			RSLPlugin RfMShadeops
			RSLInclude "[file join [GetEnv RfM_HYPERSHADE_DIR] cutrColorByHeight.h]"
			RSLFunction {}
			}
		}
	}
</rman>
*/

void cutrColorByHeight(float 	high, low; color  highcolor, lowcolor; output varying color result ) {
	point originC = point "object" (0,0,0);
	point originW = transform("world", originC);
	float blend = smoothstep(low, high, originW[1]);
	result = mix(highcolor, lowcolor, blend);
}

#endif
