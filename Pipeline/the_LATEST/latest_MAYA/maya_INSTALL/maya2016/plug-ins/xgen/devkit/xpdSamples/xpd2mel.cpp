// Copyright 2014 Autodesk, Inc. All rights reserved. 
//
// Use of this software is subject to the terms of the Autodesk 
// license agreement provided at the time of installation or download, 
// or which otherwise accompanies this software in either electronic 
// or hard copy form.

/**
 * @file xpd2mel.cpp
 * @brief Convert an XPD file into a mel script.
 *
 * <b>CONFIDENTIAL INFORMATION: This software is the confidential and
 * proprietary information of Walt Disney Animation Studios ("WDAS").
 * This software may not be used, disclosed, reproduced or distributed
 * for any purpose without prior written authorization and license
 * from WDAS. Reproduction of any section of this software must include
 * this legend and all copyright notices.
 * Copyright Disney Enterprises, Inc. All rights reserved.</b>
 *
 * @author Thomas V Thompson II
 *
 * @version tthompso  01/27/05  Initial Version
 * @version bachorn   02/07/06  added circle extrusion
 * @version lgramlin  09/28/06  Update for xgen5 version of xpd
 */

#include <iostream>
#include <iomanip>
#include <string.h>
#include <stdlib.h>

#include <xpd/XpdFile.h>
#include <XGen/SgVec3T.h>
#include <XGen/XgUtil.h>

#include <set>

typedef safevector<float> XpdFullPrimF;
#include <map>

typedef std::map<const char*, int> StrIntArray;

#define AS_CURVE      0
#define AS_TWIST_TIE  1
#define AS_TUBE       2
#define AS_CAMERA_QUAD 3

using namespace std;

#ifdef WIN32
static char *optarg;
static int   optind;
int getopt( unsigned int argc, char** argv, const char* fmt )
{
    static char** s_argv = NULL;
    static unsigned int s_argc = 0;
    static unsigned int s_i = 0;
    static std::vector<std::string> s_args;
    static std::set<std::string> s_fmt;

    // If argv/argc pair changed, reinitialize the std::vector
    if( s_argv != argv || s_argc !=argc )
    {
        s_i = 0;
        s_args.clear();
        s_fmt.clear();
        s_argv = argv;
        s_argc = argc;

        for( unsigned i=0; i<argc; ++i )
        {
            std::string a = argv[i];
            if( a.find('"')==0 )
            {
                i++;
                while( i<argc )
                {
                    std::string b = argv[i++];
                    a+=b;

                    if( b.size()>0 && b.rfind('"')==b.size()-1 )
                    {
                        s_args.push_back( a );
                        break;
                    }
                }
            }
            else
            {
                s_args.push_back( a );
            }
        }

        // Extract the argument switches
        char buf[256];
        strncpy( buf, fmt, 256 );
        char* p = strtok( buf, ":" );
        while( p!=NULL )
        {
            s_fmt.insert( p );
            p = strtok( NULL, ":" );
        }
    }

    while( s_i<s_args.size() )
    {
        const std::string& s0 = s_args[s_i++];
        if( s_fmt.find(s0.substr(1))!=s_fmt.end() )
        {
            if( s_i<s_args.size() )
            {
                optarg = (char*)s_args[s_i++].c_str();
            }
            optind = s_i;

            int ret = s0.substr(1,1)[0];
            return ret;
        }
    }


    return -1;
}
#else
#include <unistd.h>
#endif

static std::string s_geomName = "pGeom01_desc";
static std::string s_descName = "desc";

//
// Use the xgutil pseudo random generator instead of drand48() from unistd.h
//
double drand48()
{
    static uint64_t id64 = 0;
    static xgutil::PRNG gen( id64 );
    return gen.random01();
}

