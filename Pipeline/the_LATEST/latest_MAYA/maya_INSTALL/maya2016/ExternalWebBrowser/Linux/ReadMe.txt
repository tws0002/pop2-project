To install Maya Command Port plugin for Linux, copy libmcpplugin.so into plugins folder of your web browser (i.e. <FirefoxLocation>/plugins)
It should be picked up by the browsers that support Netscape Plugin API next time you start the web  browser.

Ensure that you are using the proper 32/64 bit version of the plugin to match
your web broswer.

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

MEL url handling is implemented using melurlhandler. You can install it at any convenient location.
Here is an example how to register this handler in the mozilla-based web browser:

- Type about:config into the address bar
- Right-click create new boolean value: network.protocol-handler.external.mel and set to true
- Right-click create new boolean value: network.protocol-handler.warn-external.mel and set to false
- Right-click create new string value: network.protocol-handler.app.mel and set to <HandlerLocation>/melurlhandler

You can also optionally register the protocol with whatever window manager you are using. In KDE this is done through Control Center - KDE Components - File Associations.
Please note, in this version mel url handling is done through default command port, so commandportDefault port has to be open on Maya side.
