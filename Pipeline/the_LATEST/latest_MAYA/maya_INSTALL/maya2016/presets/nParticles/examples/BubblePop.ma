//Maya ASCII 2009 scene
//Name: BubblePop.ma
//Last modified: Mon, Feb 02, 2009 11:39:16 AM
//Codeset: 1252
requires maya "2009";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 2009";
fileInfo "version" "2009P03";
fileInfo "cutIdentifier" "200902020025-744193";
fileInfo "osv" "Microsoft Windows XP Service Pack 2 (Build 2600)\n";
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0.6864765229439368 5.8446231851597474 15.343968230437365 ;
	setAttr ".r" -type "double3" -1.5383527296041939 1.4000000000014086 0 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 16.428151897426112;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 100.1 0 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
createNode transform -s -n "front";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0.70381394588853663 5.2165139363570772 100.1 ;
createNode camera -s -n "frontShape" -p "front";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 18.976831259151769;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
createNode transform -s -n "side";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 100.1 0 0 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "nParticle1";
createNode nParticle -n "nParticleShape1" -p "nParticle1";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -bt "life" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -bt "life" -dt "doubleArray";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -bt "life" -at "double";
	addAttr -ci true -sn "rgbPP" -ln "rgbPP" -dt "vectorArray";
	addAttr -ci true -h true -sn "rgbPP0" -ln "rgbPP0" -dt "vectorArray";
	addAttr -ci true -sn "opacityPP" -ln "opacityPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "opacityPP0" -ln "opacityPP0" -dt "doubleArray";
	addAttr -ci true -sn "radiusPP" -ln "radiusPP" -dt "doubleArray";
	addAttr -ci true -h true -sn "radiusPP0" -ln "radiusPP0" -dt "doubleArray";
	addAttr -ci true -sn "event" -ln "event" -dt "doubleArray";
	addAttr -ci true -h true -sn "event0" -ln "event0" -dt "doubleArray";
	addAttr -ci true -sn "eventCountCache" -ln "eventCountCache" -at "long";
	addAttr -is true -ci true -sn "colorAccum" -ln "colorAccum" -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "useLighting" -ln "useLighting" -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "pointSize" -ln "pointSize" -dv 2 -min 1 -max 60 -at "long";
	addAttr -is true -ci true -sn "normalDir" -ln "normalDir" -dv 2 -min 1 -max 3 -at "long";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 189 -2 0 0 -2 0.5 0 -2 1 0 -2 1.5 0 -2 2 0 -2
		 2.5 0 -2 3 0 -2 3.5 0 -2 4 0 -2 4.5 0 -2 5 0 -2 5.5 0 -2 6 0 -2 6.5 0 -2 7 0 -2 7.5
		 0 -2 8 0 -2 8.5 0 -2 9 0 -2 9.5 0 -2 10 0 -1.5 0 0 -1.5 0.5 0 -1.5 1 0 -1.5 1.5 0 -1.5
		 2 0 -1.5 2.5 0 -1.5 3 0 -1.5 3.5 0 -1.5 4 0 -1.5 4.5 0 -1.5 5 0 -1.5 5.5 0 -1.5 6
		 0 -1.5 6.5 0 -1.5 7 0 -1.5 7.5 0 -1.5 8 0 -1.5 8.5 0 -1.5 9 0 -1.5 9.5 0 -1.5 10
		 0 -1 0 0 -1 0.5 0 -1 1 0 -1 1.5 0 -1 2 0 -1 2.5 0 -1 3 0 -1 3.5 0 -1 4 0 -1 4.5 0 -1
		 5 0 -1 5.5 0 -1 6 0 -1 6.5 0 -1 7 0 -1 7.5 0 -1 8 0 -1 8.5 0 -1 9 0 -1 9.5 0 -1 10
		 0 -0.5 0 0 -0.5 0.5 0 -0.5 1 0 -0.5 1.5 0 -0.5 2 0 -0.5 2.5 0 -0.5 3 0 -0.5 3.5 0 -0.5
		 4 0 -0.5 4.5 0 -0.5 5 0 -0.5 5.5 0 -0.5 6 0 -0.5 6.5 0 -0.5 7 0 -0.5 7.5 0 -0.5 8
		 0 -0.5 8.5 0 -0.5 9 0 -0.5 9.5 0 -0.5 10 0 0 0 0 0 0.5 0 0 1 0 0 1.5 0 0 2 0 0 2.5
		 0 0 3 0 0 3.5 0 0 4 0 0 4.5 0 0 5 0 0 5.5 0 0 6 0 0 6.5 0 0 7 0 0 7.5 0 0 8 0 0 8.5
		 0 0 9 0 0 9.5 0 0 10 0 0.5 0 0 0.5 0.5 0 0.5 1 0 0.5 1.5 0 0.5 2 0 0.5 2.5 0 0.5
		 3 0 0.5 3.5 0 0.5 4 0 0.5 4.5 0 0.5 5 0 0.5 5.5 0 0.5 6 0 0.5 6.5 0 0.5 7 0 0.5 7.5
		 0 0.5 8 0 0.5 8.5 0 0.5 9 0 0.5 9.5 0 0.5 10 0 1 0 0 1 0.5 0 1 1 0 1 1.5 0 1 2 0 1
		 2.5 0 1 3 0 1 3.5 0 1 4 0 1 4.5 0 1 5 0 1 5.5 0 1 6 0 1 6.5 0 1 7 0 1 7.5 0 1 8 0 1
		 8.5 0 1 9 0 1 9.5 0 1 10 0 1.5 0 0 1.5 0.5 0 1.5 1 0 1.5 1.5 0 1.5 2 0 1.5 2.5 0 1.5
		 3 0 1.5 3.5 0 1.5 4 0 1.5 4.5 0 1.5 5 0 1.5 5.5 0 1.5 6 0 1.5 6.5 0 1.5 7 0 1.5 7.5
		 0 1.5 8 0 1.5 8.5 0 1.5 9 0 1.5 9.5 0 1.5 10 0 2 0 0 2 0.5 0 2 1 0 2 1.5 0 2 2 0 2
		 2.5 0 2 3 0 2 3.5 0 2 4 0 2 4.5 0 2 5 0 2 5.5 0 2 6 0 2 6.5 0 2 7 0 2 7.5 0 2 8 0 2
		 8.5 0 2 9 0 2 9.5 0 2 10 0 ;
	setAttr ".vel0" -type "vectorArray" 189 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 ;
	setAttr ".acc0" -type "vectorArray" 189 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 ;
	setAttr ".mas0" -type "doubleArray" 189 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 ;
	setAttr ".id0" -type "doubleArray" 189 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
		 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
		 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70
		 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97
		 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118
		 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139
		 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160
		 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181
		 182 183 184 185 186 187 188 ;
	setAttr ".nid" 189;
	setAttr ".nid0" 189;
	setAttr ".bt0" -type "doubleArray" 189 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 0.041666666666666664
		 0.041666666666666664 0.041666666666666664 0.041666666666666664 ;
	setAttr ".ag0" -type "doubleArray" 189 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 ;
	setAttr ".lfr" 5;
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr ".chw" 500;
	setAttr ".evn[0]" -type "string" "event0";
	setAttr ".evv[0]"  1;
	setAttr ".ecp[0]"  0;
	setAttr ".eve[0]"  0;
	setAttr ".evs[0]"  0;
	setAttr ".evd[0]"  1;
	setAttr ".evr[0]"  0;
	setAttr ".esp[0]"  0;
	setAttr ".epr[0]" -type "string" "";
	setAttr ".idt[0].iam" -type "stringArray" 8 "age" "age" "position" "worldPosition" "id" "particleId" "scale" "radiusPP"  ;
	setAttr ".boce" 0.89999997615814209;
	setAttr ".fron" 0.019999999552965164;
	setAttr ".cofl" 1;
	setAttr ".scld" no;
	setAttr -s 2 ".fsc[0:1]"  0 1 1 1 0 1;
	setAttr ".pff" 1;
	setAttr ".pfma" 0;
	setAttr ".sfat" -194.41400146484375;
	setAttr -s 4 ".pfdo[1:4]"  0.42519686 1 1 0 1 1 0.53543305 
		-0.1 1 1 0 1;
	setAttr ".igsg" yes;
	setAttr ".thr" 0;
	setAttr ".rdc[0]"  0 1 1;
	setAttr ".rci" 1;
	setAttr ".rsr" 0.31404000000000004;
	setAttr ".mssc[0]"  0 1 1;
	setAttr ".pfsc[0]"  0 1 1;
	setAttr ".opc[0]"  0 1 1;
	setAttr ".oci" 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 1 0 0 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 0 0.5 1 ;
	setAttr ".cl[1].cli" 1;
	setAttr ".coi" 6;
	setAttr ".inca[0].incap" 0;
	setAttr ".inca[0].incac" -type "float3" 0 0 0 ;
	setAttr ".inca[0].incai" 1;
	setAttr ".lifespanPP0" -type "doubleArray" 189 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038
		 3.4028234600000001e+038 3.4028234600000001e+038 3.4028234600000001e+038 ;
	setAttr -k on ".lifespan" 5;
	setAttr ".rgbPP0" -type "vectorArray" 189 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5
		 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0
		 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5
		 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0
		 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5
		 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0
		 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5
		 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0
		 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5
		 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0
		 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5
		 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0
		 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5
		 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0
		 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5
		 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0
		 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5
		 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0
		 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 0 0.5 1 ;
	setAttr ".opacityPP0" -type "doubleArray" 189 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		 1 1 1 1 1 1 1 1 1 ;
	setAttr ".radiusPP0" -type "doubleArray" 189 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224 0.20000000298023224
		 0.20000000298023224 0.20000000298023224 ;
	setAttr ".event0" -type "doubleArray" 189 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 ;
	setAttr -k on ".colorAccum";
	setAttr -k on ".useLighting";
	setAttr -k on ".pointSize";
	setAttr -k on ".normalDir";