//
// Produce a geo basename based on xgen name
//
void generateGeoName( const char* xgenDesc, const char* geom, char* elem, char* newName)
{
    int i=0, j=0;

    char buf[256];

    char* elemName = strrchr((char*)geom, '_');
    if(elemName)
       elemName++;

    if (elemName == 0 || (strlen(elemName) < 6) ) {
    cerr << "Non-conforming geom name: " << geom << endl;
    elemName = "xxxxAA";
    } else {
       elemName++;
    }

    // Grab the element label off the patchname
    strncpy(elem, geom+1, 6);
    elem[6] = 0;

    while(xgenDesc[i] != 0) {
    char c = xgenDesc[i++];

    if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
        buf[j++] = c;
    } else if (c >= '0' && c <= '9') {
        // Remap numbers to letters
        buf[j++] = c - '0' + 'A';
    }
    }

    // End string
    buf[j] = 0;

    sprintf(newName,"bc_xgenProxy%%d%s_%s",buf,elemName);
}

//
// Dump header.
//
void dumpHeader( int format, float radius )
{

    cout << "// Auto-generated code from xpd2mel" << endl;
    cout << endl;

    cout << "proc adjParent(string $elem){" << endl;
    cout << "    string $Xproxy = ($elem+\"_xgenProxy\");" << endl;
    cout << "    select -r $Xproxy;" << endl;
    cout << "    parent -w ;" << endl;
    cout << "    parent -r $Xproxy ($elem+\"_model\");" << endl;
    cout << "} "<< endl;
    cout << endl;


    cout << "proc string makeParent(string $elem) {" << endl;
    cout << "   string $Xproxy = ($elem+\"_xgenProxy\");" << endl;
    cout << endl;
    cout << "   if (! `objExists $Xproxy`) {" << endl;
    cout << "      group -empty -n $Xproxy;" << endl;
    cout << endl;
    cout << "      if (`objExists ($elem+\"_model\")`) {" << endl;
    cout << "         parent $Xproxy ($elem+\"_model\");" << endl;
    cout << "      }" << endl;
    cout << endl;
    cout << "   }" << endl;
    cout << endl;
    cout << "   return $Xproxy;" << endl;
    cout << "}" << endl;
    cout << endl;

    cout << "{" << endl;
    cout << "string $Xproxy;" << endl;

    if ( format == AS_TWIST_TIE ) {
        cout << "string $Xcurve1 = `curve -d 1 -p -0.5 0 0 -p 0.5 0 0`;"
             << endl;
        cout << "string $Xcurve2 = `curve -d 1 -p 0 0 -0.5 -p 0 0 0.5`;"
             << endl;
    }

    if ( format == AS_TUBE ) {
    cout << "string $Xtmp[] = `circle -r " << radius << " -nrx 0 -nry 1 -nrz 0`;" << endl;
    cout << "string $Xcircle = $Xtmp[0];" << endl;
    }
    if( format == AS_CAMERA_QUAD ){
        cerr << "Output as front facing Camera quad\n";
    }
}

//
// Return pointer in float array to next point to pass out
// Return 0 when last point has been passed
//
float* nextPoint(float *points, unsigned int &j, unsigned int step, unsigned int max)
{

    // If at end of array, return 0
    if (j >= max-1) 
    return 0;

    j += step;

    // Don't run off end
    if (j > max-1)
    j = max-1;

    return (points+j*3);
}

//
// Check for kinks in the curve -- very bad for extrusions
//
int checkForBends(float* p1, float* p2, float* p3)
{
    const float kinkThresh = 0.0f;
    const float magThresh = 0.1f;

    float n1[3], n2[3];
    float dot = 0, mag1 = 0;
    // float mag2 = 0;

    for (int i=0; i<3; i++) {
    n1[i] = p2[i] - p1[i];
    n2[i] = p3[i] - p2[i];

    mag1 += n1[i] * n1[i];
    //mag2 += n2[i] * n2[i];
    }

    if (mag1 < magThresh*magThresh)
    return 0;

    //mag1 = sqrt(mag1);
    //mag2 = sqrt(mag2);

    for (int i=0; i<3; i++) {
    //dot = n1[i] * n2[i] / (mag1 * mag2);
    dot = n1[i] * n2[i];
    }

    // Too much of a zig zag, shouldn't let this go out
    if (dot < kinkThresh)
    return 0;

    return 1;
}

