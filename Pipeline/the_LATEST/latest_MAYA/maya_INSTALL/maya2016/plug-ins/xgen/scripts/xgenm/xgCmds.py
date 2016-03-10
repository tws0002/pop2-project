# Copyright (C) 1997-2013 Autodesk, Inc., and/or its licensors.
# All rights reserved.
#
# The coded instructions, statements, computer programs, and/or related
# material (collectively the "Data") in these files contain unpublished
# information proprietary to Autodesk, Inc. ("Autodesk") and/or its licensors,
# which is protected by U.S. and Canadian federal copyright law and by
# international treaties.
#
# The Data is provided for use exclusively by You. You have the right to use,
# modify, and incorporate this Data into other products for purposes authorized 
# by the Autodesk software license agreement, without fee.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND. AUTODESK
# DOES NOT MAKE AND HEREBY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTIES
# INCLUDING, BUT NOT LIMITED TO, THE WARRANTIES OF NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, OR ARISING FROM A COURSE 
# OF DEALING, USAGE, OR TRADE PRACTICE. IN NO EVENT WILL AUTODESK AND/OR ITS
# LICENSORS BE LIABLE FOR ANY LOST REVENUES, DATA, OR PROFITS, OR SPECIAL,
# DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES, EVEN IF AUTODESK AND/OR ITS
# LICENSORS HAS BEEN ADVISED OF THE POSSIBILITY OR PROBABILITY OF SUCH DAMAGES.

"""xgen helper commands"""

import re

import xgenm as xgen
import xgenm.xgGlobal as xgg


def syncArchiveSize(palette, description):
	"""Sync "archiveSize" to the "#OriginalMaxSize XX.XXXX" comment"""

	primitive = xgen.getActive(palette, description, 'Primitive')
	if primitive != 'ArchivePrimitive':
		return

	import maya.mel as mel
	cmd = 'xgmSetArchiveSize -description {"%s"}' % description
	mel.eval(cmd)

def autoSetPrimitiveBound(palette, description):
	"""Calculate the "primitiveBound" attribute"""
	if not xgg.Maya:
		# This only runs inside of maya
		return None

	renderer = xgen.getActive(palette, description, 'Renderer')
	if renderer != 'RendermanRenderer':
		return None

	import maya.mel as mel
	cmd = 'xgmNullRender -pb -visibleOnly false  {"%s"}' % description
	mel.eval(cmd)
	value = xgen.getAttr('maxBound', palette, description, 'NullRenderer')
	xgen.setAttr('primitiveBound',value, palette, description,
				'RendermanRenderer')
	return value


def main():
	"""Test command for scripting"""
	import argparse
	parser = argparse.ArgumentParser()
	parser.add_argument('filename')
	parser.add_argument('-o', '--output', metavar='FILE', help='Output file')
	opts, args = parser.parse_known_args()


	filename = opts.filename
	palette = xgen.importPalette(filename, [])
	descriptions = xgen.descriptions(palette)

	for description in descriptions:
		syncArchiveSize(palette, description)

	if opts.output:
		xgen.exportPalette(palette, opts.output)

if __name__ == '__main__':
	main()