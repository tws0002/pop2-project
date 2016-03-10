How to register a custom XGen plugin
================================================

1. Write your fxmodule/generator/renderer/primitive/patch.  See XgGravityFXModule.{cpp,h} for an example.
	- The C++ class name must be Xg[something]FXModule for the XgRegisterFXModule macro to work.  
	- The C++ class name must be Xg[something]Generator for the XgRegisterGenerator macro to work.  
	- The C++ class name must be Xg[something]Renderer for the XgRegisterRenderer macro to work.  
	- etc.

	  You can register any class you want if you directly invoke the registration functions in
	  <maya/xgen/XgCreator.h>

	- The typeName() must be unique and must end in "FXModule" or "Generator" or "Renderer" or "Primitive" or "Patch".

2. Write the UI. See ui.py for an example.

3. Compile the plugin into a .so/.dll file.  
	- The name doesn't matter except it needs to end in .so/.dll
	- You can have multiple XGen modules in the same .so/.dll

4. Copy the .so/.dll and the .py into one of the three XGen repositories, under
	the plugins subdirectory. For example this can be into "${HOME}/xgen/plugins/". 
	- By default the UserRepo is ${HOME}/xgen/
	- By default the GlobalRepo is ${XGEN_LOCATION}/presets/
	- By default the LocalRepo is ${XGEN_DATA_PATH}/