createNode transform -n "pCube1";
createNode mesh -n "pCubeShape1" -p "pCube1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".qsp" 0;
createNode transform -n "nRigid1";
	setAttr -l on ".t";
	setAttr -l on ".r";
	setAttr -l on ".s";
createNode nRigid -n "nRigidShape1" -p "nRigid1";
	addAttr -ci true -sn "lifespan" -ln "lifespan" -bt "life" -at "double";
	addAttr -ci true -sn "lifespanPP" -ln "lifespanPP" -bt "life" -dt "doubleArray";
	addAttr -ci true -h true -sn "lifespanPP0" -ln "lifespanPP0" -bt "life" -dt "doubleArray";
	setAttr -k off ".v";
	setAttr ".gf" -type "Int32Array" 0 ;
	setAttr ".pos0" -type "vectorArray" 0 ;
	setAttr ".vel0" -type "vectorArray" 0 ;
	setAttr ".acc0" -type "vectorArray" 0 ;
	setAttr ".mas0" -type "doubleArray" 0 ;
	setAttr ".id0" -type "doubleArray" 0 ;
	setAttr ".nid" 40;
	setAttr ".bt0" -type "doubleArray" 0 ;
	setAttr ".ag0" -type "doubleArray" 0 ;
	setAttr -k off ".dve";
	setAttr -k off ".lfm";
	setAttr -k off ".lfr";
	setAttr -k off ".ead";
	setAttr ".irbx" -type "string" "";
	setAttr ".irax" -type "string" "";
	setAttr ".icx" -type "string" "";
	setAttr -k off ".dw";
	setAttr -k off ".fiw";
	setAttr -k off ".con";
	setAttr -k off ".eiw";
	setAttr -k off ".mxc";
	setAttr -k off ".lod";
	setAttr -k off ".inh";
	setAttr -k off ".stf";
	setAttr -k off ".igs";
	setAttr -k off ".ecfh";
	setAttr -k off ".tgs";
	setAttr -k off ".gsm";
	setAttr -k off ".chd";
	setAttr ".chw" 500;
	setAttr -k off ".trd";
	setAttr -k off ".prt";
	setAttr ".thss" 0.041319999843835831;
	setAttr ".actv" no;
	setAttr ".scld" no;
	setAttr ".por" 0.19148287177085876;
	setAttr ".tpc" yes;
	setAttr -s 2 ".fsc[0:1]"  0 1 1 1 0 1;
	setAttr -s 2 ".pfdo[0:1]"  0 1 1 1 0 1;
	setAttr -k on ".lifespan" 1;
	setAttr ".lifespanPP0" -type "doubleArray" 0 ;
