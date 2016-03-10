/*
A rif that accepts one input that will be applied as a scaling factor to
all shading rates except those with a value of 100 or higher. Geometric
light sources, by default, use ShadingRate 100. The rif is useful in
circumstances where, say, a 4K image will be rendered and low shading
rates crash PRMan because of insufficient memory. 
Malcolm Kesson
Started: 12 Oct 2014
*/

#include <stdio.h>
#include <stdlib.h>
#include <RifPlugin.h>
#include <RifFilter.h>
#include <string>
//#include <sstream>
//#include <RixInterfaces.h>
//#include <rx.h>
//#include <ri.h>

class ShadingRate : public RifPlugin {
	public:
			 ShadingRate(RtFloat scalingFactor);
	virtual ~ShadingRate() { }	
	virtual RifFilter &GetFilter() { return m_filter; }
	
	private:
		RifFilter   m_filter;
		RtInt		m_rate_scaler;
		static RtVoid	shadingRate(RtFloat rate);
	};

RifPlugin *RifPluginManufacture(int argc, char **argv) {
	RtFloat n = 1;
	if(argc > 0)
		n = atof(argv[0]);
	n = (n < 0) ? 1 : n;
    return new ShadingRate(n);
	}
	
// Constructor
ShadingRate::ShadingRate(RtFloat scaleFactor) {
	m_filter.ShadingRate = shadingRate;  // install our custom callback
	m_rate_scaler = scaleFactor;
	}
// 
RtVoid ShadingRate::shadingRate(RtFloat rate) {
	ShadingRate *self = static_cast<ShadingRate*> (RifGetCurrentPlugin());
	// Do not apply to ShadingRate's belonging to lights. They have a
	// rate of 100
	RtFloat newrate = rate;
	if(rate < 100)
		newrate = self->m_rate_scaler * rate;
	RiShadingRate(newrate);
	}






















