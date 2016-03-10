import QtQuick 1.0
import com.autodesk.toolclips.qml 1.0
import "../Scripts/TCUtils.js" as TCUtils

/** \file SecondLevel.qml
	
Defines the right hand part of the Level 2 interface. It contains the expanded text and a 
video component if a video is specified in the ToolClip XML.


*/ 

Column {
	id: second_level
	opacity: 0
	spacing: TCUtils.dpi_scale(10)
	width : media_stack.width
	height : media_stack.height + expanded_text.height + spacing
	property int header_height : expanded_text.height + spacing
	property variant source : 0
    property int videoState
    property color textColor
    property variant media_stack : media_stack
    property int min_height : min_height

	Text {
		id: expanded_text
		text: if ( toolclip.childElement("expanded") && toolclip.childElement("expanded").childElement("text") ) {
			toolClipView.interpolate( toolclip.childElement("expanded").childElement("text").content )
		} else {
			""
		}
        font.pixelSize: TCUtils.dpi_scale(11)
        color : second_level.textColor
		anchors.left: parent.left
		anchors.right: parent.right

		wrapMode: Text.WordWrap
	}

	VisualItemModel {
		id : resourceModel

		Rectangle {
			id : nullResource
			property int index : VisualItemModel.index
			height : TCUtils.dpi_scale(70)
			color : "red"
		}
		VideoView {
			id : videoResource
			property int index : VisualItemModel.index
		}	
		Image {
			id : imageResource
			property int index : VisualItemModel.index
		}
	}

	Stack {
		id : media_stack
		itemModel : resourceModel
		//itemViewDelegate : stackDelegate
	}

	onSourceChanged : {
		if ( source ) {
			// we've been assigned a new resource
			// show the apporpriate stack item and assign it's source
			var tagname = source.tagName;
			if ( tagname == "video" ) {
				media_stack.activateItem( 1 )
				media_stack.current.video_frame.source = toolClipView.findResource( source.attribute("location") )
			} else if ( tagname == "image" ) {
				media_stack.activateItem( 2 )
				media_stack.current.source = toolClipView.findResource( source.attribute("location") )
			} else {	
				media_stack.activateItem( 0 )
			}
		} else {
			media_stack.activateItem( 0 )
		}
	}
}