createNode transform -n "nurbsSphere1";
	setAttr ".t" -type "double3" 5.4801412077112976 0 0 ;
createNode nurbsSurface -n "nurbsSphereShape1" -p "nurbsSphere1";
	addAttr -ci true -sn "mso" -ln "miShadingSamplesOverride" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "msh" -ln "miShadingSamples" -min 0 -smx 8 -at "float";
	addAttr -ci true -sn "mdo" -ln "miMaxDisplaceOverride" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mmd" -ln "miMaxDisplace" -min 0 -smx 1 -at "float";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 15;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode instancer -n "instancer1";
createNode place3dTexture -n "place3dTexture1";
createNode transform -n "directionalLight1";
	setAttr ".r" -type "double3" -88.743379280139408 -16.345640386196742 17.851683730915234 ;
createNode directionalLight -n "directionalLightShape1" -p "directionalLight1";
	setAttr -k off ".v";
createNode transform -n "BubblePopCam";
	setAttr ".t" -type "double3" 0.42822960275804944 6.7668262562103276 15.855027633164834 ;
	setAttr ".r" -type "double3" -5.7383527296024939 0.20000000000000606 -1.5530146770552268e-018 ;
createNode camera -n "BubblePopCamShape" -p "BubblePopCam";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 16.829012738579998;
	setAttr ".imn" -type "string" "persp1";
	setAttr ".den" -type "string" "persp1_depth";
	setAttr ".man" -type "string" "persp1_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode lightLinker -n "lightLinker1";
	setAttr -s 5 ".lnk";
	setAttr -s 5 ".slnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode nucleus -n "nucleus1";
	setAttr ".grty" 1.6519999504089355;