//
//
//
void emitPoint( float* point, const SgVec3d &origin)
{
    cout << " -p "
     << point[0] + origin[0] << " "
     << point[1] + origin[1] << " "
     << point[2] + origin[2];

}

//
// Search for the next CV Attribute float value by name.
//
void dumpTwistTie( XpdFullPrimF & data, const SgVec3d &origin, float widthScale, unsigned int &emit, int curveSample, unsigned int numCVs, const safevector<string> &keys)
{
    unsigned int j;

    emit++;
    float width=widthScale;

    cout << "setAttr ($Xcurve1+\".s\") -type double3 "
     << width << " " << width << " " << width << ";" << endl;
    cout << "setAttr ($Xcurve2+\".s\") -type double3 "
     << width << " " << width << " " << width << ";" << endl;

    if ((data.size() >= 3)) {
    float *oneTriplet = static_cast<float *>((void*)(&data[3]));
    cout << "string $Xprofile = `curve -d 1";

    // Emit the first point
    emitPoint(oneTriplet, origin);

    for ( j = curveSample; j < numCVs - curveSample; j+= curveSample ) {
        emitPoint(oneTriplet+j*3, origin);
    }

    // Get the last point too
    j = numCVs - 1;
    emitPoint(oneTriplet+j*3, origin);

    cout << "`;" << std::endl;

    cout << "string $Xrib[] = `extrude -ch false -rn false "
         << "-po 1 -et 2 -ucp 1 -fpt 1 -upn 1 -rotation 0 "
         << " -scale 1.0 -rsp 1 $Xcurve1 $Xprofile`;" << endl;
    cout << "parent $Xrib[0] $Xproxy;" << endl;
    cout << "string $Xrib[] = `extrude -ch false -rn false "
         << "-po 1 -et 2 -ucp 1 -fpt 1 -upn 1 -rotation 0 "
         << "-scale 1.0 -rsp 1 $Xcurve2 $Xprofile`;" << endl;
    cout << "parent $Xrib[0] $Xproxy;" << endl;
    cout << "delete $Xprofile;" << endl;
    }

}

void dumpCurve( XpdFullPrimF & data, const SgVec3d &origin, unsigned int &emit, int curveSample, unsigned int numCVs )
{
    unsigned int j;
    emit++;

//cerr << "in dumpCurve, curveSample:"<< curveSample << endl;
//cerr << "data.size():"<< data.size() << endl;
    if ((data.size() >= 3)) {
    float *oneTriplet = static_cast<float *>((void*)(&data[3]));
    cout << "string $Xprofile = `curve -d 1";

    // Emit the first point
    emitPoint(oneTriplet, origin);

    for ( j=curveSample; j<numCVs-curveSample; j+= curveSample ) {
        emitPoint(oneTriplet+j*3, origin);
    }

    // Get the last point too
    j = numCVs - 1;
    emitPoint(oneTriplet+j*3, origin);

    cout << "`;" << std::endl;

    cout << "parent $Xprofile $Xproxy;" << endl;
    }
}


