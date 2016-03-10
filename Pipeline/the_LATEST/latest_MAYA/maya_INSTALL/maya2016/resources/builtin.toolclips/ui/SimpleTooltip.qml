import QtQuick 1.0
import com.autodesk.toolclips.qml 1.0

/** \file SimpleTooltip.qml

A Simplified Tooltip which presents only the tool name and keyboard shortcut.

*/

TCStyledRectangle {
    id : root
    toolTipStyle: true
    property int borderMargin : 6   
    property int columnSpacing : 10
    width : frame.width + borderMargin
    height : frame.height + borderMargin

    Rectangle {
        id: frame
        x : root.borderMargin / 2
        y : root.borderMargin / 2
        width: title.width + shortcut.width + columnSpacing
        height: Math.max( title.height, shortcut.height )
        color : "transparent"

        Text {
            id: title
            text: toolClipView.interpolate( toolclip.attribute("title") )
            font.bold: true
            horizontalAlignment: Text.AlignLeft
            color : root.textColor
            anchors.left : parent.left
        }

        Text {
            id: shortcut
            text: if ( toolclip.hasAttribute("shortcut") ) { "(" + toolclip.attribute("shortcut") + ")" } else { "" }
            font.bold: true
            horizontalAlignment: Text.AlignRight
            color : root.textColor                        
            anchors.right : parent.right
        }
    }
}
