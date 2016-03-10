#include "bif2prt.h"
#include <algorithm>

#include <bifrostapi/bifrost_om.h>
#include <bifrostapi/bifrost_stateserver.h>
#include <bifrostapi/bifrost_component.h>
#include <bifrostapi/bifrost_fileio.h>
#include <bifrostapi/bifrost_fileutils.h>
#include <bifrostapi/bifrost_string.h>
#include <bifrostapi/bifrost_array.h>
#include <bifrostapi/bifrost_ref.h>
#include <bifrostapi/bifrost_layout.h>
#include <bifrostapi/bifrost_tiledata.h>

namespace {
template <typename T>
T aton( const std::string &Text, T defValue = T() )
{
    std::stringstream ss;
    for ( std::string::const_iterator i=Text.begin(); i!=Text.end(); ++i )
        if ( isdigit(*i) || *i=='e' || *i=='-' || *i=='+' || *i=='.' )
            ss << *i;
    T result;
    return ss >> result ? result : defValue;
}

void usage(char **argv)
{
    std::cerr << "Usage:" << std::endl;
	std::cerr << "   bif2prt.exe " << "[-den -pos -vel -vor -scl value]" << "-f file.bif " << "[-o file.prt]" << std::endl;
	std::cerr << "   -den: density channel. " << std::endl;	
	std::cerr << "   -pos: position channel. " << std::endl;	
	std::cerr << "   -vel: velocity channel. " << std::endl;	
	std::cerr << "   -vor: vorticity channel. " << std::endl;	
	std::cerr << "   note: if no channel options are specified, all channels in the BIF file will be considered." << std::endl;	
	std::cerr << std::endl;
	std::cerr << "   -scl: scaling value for the position channel (default to the inverse of the layout's voxel scale value.)" << std::endl;	
	std::cerr << "   -f file.bif: mandatory BIF file to load." << std::endl;
	std::cerr << "   -o file.prt: optional .prt file to generate. If omitted, the BIF file name is used as the .prt file name." << std::endl;
	std::cerr << std::endl;
	std::cerr << "   e.g. bif2prt.exe -pos -vel -vor -f myfile.bif" << std::endl;
}

char* getOption( char** begin, char** end, const std::string & option )
{
    char ** itr = std::find(begin, end, option);
    if (itr != end && ++itr != end)
    {
        return *itr;
    }
    return 0;
}

}