void dumpTube( XpdFullPrimF & data, const SgVec3d &origin, unsigned int &emit, unsigned int curveSample, unsigned int numCVs, char *convertedName )
{
    int pointCount = 0;
    unsigned int j;
    char outputName[256];
    float *p1, *p2, *p3;

    sprintf(outputName,convertedName,emit);
    cerr << "Made proxy: " << outputName << endl;

    emit++;

    if ((data.size() < 3)) {
    return;
    }

    j = 0;

    float *oneTriplet = static_cast<float *>((void*)(&data[3]));
    p1 = oneTriplet;

    p2 = nextPoint(oneTriplet, j, curveSample, numCVs);
    p3 = nextPoint(oneTriplet, j, curveSample, numCVs);

    cout << "string $Xprofile = `curve -d 1";

    if (p3 == 0) {
    emitPoint(p1, origin);
    emitPoint(p2, origin);

    pointCount = 2;

    } else {
    while (p3 != 0) {

        if (checkForBends(p1, p2, p3)) {
        emitPoint(p1, origin);
        pointCount++;
        }

        p1 = p2;
        p2 = p3;
        p3 = nextPoint(oneTriplet, j, curveSample, numCVs);
    }

    // Get the last point too
    emitPoint(p2, origin);
    pointCount++;

    }

    cout << "`;" << std::endl;

    // Only extrude if the curve was good
    if (pointCount >= 2) {
    cout << "extrude -ch false -rn false "
         << "-po 0 -et 2 -ucp 1 -fpt 1 -rotation 0 "
     << " -scale 1.0 -rsp 1 $Xcircle $Xprofile;" << endl;
    cout << "rename " << outputName << ";" << endl;
    cout << "parent " << outputName << " $Xproxy;" << endl;
    }

    cout << "delete $Xprofile;" << endl;

}
//modify p1 so that it is will be the left or right side of a front facing quad
void faceCamPoint(float *p1,SgVec3f curveVec,float *camPos, float widthScale,int side,float *newPnt)
{

    // get a view vector
    SgVec3f newVec;
    SgVec3f viewVec(camPos[0],camPos[1],camPos[2]);
//cerr << "curveVec:"<< curveVec << endl;
    SgVec3f pnt1(p1[0],p1[1],p1[2]);
    viewVec = pnt1 - viewVec; 
    viewVec.normalize();
//cerr << "viewVec:"<< viewVec << endl;

    // now get the front facing width vector
    curveVec.normalize();
    SgVec3f widthVec = viewVec * curveVec;
    if ( widthVec.length() == 0.0 )
       widthVec = widthVec.orthogonal();
    widthVec.normalize();
    widthVec *= (widthScale/2);
//cerr << "widthVec:"<< widthVec << endl;
    if(side==0){
       newVec = pnt1 - widthVec;
    }else{
       newVec = pnt1 + widthVec;
    }
//cerr << "p1:" << setprecision(2) << p1[0]     << "," << p1[1]     <<"," << p1[2]     << endl;
//cerr << "np:"  << setprecision(2) << newVec[0] << "," << newVec[1] <<"," << newVec[2] << endl;
    newPnt[0]=newVec[0];
    newPnt[1]=newVec[1];
    newPnt[2]=newVec[2];
}

SgVec3f getVecDiff(float *p1,float *p2)
{
    return (SgVec3f(p1[0],p1[1],p1[2]) - SgVec3f(p2[0],p2[1],p2[2])) ;
}

