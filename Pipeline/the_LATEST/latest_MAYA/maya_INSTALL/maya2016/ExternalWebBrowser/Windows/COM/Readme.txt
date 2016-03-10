==========================================================================
MayaCmdCOM - Maya(R) MEL Command Engine Interface Library
==========================================================================

The MayaCmdCOM.dll shared library contains the:

- type library for the IMELCommand interface and the MELCommand class
- implementation of the MELCommand class
- registry entries and implementation of the mel: URL protocol handler

Run the Register.bat batch file to register the MELCommand class and
the mel: URL protocol handler. Once you have done this, do not move
or delete the MayaCmdCOM.dll file.

Running the Unregister.dll will remove the MELCommand class and the
mel: URL protocol handler from the system.

The IMELCommand.htm file documents the IMELCommand Automation interface.

Both the mel: URL handler and the MELCommand class use "commandportDefault"
as the default command port name. Be sure to open a command port with this
name from Maya, either through the preferences (in Forge or later), or by
entering:

  commandPort -name "commandportDefault";

in either the Maya Script Editor or Command Shell window.

Try the various tests in the Tests folder. Note that the Test.htm file
is designed to work only with Internet Explorer, although the mel: URLs
should work in any web browser.

//-
// ==========================================================================
// Copyright 1995,2006,2008 Autodesk, Inc. All rights reserved.
//
// Use of this software is subject to the terms of the Autodesk
// license agreement provided at the time of installation or download,
// or which otherwise accompanies this software in either electronic
// or hard copy form.
// ==========================================================================
//+
