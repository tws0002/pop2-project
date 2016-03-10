
#ifndef cutrColorByCollision_h
#define cutrColorByCollision_h

/*
<rman id="rslt">
slim 1 extensions cutter {
	extensions fundza cutr {
		template void ColorByCollision {
			userdata {
				rfm_nodeid 1053511
				rfm_classification rendernode/RenderMan/utility
				}
			parameter float dist {
				label {Distance}
				subtype {slider}
				range {0 1 0.05}
				default {0.2}
				}
			parameter float samples {
				label {Samples}
				subtype {slider}
				range {1 64 1}
				default {5}
				}
			parameter float samplingAngle {
				label {Sample Angle}
				subtype {slider}
				range {0 1 0.05}
				default {2}
				}
			parameter float compute {
				label {Compute}
				subtype {selector}
				range {"Single Point Cloud" 1 "Bake Point Clouds" 2 "Reuse Point Clouds" 3}
				default {2}
				}
			parameter string ptcName {
				label {Ptc Path}
				subtype {texture}
				default {}
				}
			parameter string dataChannel {
				label {Data Channel Name}
				default {collisions}
				}
			parameter color preCollision {
				label {Pre Collision Color}
				default {1 .7 .4}
				}
			parameter color postCollision {
				label {Post Collision Color}
				default {1 0 0}
				}

			parameter {output color} resultC {
				detail mustvary
				}
			parameter {output float} mask {
				detail mustvary
				}
			RSLPlugin RfMShadeops
			RSLInclude "[file join [GetEnv RfM_HYPERSHADE_DIR] cutrColorByCollision.h]"
			RSLFunction {}
			}
		}
	}
</rman>
*/

void cutrColorByCollision(float  dist; float  samples; float  samplingAngle; 
					float  compute; 
					string  ptcName; string  dataChannel; 
					color  preCollision; color  postCollision;
					output varying color resultC; 
					output varying float mask; ) {
resultC = preCollision;
mask = 0;

string passClass;
option("user:pass_class", passClass);

float	raydepth = 2;
rayinfo("depth", raydepth);
if(raydepth > 0)
	return;

uniform float	frameNum = 0;
uniform float 	id = 0;
option("Frame", frameNum);
attribute("identifier:id", id);

//point	fakeP = point "world" (id + random() * 0.00001, 0, 0);
point	fakeP = point "world" (id, 0, 0);
fakeP = transform("world", fakeP);
normal	fakeN = normal(0,0,0);
float 	collision = 0;
fakeP[0] += random() * 0.00001;
fakeP[1] = 0;
fakeP[2] = 0;
//printf("%s  %1.9p\n", passClass,fakeP);
/*
if(passClass == "Final") {
	texture3d(ptcName, fakeP, fakeN, dataChannel, collision);
	if(collision > 0) {
		resultC = postCollision;
		mask = 1;
		}
	return;
	}
*/
if(ptcName != "" && frameNum == 0) {
    bake3d(ptcName, dataChannel, fakeP, fakeN, dataChannel, 0.0);
	}

else if(ptcName != "") {
	if(texture3d(ptcName, fakeP, fakeN, dataChannel, collision) == 0) {
		collision = 0;
		}
	if(collision != 1) {
		float	len = 1000000;
		gather("illuminance", P, N, radians(samplingAngle), samples, "ray:length", len) {
			if(len <= dist)
				collision = 1;
			}
		}
	else
		collision = 1;
	if(collision > 0) {
		resultC = postCollision;
		mask = 1;
    	bake3d(ptcName, dataChannel, fakeP, fakeN, dataChannel, 1);
		}
	}
}

#endif
