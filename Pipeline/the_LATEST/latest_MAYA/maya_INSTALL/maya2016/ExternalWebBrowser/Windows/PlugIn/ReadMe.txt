To install Maya Command Port plugin for Windows, copy npmcpplugin.dll into plugins folder of your web browser (i.e. <FirefoxLocation>/plugins)
It should be picked up by the browsers that support Netscape Plugin API next time you start the web  browser.

To see if mozilla-based web browser recognized the plugin, type about:plugins in the URL bar.

MCP plugin has the following scripting interface:

property port:
- when setting port property to some string value, plugin will connect to the named command port. This port should be open in Maya.
By default, if the check box enabled in Preferences/Applications, Maya will open command port with the name "commandportDefault".
- when queried, returns the current port name.

method execute(string):
- if plugin is connected to command port, string argument (mel command or expression) will be passed to Maya for execution.
This method returns int, double or string, depending on Maya's response.

Also, see example in Test folder on how to use the plugin.
