import QtQuick 1.0
import com.autodesk.toolclips.qml 1.0
import "../Scripts/TCUtils.js" as TCUtils

/** \file LinkButton.qml

A simple button with an iconic image to the left and a short text description to the right.
Clients should implement onClicked() to react to a user button click.

*/

Rectangle {
    id : link_button
	property alias icon_source : icon.source
	property alias text : text.text
	height : Math.max( icon.height, text.height )
	width : icon.width + text.width + TCUtils.dpi_scale(3)
	color: "transparent"
	signal clicked

    Image { 
        id: icon
        anchors.left : parent.left
        anchors.verticalCenter: text.verticalCenter 
		width: TCUtils.dpi_scale(16)
		height: TCUtils.dpi_scale(16)
		fillMode: Image.PreserveAspectFit
		smooth: true
        Component.onCompleted:
        {
            toolClipView.setItemCursor(icon, "PointingHandCursor", "more text");
        }
        
    }  
    Text {
        id: text
        anchors.left : icon.right
        anchors.verticalCenter : parent.verticalCenter
        anchors.leftMargin : TCUtils.dpi_scale(3)
        font.bold: true
		font.pixelSize: TCUtils.dpi_scale(11)
        color : ma.containsMouse ? Qt.rgba(0.3, 0.4, 0.6, 1.0) : root.textColor
        Component.onCompleted:
        {
            toolClipView.setItemCursor(text, "PointingHandCursor", "more text");
        }
        
    }        
    
    MouseArea {
        id : ma
        hoverEnabled : true
        anchors.fill : parent
        onClicked : link_button.clicked()
        Component.onCompleted:
        {
            toolClipView.setItemCursor(ma, "PointingHandCursor", "more_ma");
        }                        
    }         

}
