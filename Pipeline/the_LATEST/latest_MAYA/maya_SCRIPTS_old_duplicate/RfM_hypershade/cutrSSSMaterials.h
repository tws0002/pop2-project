/* Created by Cutter [6.5.6] on 8.27.2013 at 6:28:57.
   Source file:
   "/Users/mkesson/Documents/WebSite/FUNDZA_COM/rman_hypershade/sss/SSSMaterials.h"
*/

#ifndef cutrSSSMaterials_h
#define cutrSSSMaterials_h

/*
<rman id="rslt">
slim 1 extensions cutter {
	extensions fundza cutr {
		template void SSSMaterials {
			userdata {
				rfm_nodeid 1053504
				rfm_classification rendernode/RenderMan/utility
				}
			parameter float material {
				label {material}
				subtype {selector}
				range {"apple" 1 "chicken1" 2 "chicken2" 3 "cream" 4 "ketchup" 5 "marble" 6 "potato" 7 "skimmilk" 8 "skin1" 9 "skin2" 10 "wholemilk" 11}
				}
			parameter {output color} albedo {
				detail mustvary
				}
			parameter {output color} dmfp {
				detail mustvary
				}
			RSLPlugin RfMShadeops
			RSLInclude "[file join [GetEnv RfM_HYPERSHADE_DIR] cutrSSSMaterials.h]"
			RSLFunction {}
			}
		}
	}
</rman>
*/

void cutrSSSMaterials(float material;  output color albedo; output color dmfp ) {
if(material == 1) 		{ albedo = color(0.846,0.841,0.528); dmfp = color(6.96,6.40,1.90); }
else if(material == 2) 	{ albedo = color(0.314,0.156,0.126); dmfp = color(11.61,3.88,1.75); }
else if(material == 3) 	{ albedo = color(0.321,0.160,0.108); dmfp = color(9.44,3.35,1.79); }
else if(material == 4) 	{ albedo = color(0.976,0.900,0.725); dmfp = color(15.03,4.66,2.54); }
else if(material == 5) 	{ albedo = color(0.164,0.006,0.002); dmfp = color(4.76,0.58,0.39); }
else if(material == 6) 	{ albedo = color(0.830,0.791,0.753); dmfp = color(8.51,5.57,3.95); }
else if(material == 7) 	{ albedo = color(0.764,0.613,0.213); dmfp = color(14.27,7.23,2.04); }
else if(material == 8) 	{ albedo = color(0.815,0.813,0.682); dmfp = color(18.42,10.44,3.50); }
else if(material == 9) 	{ albedo = color(0.436,0.227,0.131); dmfp = color(3.67,1.37,0.68); }
else if(material == 10) { albedo = color(0.623,0.433,0.343); dmfp = color(4.82,1.69,1.09); }	
else 			 		{ albedo = color(0.908,0.881,0.759); dmfp = color(10.90,6.58,2.51); }
}

#endif
