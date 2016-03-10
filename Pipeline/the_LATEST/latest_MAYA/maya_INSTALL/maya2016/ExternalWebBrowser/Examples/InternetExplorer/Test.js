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

try
{
    var MEL;
    MEL = new ActiveXObject("Maya.CommandEngine.MEL");

    MEL.Execute("file -f -new");

    for (var x = -10; x <= 10; x += 2) {
        for (var y = -10; y <= 10; y += 2) {
            for (var z = -10; z <= 10; z += 2) {
                if (Math.abs(x) == 10 || Math.abs(y) == 10 || Math.abs(z) == 10) {
                    MEL.Execute("polyCube; scale 1.5 1.5 1.5; move " + x + " " + y + " " + z);
                }
            }
        }
    }
    MEL.Execute("DisplayShaded");
    MEL.Execute("select -cl; fitPanel -selected");

    MEL.Disconnect();
}
catch (e)
{
    throw e;
}