void dumpQuad( XpdFullPrimF & data, const SgVec3d &origin, unsigned int &emit, int curveSample, float widthScale, float camPos[3])
{
    unsigned int j;
    int pointCount=0;
    emit++;
    SgVec3f curveVec,p1,p2;
    float newPnt[3];
    float width=1.0;
    /*if (data.cA) {
        if (data.nA>1) {
            width = data.cA[1] * widthScale;
        }
    }*/

//cerr << "in dumpQuad, curveSample:"<< curveSample << endl;
//cerr << "data.size():"<< data.size() << endl;

    if ( (data.size() >= 2)) {
        int side =0;
        // start with a curve for one side.
    float *oneTriplet = static_cast<float *>((void*)(&data[0]));
cout << "string $curve1 = `curve -d 1";

        //get faceCamera point
        curveVec = getVecDiff(oneTriplet+3,oneTriplet);
//cerr << "CurveVec:"<< curveVec << endl;
        faceCamPoint(oneTriplet,curveVec,camPos,width,side,newPnt);

    // Emit the first point
    emitPoint(newPnt, origin);

    for ( j = curveSample; j < data.size() - curveSample; j+= curveSample ) {
            curveVec = getVecDiff(oneTriplet+(j+1)*3 , oneTriplet+j*3);
//cerr << "CurveVec:"<< curveVec << endl;
            faceCamPoint(oneTriplet+j*3,curveVec,
                         camPos,width,side,newPnt);
        emitPoint(newPnt, origin);
    }

    // Get the last point too
    j = data.size() - 1;
        curveVec = getVecDiff(oneTriplet+j*3, oneTriplet+(j-1)*3);
//cerr << "CurveVec:"<< curveVec << endl;
        faceCamPoint(oneTriplet+j*3,curveVec,
                     camPos,width,side,newPnt);
    emitPoint(newPnt, origin);

    cout << "`;" << std::endl;
    cout << "parent $curve1 $Xproxy;" << endl;

        ////////////////////////////////////////////////////////////////
        // now again for the other side
    oneTriplet = static_cast<float *>((void*)(&data[0]));
    cout << "string $curve2 = `curve -d 1";

        //get faceCamera point
        side=1;
        curveVec = getVecDiff(oneTriplet+3, oneTriplet);
        faceCamPoint(oneTriplet,curveVec,camPos,width,side,newPnt);

    // Emit the first point
    emitPoint(newPnt, origin);

    for ( j = curveSample; j < data.size() - curveSample; j+= curveSample ) {
            curveVec = getVecDiff(oneTriplet+(j+1)*3 , oneTriplet+j*3);
            faceCamPoint(oneTriplet+j*3,curveVec,
                         camPos,width,side,newPnt);
        emitPoint(newPnt, origin);
            pointCount++;
    }

    // Get the last point too
    j = data.size() - 1;
        curveVec = getVecDiff(oneTriplet+j*3 , oneTriplet+(j-1)*3);
        faceCamPoint(oneTriplet+j*3,curveVec,
                     camPos,width,side,newPnt);
    emitPoint(newPnt, origin);
        pointCount++;

    cout << "`;" << std::endl;

    cout << "parent $curve2 $Xproxy;" << endl;
    }
    // now loft two curves together
//cerr << "pointCount:" << pointCount << endl;
    if(pointCount >=2){
        cout << "string $loft[] = `loft -ch 0 -u 1 -c 0  -ar 1 -d 1 -ss 1 -rn 0 -po 1 -rsn true $curve1 $curve2`;" << endl;// not sure on command
        cout << "parent $loft[0] $Xproxy;" << endl;
        cout << "delete $curve1 $curve2;" << endl;
    }
}


//
// Dump the primitives as a collection of mel commands.
//
void dumpFullPrim( XpdFile & xpd, int format, float widthScale, float percent, unsigned int &emit, unsigned int curveSample, float camPos[3] )
{
    char convertedName[256], elem[256];

    XpdFullPrimF data;

    SgVec3d origin(0.0,0.0,0.0);// = xpd.origin();

    //cerr << "Processing xgen desc: " << s_descName << " geom = " << s_geomName << endl;

    generateGeoName(s_descName.c_str(), s_geomName.c_str(), elem, convertedName);

    cout << "$Xproxy = makeParent(\"" << elem << "\");" << endl;

    while( xpd.readPrim( data ) ) {

        if ( drand48() < percent ) {
            switch (format) {
                case AS_TWIST_TIE:
                    dumpTwistTie(data, origin, widthScale, emit, curveSample, xpd.numCVs(), xpd.keys() );
                    break;

                case AS_CURVE:
                    dumpCurve(data, origin, emit, curveSample, xpd.numCVs() );
                    break;

                case AS_TUBE:
                    dumpTube(data, origin, emit, curveSample, xpd.numCVs(), convertedName);
                    break;

                case AS_CAMERA_QUAD:
                    dumpQuad(data, origin, emit, curveSample,widthScale,camPos);
                    break;

                default:
                    break;
            }
        }
    }

}


//
// Dump a trailer for cleanup.
//
void dumpTrailer(char *elem, int format )
{
    if ( format == AS_TWIST_TIE ) {
        cout << "delete $Xcurve1; delete $Xcurve2;" << endl;
    }

    if (format == AS_TUBE ) {
    cout << "delete $Xcircle;" << endl;
    }

    cout << "select -r $Xproxy;" << endl;

    cout << "}" << endl;
    if (format == AS_CAMERA_QUAD) {
        cout << "adjParent(\"" << elem << "\");" << endl;
    }
}