createNode shadingEngine -n "nParticleBallsSE";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode particleSamplerInfo -n "particleSamplerInfo1";
createNode blinn -n "npBallsBlinn";
createNode particleCloud -n "npBallsVolume";
createNode polyCube -n "polyCube1";
	setAttr ".cuv" 4;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 500 -ast 1 -aet 500 ";
	setAttr ".st" 6;
createNode makeNurbSphere -n "makeNurbSphere1";
	setAttr ".ax" -type "double3" 0 1 0 ;
createNode blinn -n "blinn1";
	setAttr ".c" -type "float3" 0 0 0 ;
	setAttr ".it" -type "float3" 1 1 1 ;
	setAttr ".sc" -type "float3" 1 1 1 ;
	setAttr ".rfl" 0.09917999804019928;
	setAttr ".ec" 0;
	setAttr ".sro" 0.63635998964309692;
createNode shadingEngine -n "blinn1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
createNode envSphere -n "envSphere1";
createNode ramp -n "ramp1";
	setAttr ".t" 1;
	setAttr -s 4 ".cel";
	setAttr ".cel[0].ep" 0;
	setAttr ".cel[0].ec" -type "float3" 1 0.93800002 0.93800002 ;
	setAttr ".cel[1].ep" 0.54000002145767212;
	setAttr ".cel[1].ec" -type "float3" 0.56199998 0.56199998 0.56199998 ;
	setAttr ".cel[2].ep" 1;
	setAttr ".cel[2].ec" -type "float3" 0.59799999 0.68442994 1 ;
	setAttr ".cel[3].ep" 0.41999998688697815;
	setAttr ".cel[3].ec" -type "float3" 0.113 0.074127994 0.074127994 ;
createNode place2dTexture -n "place2dTexture1";
createNode rampShader -n "rampShader1";
	setAttr ".clr[0].clrp" 0;
	setAttr ".clr[0].clrc" -type "float3" 1 1 1 ;
	setAttr ".clr[0].clri" 1;
	setAttr ".it[1].itp" 0;
	setAttr ".it[1].itc" -type "float3" 0.56900001 0.56900001 0.56900001 ;
	setAttr ".it[1].iti" 1;
	setAttr ".ic[0].icp" 0;
	setAttr ".ic[0].icc" -type "float3" 0 0 0 ;
	setAttr ".ic[0].ici" 1;
	setAttr ".ec" 0.074400000274181366;
	setAttr ".spl" 1;
	setAttr -s 2 ".sro[0:1]"  0 1 2 0.5 0.5 2;
	setAttr ".sc[0].scp" 0;
	setAttr ".sc[0].scc" -type "float3" 1 1 1 ;
	setAttr ".sc[0].sci" 1;
	setAttr -s 4 ".rfl";
	setAttr ".rfl[1].rflp" 0.97637796401977539;
	setAttr ".rfl[1].rflfv" 0;
	setAttr ".rfl[1].rfli" 1;
	setAttr ".rfl[3:5]" 0 0.41999998688697815 1 0.25196850299835205 0.30000001192092896 
		1 0.59055119752883911 0 1;
	setAttr -s 4 ".env";
	setAttr ".env[0].envp" 0;
	setAttr ".env[0].envc" -type "float3" 0.80799997 1 0.87068796 ;
	setAttr ".env[0].envi" 1;
	setAttr ".env[1].envp" 0.36220473051071167;
	setAttr ".env[1].envc" -type "float3" 0.26499999 0.20060499 0.20060499 ;
	setAttr ".env[1].envi" 1;
	setAttr ".env[2].envp" 0.64566928148269653;
	setAttr ".env[2].envc" -type "float3" 1 0.93414402 0.90200001 ;
	setAttr ".env[2].envi" 1;
	setAttr ".env[3].envp" 1;
	setAttr ".env[3].envc" -type "float3" 0.45300001 0.79797459 1 ;
	setAttr ".env[3].envi" 1;