int main(int argc, char **argv)
{
	if (argc < 2 ) {
		usage( argv );
		exit(1);
	}

	Bifrost::API::StringArray optionNames;

	char* option = getOption( argv, argv+argc, "-den" );	
	if (option) {
		optionNames.add( "density" );
	}

	option = getOption( argv, argv+argc, "-pos" );	
	if (option) {
		optionNames.add( "position" );
	}

	option = getOption( argv, argv+argc, "-vel" );	
	if (option) {
		optionNames.add( "velocity" );
	}

	option = getOption( argv, argv+argc, "-vor" );	
	if (option) {
		optionNames.add( "vorticity" );
	}

	float scale = 0.0f;
	option = getOption( argv, argv+argc, "-scl" );	
	if (option) {
		scale = aton( option, 0.0f );
	}

	option = getOption( argv, argv+argc, "-f" );
	Bifrost::API::String biffile;
	size_t pos;
	if (option) {
		biffile = Bifrost::API::File::forwardSlashes( option );
		pos = biffile.rfind(".bif");
		if (pos==Bifrost::API::String::npos) {
			usage( argv );
			exit(1);
		}
	}

	option = getOption( argv, argv+argc, "-o" );
	Bifrost::API::String prtfile;
	if (option) {
		prtfile = Bifrost::API::File::forwardSlashes( option );
	}
	else {
		prtfile = biffile.substr( 0 , pos );
		prtfile += ".prt";
	}

	Bifrost::API::ObjectModel om;
	Bifrost::API::FileIO fileio = om.createFileIO( biffile );
	Bifrost::API::StateServer ss = fileio.load( );

	if ( !ss.valid() ) {
		std::cerr << "bif2prt : file loading error" << std::endl;
		exit(1);
	}

	Bifrost::API::Component component = ss.components()[0];
	if ( component.type() != Bifrost::API::PointComponentType ) {
		std::cerr << "bif2prt : wrong component (" << component.type() << ")" << std::endl;
		exit(1);
	}

	// select channels as specified on input
	Bifrost::API::Channel posCh;
	PRTConverter::ChannelPairNames namePairs;
	Bifrost::API::RefArray channels = component.channels();
	for (size_t i=0; i<optionNames.count(); i++ ) {
		Bifrost::API::String optionName = optionNames[i];
		for (size_t j=0; j<channels.count(); j++ ) {
			Bifrost::API::String chname = Bifrost::API::Base(channels[j]).name();
			if ( chname.find( optionName ) != Bifrost::API::String::npos ) {
				if ( optionName == "position" ) {
					posCh = channels[j];
					namePairs.push_back( PRTConverter::Pair(chname,"Position") );
					break;
				}
				else if ( optionName == "velocity" ) {
					namePairs.push_back( PRTConverter::Pair(chname,"Velocity") );
					break;
				}
				else if ( optionName == "vorticity" ) {
					namePairs.push_back( PRTConverter::Pair(chname,"Vorticity") );
					break;
				}
				else if ( optionName == "density" ) {
					namePairs.push_back( PRTConverter::Pair(chname,"Density") );
					break;
				}
			}
		}
	}

	// get all the component channels by default
	if ( optionNames.count() == 0 ) {
		Bifrost::API::RefArray channels = component.channels();
		for (size_t i=0; i<channels.count(); i++ ) {
			Bifrost::API::String chname = Bifrost::API::Base(channels[i]).name();
			// Use PRT naming convention
			if ( chname.find( "position" ) != Bifrost::API::String::npos ) {
				posCh = channels[i];
				namePairs.push_back( PRTConverter::Pair(chname,"Position") );
			}
			else if ( chname.find( "velocity" ) != Bifrost::API::String::npos ) {
				namePairs.push_back( PRTConverter::Pair(chname,"Velocity") );
			}
			else if ( chname.find( "vorticity" ) != Bifrost::API::String::npos ) {
				namePairs.push_back( PRTConverter::Pair(chname,"Vorticity") );
			}
			else if ( chname.find( "density" ) != Bifrost::API::String::npos ) {
				namePairs.push_back( PRTConverter::Pair(chname,"Density") );
			}
			else {
				// for other channels we use the last token in the channel name as the PRT name
				Bifrost::API::StringArray splitName = chname.split("/");
				Bifrost::API::String validPRTName;
				if ( splitName.count() == 1 ) {
					// there is no / separator
					validPRTName = splitName[0]; 
				}
				else {
					validPRTName = splitName[1];
				}
				namePairs.push_back( PRTConverter::Pair(chname,validPRTName.data()) );
			}
		}
	}
	
	// scale the position channel
	if ( posCh ) {
		Bifrost::API::Layout layout = component.layout();
		size_t depthCount = layout.depthCount();

		if (scale == 0.0f) {
			// use inverse of voxel scale by default
			float voxelScale = layout.voxelScale();

			if ( voxelScale == 0.0f ) {
				// just to be on the safe side
				voxelScale = 1.0f;
			}

			scale = 1.0f/voxelScale;
		}

		for ( size_t d=0; d<depthCount; d++ ) {
			size_t tcount = layout.tileCount(d);
			for ( size_t t=0; t<tcount; t++ ) {
				Bifrost::API::TreeIndex tindex(t,d);
				if ( !posCh.elementCount( tindex ) ) {
					// nothing there
					continue;
				}

				Bifrost::API::TileData<amino::Math::vec3f> f3 = posCh.tileData<amino::Math::vec3f>( tindex );
				for (size_t i=0; i<f3.count(); i++ ) {
					f3[i] *= scale;
				}
			}
		}
	}

	PRTConverter prt;
	bool result = prt.write( prtfile.data(), component, namePairs );
	if (!result) {
		std::cerr << "bif2prt: Conversion failed" << std::endl;
		exit(1);
	}
	else {
		std::cerr << "bif2prt: Conversion succeeded!" << std::endl;
		std::cerr << "File created: " << Bifrost::API::File::backwardSlashes(prtfile).data() << std::endl;
	}

	return 0;
}