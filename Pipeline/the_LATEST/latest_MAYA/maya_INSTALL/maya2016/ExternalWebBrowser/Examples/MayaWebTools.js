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

var MWTObject = null
var MWTPortName = null
var MWTUseCOM = false
var MWTUseAlerts = false

function MWT_Connect(PortName) 
{
	if(MWTObject != null) {
		if(MWTUseCOM) {
			MWTObject.PortName = PortName;
			MWTObject.Connect()
		} else {
			MWTObject.port = PortName
		} 
	} else {
		if(MWTUseAlerts) alert('No plugin object found.')
	}
}

function MWT_Embed(PluginName, PortName)
{
	// Detect if we want to use COM object instead of plugin...
	Agent = navigator.userAgent.toLowerCase();
	var isWindows = false
	// ... is this Windows?
	if((Agent.indexOf("win") != -1) || (Agent.indexOf("16bit") != -1))
	{
		isWindows = true
		// ... is this Internet Explorer?
		if(Agent.indexOf("msie") != -1) {
			// ... then use COM
			MWTUseCOM = true;
		}
	}

	// Now, determine if plugin/COM object is available
	if(MWTUseCOM) {
		// With IE we do nothing here. If COM object is not registered, or ActiveX disabled,
		// ActiveXObject() call will return null. 
	} else {
		var plugin = (isWindows) ? "MCP PlugIn" : "MCP Plug-In"
		var found = false, enabled = false
		for(var i = 0; !found && i < navigator.plugins.length; i++){
			if(navigator.plugins[i].name.toLowerCase() == plugin.toLowerCase()){ 
				found = true
				for (var j = 0; !enabled && j < navigator.plugins[i].length; j++){
					if(navigator.plugins[i][j].enabledPlugin) {
						enabled = true // We are OK
					}
				}
				if(!enabled) {
					if(MWTUseAlerts) alert('MCP Plug-in is installed, but disabled')
					return // Cannot continue
				}
			}
		}
		if(!found) {
			if(MWTUseAlerts) alert('MCP Plug-in is not installed')
			return // Cannot continue
		}
	}

	MWTPortName = PortName
	if(MWTUseCOM) {
		MWTObject = new ActiveXObject("Maya.CommandEngine.MEL")
	} else {
		MWTObject = document.createElement('embed')
		MWTObject.setAttribute('name', PluginName)
		MWTObject.setAttribute('type', 'application/x-mcp')
		MWTObject.setAttribute('hidden', 'true')
		document.body.appendChild(MWTObject)
	}
}

function MWT_Execute(CommandText)
{
	if(MWTObject != null) {
		if(MWTPortName != null) {
			if(MWTUseCOM) {
				if(MWTPortName != MWTObject.PortName) {
					MWTObject.PortName = MWTPortName
				}
				MWTObject.Execute(CommandText)
				return MWTObject.Result
			} else {
				if(MWTPortName != MWTObject.port) {
					MWTObject.port = MWTPortName
				}
				return MWTObject.execute(CommandText)
			}
		} else {
			if(MWTUseAlerts) alert('Cannot connect to undefined port name.')
			return null
		}
	} else {
		if(MWTUseAlerts) alert('No plugin object found.')
		return null
	}
}

function MWT_PositionBrowser(side, size)
{
	browserleft = 0; browsertop = 0; 
	mayabrowserleft = 0; mayabrowsertop = 0; 
	browserwidth = screen.availWidth; 
	browserbrowserheight = screen.availHeight;
	mayabrowserwidth = screen.availWidth; 
	mayabrowserbrowserheight = screen.availHeight;
	
	switch(side) {
		case 'left':
			browserwidth = Math.round(screen.availWidth/100*size);
			mayabrowserleft = browserwidth + 1;
			mayabrowserwidth = screen.availWidth - browserwidth - 1;
		break;
		case 'right':
			browserwidth = Math.round(screen.availWidth/100*size);
			browserleft = screen.availWidth - browserwidth;
			mayabrowserwidth = screen.availWidth - browserwidth - 1;
		break;
		case 'top':
			browserbrowserheight = Math.round(screen.availHeight/100*size);
			mayabrowsertop = browserbrowserheight + 1;
			mayabrowserbrowserheight = screen.availHeight - browserbrowserheight - 1;
		break;
		case 'bottom':
			browserbrowserheight = Math.round(screen.availHeight/100*size);
			browsertop = screen.availHeight - browserbrowserheight;
			mayabrowserbrowserheight = screen.availHeight - browserbrowserheight - 1;
		break;
	}

	if(MWTUseCOM) {
		window.top.moveTo(browserleft, browsertop);
		window.top.resizeTo(browserwidth, browserbrowserheight);
	} else {
		window.top.moveTo(0,0);
		window.top.resizeTo(browserwidth, browserbrowserheight);
		window.top.moveTo(browserleft, browsertop+screenY);
	}	
	var CmdText = "window -e -tlc " + mayabrowsertop + " " + mayabrowserleft + " -wh " + mayabrowserwidth + " " + mayabrowserbrowserheight + " MayaWindow"
	MWT_Execute(CmdText)
}