createNode shadingEngine -n "rampShader1SG";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo3";
createNode animCurveTU -n "pCube1_visibility";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  1 1 94 1 162 1 209 1;
	setAttr -s 4 ".kot[0:3]"  5 5 5 5;
createNode animCurveTL -n "pCube1_translateX";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  1 3.7849648400340121 94 3.7849648400340121 
		162 -0.70796922953891128 209 -0.70796922953891128;
createNode animCurveTL -n "pCube1_translateY";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  1 5.5857868269638367 94 5.5857868269638367 
		162 7.5317588035901393 209 4.0326965232317109;
createNode animCurveTL -n "pCube1_translateZ";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  1 -0.36276920837635984 94 -0.36276920837635984 
		162 0.2368692435963915 209 0.2368692435963915;
createNode animCurveTA -n "pCube1_rotateX";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  1 0 94 0 162 0 209 0;
createNode animCurveTA -n "pCube1_rotateY";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  1 0 94 0 162 0 209 0;
createNode animCurveTA -n "pCube1_rotateZ";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  1 0 94 0 162 0 209 0;
createNode animCurveTU -n "pCube1_scaleX";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  1 1.2494398323035956 94 1.2494398323035956 
		162 1.2494398323035956 209 1.2494398323035956;
createNode animCurveTU -n "pCube1_scaleY";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  1 1.4040374518985499 94 1.4040374518985499 
		162 1.4040374518985499 209 1.4040374518985499;
createNode animCurveTU -n "pCube1_scaleZ";
	setAttr ".tan" 10;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  1 5.8922154613442039 94 5.8922154613442039 
		162 5.8922154613442039 209 5.8922154613442039;
select -ne :time1;
	setAttr ".o" 1;
select -ne :renderPartition;
	setAttr -s 5 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 6 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
	setAttr -s 2 ".u";
select -ne :lightList1;
select -ne :defaultTextureList1;
	setAttr -s 2 ".tx";
select -ne :lambert1;
	setAttr ".c" -type "float3" 0.89499998 0.49582997 0.49582997 ;
	setAttr ".ic" -type "float3" 0.207 0.14614201 0.14614201 ;
select -ne :initialShadingGroup;
	setAttr -k on ".nds";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultLightSet;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr ":time1.o" "nParticleShape1.cti";
