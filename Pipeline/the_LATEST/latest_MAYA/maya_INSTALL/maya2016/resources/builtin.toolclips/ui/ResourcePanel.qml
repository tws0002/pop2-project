import QtQuick 1.0
import com.autodesk.toolclips.qml 1.0
import "../Scripts/TCUtils.js" as TCUtils

/** \file ResourcePanel.qml

Adds a vertical separator and a resource list to the right side of the expanded Level 2 interface

*/

Rectangle {
    id : third_level_root
    property int header_height : 0
	property variant thirdLevelModel
	property variant media
	property int footer_height
    property alias current_index : third_level_resource_list.current_index
    property color text_color : "black"
    color: "transparent"	
    property int max_height : third_level_resource_list.max_height
    property int min_height : third_level_resource_list.min_height
    
    Rectangle {
        id: header
        anchors.top : parent.top
        height : third_level_root.header_height
        anchors.left : parent.left
        anchors.right :parent.right
        color : "transparent"
    }

    Image {
        id : separator
        source : "separator.png"     
        anchors.left : parent.left
        anchors.top : parent.top
        anchors.bottom : parent.bottom
    }    
    
    ResourceList {
        id : third_level_resource_list
        model : thirdLevelModel
        media : third_level_root.media
        anchors.left : separator.right
        anchors.right : parent.right
        anchors.top : header.bottom
        anchors.bottom : parent.bottom
        anchors.leftMargin : TCUtils.dpi_scale(10)
        text_color : third_level_root.text_color
    }

    
}

