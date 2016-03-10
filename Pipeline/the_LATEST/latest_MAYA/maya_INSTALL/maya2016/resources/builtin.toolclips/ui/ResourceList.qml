import QtQuick 1.0
import com.autodesk.toolclips.qml 1.0
import "../Scripts/TCUtils.js" as TCUtils

/** \file ResourceList.qml

Uses the built in QML ListView along with [ScrollBar ???](ScrollBar.html) to provide
a scrollable list of resources. At this time Resources may be inline videos or external resources.
Inline videos correspond to `<video>` elements in the XML data while external resources correspond 
to `<link>` elements

	<resourcelist>
		<video location="RotateTool.mp4">Rotate Objects</video>
    	<link location="RotateTool">Rotate Too Documentation</link>
    </resourcelist>

Properties
----------

* **item_height**: <br/>The height of each item in the list. Defaults to 35 pixels.

* **model**: <br/>The model object from the XML file: i.e. the ToolClips::TCXmlElement instance corresponding to the
	`<resourcelist>` element.

* **media**: <br/>An object in which to display media resources.

* **current_index**: <br/>The index of the selected video link in the resource list.

*/

Rectangle {	
	id : resourceList	
	property int item_height : TCUtils.dpi_scale(35)
	property variant model
	property variant media
	property int current_index : 0
	color: "transparent"
	property color text_color : "black"
    //anchors.fill : parent
    property int max_height : item_height * model.count
    property int min_height : item_height * 4

	ListView {
		id: listView
		clip : true
		model : resourceList.model
		
		anchors.top : parent.top
		anchors.left : parent.left
		anchors.right : scrollBar.left
		anchors.bottom : parent.bottom
		
		boundsBehavior : if ( contentHeight < height ) { Flickable.StopAtBounds } 
						 else { Flickable.DragAndOvershootBounds }

		delegate : Rectangle {
		    id : delegate_rect
			height: resourceList.item_height
			anchors.left : parent.left
			anchors.right : parent.right
			color : "transparent"

			Rectangle {
				id : thumb_image
                x : 5
				anchors.top : parent.top
				anchors.bottom : parent.bottom
				anchors.margins : TCUtils.dpi_scale(2)
				width : resourceList.item_height
				color : "transparent"
				Image {
					source : if ( modelData.tagName == "video" ) {
					    "film.png";
					} else if ( modelData.tagName == "image") {
						"image.png";
					} else {
						if ( modelData.hasAttribute("icon") ) {
							modelData.attribute("icon")
						} else {
						    var location = modelData.attribute("location")
						    if ( location.toLowerCase().indexOf("youtube.com") > -1 ) {
	    					    "youtube_32x32.png";
	    					} else {
	    					    "book.png"
	    					}
	    				}
					}
					
					width: TCUtils.dpi_scale(20)
					height: TCUtils.dpi_scale(20)
					fillMode: Image.PreserveAspectFit
					smooth: true

					anchors.centerIn : parent
					Rectangle {
        				color : delegate_ma.containsMouse ?  Qt.rgba(0.3, 0.4, 0.6, 0.25): "transparent"
        				anchors.fill : parent
					}
				}
			}
			Text {
			    id : content_text
                color : delegate_ma.containsMouse ? Qt.rgba(0.3, 0.4, 0.6, 1.0) : (index == resourceList.current_index ? Qt.rgba( 1.0, 1.0, 0.75, 1.0) : resourceList.text_color )
				text : modelData.content
				font.pixelSize: TCUtils.dpi_scale(11)
				wrapMode : Text.WordWrap
				anchors.right : parent.right
				anchors.top : parent.top
				anchors.bottom : parent.bottom			
				anchors.left : thumb_image.right
				anchors.margins : TCUtils.dpi_scale(2)		
				horizontalAlignment : Text.AlignLeft
				verticalAlignment: Text.AlignVCenter
				
			}
			
            MouseArea {
                id : delegate_ma
                anchors.fill : parent
                hoverEnabled : true
                onClicked : {
                    var location = modelData.attribute("location");
					if ( modelData.tagName == "link" ) {
						toolClipView.openExternalResource( location )
                        
                    } else {
						resourceList.media.source = modelData
                        resourceList.current_index = index                            
                    }
                }
            }

            Component.onCompleted:
            {
                toolClipView.setItemCursor(content_text, "PointingHandCursor", "list delegate content");
                toolClipView.setItemCursor(thumb_image, "PointingHandCursor", "list delegate thumb");                
            }
		}
	    Image {
	        id : current_marker
	        anchors.left : parent.left
            y : resourceList.item_height * resourceList.current_index + (resourceList.item_height - height) /2 - listView.contentY 
            source : "marker.png"
            opacity : resourceList.current_index < 0 ? 0 : 1
	    }


	}
	ScrollBar {
		id : scrollBar
	    opacity : listView.contentHeight > listView.height
	    visible : listView.contentHeight > listView.height
		flickable: listView
		orientHorizontal: false
	}

}
