#include "testXgExternalAPI.h"

#include <XGen/XgExternalAPI.h>

IMPL_TEST( testCreateDescription )
{
    std::map<std::string,std::string> defaultDescription;
    defaultDescription["PALETTE"] = "MyPalette";
    defaultDescription["DESCRIPTION"] = "MyDescription";
    defaultDescription["PRIMITIVE"] = "Spline";
    defaultDescription["GENERATOR"] = "Random";
    defaultDescription["RENDERER"] = "Renderman";
    defaultDescription["METHOD"] = "Guides";

    std::string palettes[2]        =   {"",  defaultDescription["PALETTE"]};
    std::string descriptions[2]    =   {"", defaultDescription["DESCRIPTION"]};
    std::string primitives[3]      =   {"INVALID_PRIMITIVE",  "",  defaultDescription["PRIMITIVE"]};
    std::string generators[3]      =   {"INVALID_GENERATOR",  "",  defaultDescription["GENERATOR"]};
    std::string renderers[3]       =   {"INVALID_RENDERER",  "",  defaultDescription["RENDERER"]};
    std::string methods[3]         =   {"INVALID_METHOD",  "",  defaultDescription["METHOD"]};

    for( int pal=0; pal<2; ++pal )
    for( int des=0; des<2; ++des )
    for( int pri=0; pri<3; ++pri )
    for( int gen=0; gen<3; ++gen )
    for( int ren=0; ren<3; ++ren )
    for( int met=0; met<3; ++met )
    {
        // skip the last iteration of all loops.  It contains all valid values
        // and is not appropriate for this test
        if( pal == 1 &&
            des == 1 &&
            pri == 2 &&
            ren == 2 &&
            met == 2 )
            continue;

        // call the createDescription api
        std::string res = xgapi::createDescription( palettes[pal],  descriptions[des],  primitives[pri],  generators[gen],  renderers[ren],  methods[met]);

        self_assertTrue(res == "",
            "xgapi.createDescription(\"" + palettes[pal] + "\",  \"" + descriptions[des] + "\",  \"" +
             primitives[pri] + "\",  \"" + generators[gen] + "\",  \"" + renderers[ren] + "\",  \"" + methods[met]              + "\")\n" + "Returned: \"" + res + "\"\nExpected: Empty String")
    }

    return MS::kSuccess;
}