int usage()
{
    cerr << endl;
    cerr << "USAGE: xpd2mel [-v]" << endl;
    cerr << "               [-d descname]" << endl;
    cerr << "               [-g geomname]" << endl;
    cerr << "               [-f format]" << endl;
    cerr << "               [-c \"x y z\" Camera Position]" << endl;
    cerr << "               [-s curveSamples]" << endl;
    cerr << "               [-w widthScale]" << endl;
    cerr << "               [-p percent] <xpdfiles>" << endl << endl;
    cerr << "    where verbose is set with the -v flag [off]" << endl;
    cerr << "          descname is the description name to use when building the Maya names" << endl;
    cerr << "          geomname is the geometrye name to use when building the Maya names" << endl;
    cerr << "          format is 0=curves 1=twist-ties 2=tubes" << endl;
    cerr << "          3=camera facing quads strip" << endl;
    cerr << "          widthScale is amount to scale width [1.0]" << endl;
    cerr << "          percent is percentage to convert to mel [100]" << endl;
    cerr << endl;
    return 1;
}

int main( int argc, char *argv[] )
{
    StrIntArray descArray;

    char *filename;

    if ( argc < 3 ) return usage();

    unsigned int totalPrims = 0;
    unsigned int emitPrims = 0;
    float widthScale = 1.0;
    float percent = 1.0;
    int format = AS_CURVE;
    unsigned int sample = 1;
    float camPos[3]={0,0,0};
    char *camstr;
    bool verbose = false;
    bool faceCam = false;
    bool done=false;
    float x,y,z;
    int cnt=0;
    do {
        int c = getopt( argc, argv, "s:f:w:p:v:c:d:g:");
        switch (c)
        {
            case -1 :
                done = true;
                break;
            case 'd':
                s_descName = optarg;
                break;
            case 'g':
                s_geomName = optarg;
                break;
            case 'f':
                format = atoi(optarg);
                break;
            case 'w':
                widthScale = (float)atof(optarg);
                break;
            case 'p':
                percent = ((float)atof(optarg))/100.f;
                break;
            case 'v':
                verbose = true;
                break;
        case 's':
        sample = (unsigned int)atoi(optarg);
        break;
        case 'c':
                camstr = optarg;
                cnt =  sscanf(camstr,"%f %f %f",&x,&y,&z);
                if(cnt<3){
                    cerr << "Error reading Camera position\n";
                    cerr << "-c "<< camstr << endl;
                    break;
                }
                faceCam = true;
                camPos[0] = x;
                camPos[1] = y;
                camPos[2] = z;
        break;
            default :
                return usage();
        }
    } while (!done);

    dumpHeader(format, widthScale);
    const char *descName = 0;
    const char *geomName = 0;

    for ( int i=optind; i<argc; i++ ) {

        filename = strdup( argv[i] );

        XpdFile xpd;
        if ( !xpd.openRead( filename ) ) {
            cerr << "Could not find " << filename
                 << " for conversion." << endl;
            exit( 2 );
        }

        while (xpd.nextFace()) {
            unsigned int emitPerDesc = descArray[s_descName.c_str()];

            int blockIndex = xpd.blockIndex("BakedGroom");
            if ( !xpd.findBlock(blockIndex) ) {
                cerr << "Failed to find BakedGroom block in XPD file." << endl;
                exit( 1 );
            }

            unsigned int startEmit = emitPerDesc;

            dumpFullPrim( xpd, format, widthScale, percent, emitPerDesc, sample, camPos );

            descArray[s_descName.c_str()] = emitPerDesc;
            descName = s_descName.c_str();
            geomName = s_geomName.c_str();

            if ( verbose ) {
                cerr << filename << ": emitted " << emitPerDesc - startEmit
                    << " out of " << xpd.numPrims()
                    << " primitives." << endl;
            }

            emitPrims += (emitPerDesc - startEmit);
            totalPrims += xpd.numPrims();

        }
    }

    // descName and geomName will only have the last name used
    char convertedName[256], elem[256];
    generateGeoName(descName, geomName, elem, convertedName);
    dumpTrailer(elem, format );

    cerr << "Successfully emitted " << emitPrims
         << " out of " << totalPrims
         << " primitives." << endl;
    return 0;
}
