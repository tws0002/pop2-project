import QtQuick 1.0
import com.autodesk.toolclips.qml 1.0
import "../Scripts/TCUtils.js" as TCUtils

/** \file FirstLevel.qml

Defines the Level 1 ToolClip interface. This is simply the ToolClip top level text contained
in toolclip/text:
	
	<toolclip>
		<text>A short description of the Tool</text>
		...
	</toolclip>

*/

Text {
    id: content
    text: toolClipView.interpolate( toolclip.childElement("text").content )
    font.pixelSize: TCUtils.dpi_scale(11)
    wrapMode: Text.WordWrap
    width : TCUtils.dpi_scale(304)
    property alias textColor : content.color
}
