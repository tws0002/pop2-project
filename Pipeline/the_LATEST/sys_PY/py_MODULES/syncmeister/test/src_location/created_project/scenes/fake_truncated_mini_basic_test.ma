//Maya ASCII 2016 scene
//Name: sphere_relative_test_reference.ma
//Last modified: Wed, Dec 09, 2015 06:21:20 AM
//Codeset: 1252
file -rdi 1 -ns "sphere_relative_test" -rfn "sphere_relative_testRN" -op "v=0;"
		 -typ "mayaAscii" "../../reference/sphere_relative_test.ma";
file -r -ns "sphere_relative_test" -dr 1 -rfn "sphere_relative_testRN" -op "v=0;"
		 -typ "mayaAscii" "/home/selecaotwo/Dropbox/Private/my_PROJECT/proj_POP2/Pipeline/the_LATEST/sys_PY/py_MODULES/syncmeister/test/src_location/reference/sphere_relative_test.ma";
requires maya "2016";
		 -typ "mayaAscii" "../assets/reference.ma";
requires maya "2016";