connectAttr "nucleus1.noao[0]" "nParticleShape1.nxst";
connectAttr "nucleus1.stf" "nParticleShape1.stf";
connectAttr "nParticleShape1.incr" "nParticleShape1.rgbPP";
connectAttr "nParticleShape1.inor" "nParticleShape1.opacityPP";
connectAttr "nParticleShape1.inrr" "nParticleShape1.radiusPP";
connectAttr "nParticleShape1.msg" "nParticleShape1.etg[0]";
connectAttr "pCube1_visibility.o" "pCube1.v";
connectAttr "pCube1_translateX.o" "pCube1.tx";
connectAttr "pCube1_translateY.o" "pCube1.ty";
connectAttr "pCube1_translateZ.o" "pCube1.tz";
connectAttr "pCube1_rotateX.o" "pCube1.rx";
connectAttr "pCube1_rotateY.o" "pCube1.ry";
connectAttr "pCube1_rotateZ.o" "pCube1.rz";
connectAttr "pCube1_scaleX.o" "pCube1.sx";
connectAttr "pCube1_scaleY.o" "pCube1.sy";
connectAttr "pCube1_scaleZ.o" "pCube1.sz";
connectAttr "polyCube1.out" "pCubeShape1.i";
connectAttr "nucleus1.stf" "nRigidShape1.stf";
connectAttr ":time1.o" "nRigidShape1.cti";
connectAttr "pCubeShape1.w" "nRigidShape1.imsh";
connectAttr "makeNurbSphere1.os" "nurbsSphereShape1.cr";
connectAttr "nParticleShape1.idt[0].ipd" "instancer1.inp";
connectAttr "nurbsSphere1.m" "instancer1.inh[0]";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "nParticleBallsSE.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "blinn1SG.msg" "lightLinker1.lnk[3].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[4].llnk";
connectAttr "rampShader1SG.msg" "lightLinker1.lnk[4].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[0].sllk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.slnk[0].solk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[1].sllk";
connectAttr ":initialParticleSE.msg" "lightLinker1.slnk[1].solk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[2].sllk";
connectAttr "nParticleBallsSE.msg" "lightLinker1.slnk[2].solk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[3].sllk";
connectAttr "blinn1SG.msg" "lightLinker1.slnk[3].solk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[4].sllk";
connectAttr "rampShader1SG.msg" "lightLinker1.slnk[4].solk";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr ":time1.o" "nucleus1.cti";
connectAttr "nParticleShape1.cust" "nucleus1.niao[0]";
connectAttr "nParticleShape1.stst" "nucleus1.nias[0]";
connectAttr "nRigidShape1.cust" "nucleus1.nipo[0]";
connectAttr "nRigidShape1.stst" "nucleus1.nips[0]";
connectAttr "npBallsBlinn.oc" "nParticleBallsSE.ss";
connectAttr "npBallsVolume.oi" "nParticleBallsSE.vs";
connectAttr "nParticleShape1.iog" "nParticleBallsSE.dsm" -na;
connectAttr "nParticleBallsSE.msg" "materialInfo1.sg";
connectAttr "npBallsBlinn.msg" "materialInfo1.m";
connectAttr "particleSamplerInfo1.msg" "materialInfo1.t" -na;
connectAttr "particleSamplerInfo1.oc" "npBallsBlinn.c";
connectAttr "particleSamplerInfo1.ot" "npBallsBlinn.it";
connectAttr "particleSamplerInfo1.oi" "npBallsBlinn.ic";
connectAttr "particleSamplerInfo1.ot" "npBallsVolume.t";
connectAttr "particleSamplerInfo1.oc" "npBallsVolume.c";
connectAttr "particleSamplerInfo1.oi" "npBallsVolume.i";
connectAttr "envSphere1.oc" "blinn1.rc";
connectAttr "blinn1.oc" "blinn1SG.ss";
connectAttr "blinn1SG.msg" "materialInfo2.sg";
connectAttr "blinn1.msg" "materialInfo2.m";
connectAttr "blinn1.msg" "materialInfo2.t" -na;
connectAttr "place3dTexture1.wim" "envSphere1.pm";
connectAttr "ramp1.oc" "envSphere1.so";
connectAttr "place2dTexture1.o" "ramp1.uv";
connectAttr "place2dTexture1.ofs" "ramp1.fs";
connectAttr "rampShader1.oc" "rampShader1SG.ss";
connectAttr "nurbsSphereShape1.iog" "rampShader1SG.dsm" -na;
connectAttr "rampShader1SG.msg" "materialInfo3.sg";
connectAttr "rampShader1.msg" "materialInfo3.m";
connectAttr "rampShader1.msg" "materialInfo3.t" -na;
connectAttr "nParticleBallsSE.pa" ":renderPartition.st" -na;
connectAttr "blinn1SG.pa" ":renderPartition.st" -na;
connectAttr "rampShader1SG.pa" ":renderPartition.st" -na;
connectAttr "npBallsBlinn.msg" ":defaultShaderList1.s" -na;
connectAttr "npBallsVolume.msg" ":defaultShaderList1.s" -na;
connectAttr "blinn1.msg" ":defaultShaderList1.s" -na;
connectAttr "rampShader1.msg" ":defaultShaderList1.s" -na;
connectAttr "place3dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "place2dTexture1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "directionalLightShape1.ltd" ":lightList1.l" -na;
connectAttr "envSphere1.msg" ":defaultTextureList1.tx" -na;
connectAttr "ramp1.msg" ":defaultTextureList1.tx" -na;
connectAttr "pCubeShape1.iog" ":initialShadingGroup.dsm" -na;
connectAttr "directionalLight1.iog" ":defaultLightSet.dsm" -na;
// End of BubblePop.ma
