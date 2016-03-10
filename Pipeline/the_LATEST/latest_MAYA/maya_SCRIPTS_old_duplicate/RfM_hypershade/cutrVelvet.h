/* Created by Malcolm Kesson
*/

#ifndef cutrVelvet_h
#define cutrVelvet_h

/*
<rman id="rslt">
slim 1 extensions cutter {
	extensions fundza cutr {
		template void Velvet {
			userdata {
				rfm_nodeid 1053502
				rfm_classification rendernode/RenderMan/utility
				}
			parameter float rim_width {
				label {Edge Width}
				subtype {slider}
				range {0 1 0.05}
				default 0.5
				}
			parameter color inner {
				label {Inner Color}
				default { 0.505 0.788 0.407 } 
				}
			parameter color edge {
				label {Edge Color}
				default { 0.309 0.474 0.250 } 
				}
			parameter {output color} cresult {
				detail mustvary
				}
			RSLPlugin RfMShadeops
			RSLInclude "[file join [GetEnv RfM_HYPERSHADE_DIR] cutrVelvet.h]"
			RSLFunction {}
			}
		}
	}
</rman>
*/

void cutrVelvet(float rim_width; color inner; color edge; 
				output varying color cresult ) {
	normal n = normalize(N);
	normal nf = faceforward(n, I, n);
	vector i = normalize(-I);
	float  dot = 1 - i.nf;
	dot = smoothstep(1 - rim_width, 1.0, dot);
	cresult = mix(inner, edge, dot);
	}

#endif
