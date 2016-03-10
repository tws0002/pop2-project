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

function newImage(arg) {
	if (document.images) {
		rslt = new Image();
		rslt.src = arg;
		return rslt;
	}
}
function changeImages() {
	if (document.images && (preloadFlag == true)) {
		for (var i=0; i<changeImages.arguments.length; i+=2) {
			document[changeImages.arguments[i]].src = changeImages.arguments[i+1];
		}
	}
}
var preloadFlag = false;
function preloadImages() {
	if (document.images) {
		WT_01_over = newImage("images/WebTools_05-over.gif");
		WT_02_over = newImage("images/WebTools_06-over.gif");
		WT_03_over = newImage("images/WebTools_07-over.gif");
		WT_04_over = newImage("images/WebTools_08-over.gif");
		WT_05_over = newImage("images/WebTools_09-over.gif");
		preloadFlag = true;
	}
}
