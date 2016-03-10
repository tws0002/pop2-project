import QtQuick 1.0
import com.autodesk.toolclips.qml 1.0
import "../Scripts/TCUtils.js" as TCUtils


/** \file ToolClipUI.qml

ToolClipUI.qml is the root UI for the full ToolClip user interface. 

*/

TCStyledRectangle {
    id : root
	property int borderMargin : TCUtils.dpi_scale(14)  
	property int columnSpacing : TCUtils.dpi_scale(10)
    width : frame.width + borderMargin
    height : frame.height + borderMargin
    toolTipStyle : root.state != "expanded"

    Rectangle {
        id: frame
        x : root.borderMargin / 2
        y : root.borderMargin / 2
        width: main.width 
        height: main.height
        color : "transparent"


        NumberAnimation {
            easing.type: Easing.InOutQuad
            properties: "width,height";
            duration: 200
            target: main
        }

        Row {
            id : main
			height : base_levels.height
            spacing : root.columnSpacing
            		
            Rectangle {
            	id: base_levels
                width : Math.max( TCUtils.dpi_scale(100), Math.max( first_level.width, second_level.width ))
                height : header.height + level_content.height + footer.height + spacing + spacing
                property int spacing: TCUtils.dpi_scale(10)              
                color : "transparent"

                Rectangle {
                    id : header
                    anchors.left : parent.left
                    anchors.right : parent.right
                    anchors.top : parent.top
                    height : Math.max( title.height, shortcut.height )
                    width : base_levels.width
                    color : "transparent"
                    //spacing : 5
                    
                    Text {
                        id: title
                        text: toolClipView.interpolate( toolclip.attribute("title") )
                        font.bold: true
                        font.pixelSize: TCUtils.dpi_scale(11)
                        horizontalAlignment: Text.AlignLeft
                        anchors.left : parent.left
                        anchors.verticalCenter : parent.verticalCenter
                        color : root.textColor
                    }

                    Text {
                        id: shortcut
                        text: if ( toolclip.hasAttribute("shortcut") ) { "(" + toolclip.attribute("shortcut") + ")" } else { "" }
                        font.bold: true
                        font.pixelSize: TCUtils.dpi_scale(11)
                        horizontalAlignment: Text.AlignRight
                        anchors.right : parent.right
                        anchors.verticalCenter : parent.verticalCenter
                        color : root.textColor                        
                    }
                }		
                Rectangle {
                    height : TCUtils.dpi_scale(5)
                }
                Column {
                    id : level_content
                    anchors.left : parent.left
                    anchors.right : parent.right
                    anchors.top : header.bottom 
                    anchors.topMargin :base_levels.spacing
                    spacing : 0

                    FirstLevel {
                        id: first_level
                        textColor : root.textColor
                    }
                    SecondLevel {
                        id: second_level
                        textColor : root.textColor
                        opacity : 0
                        min_height : third_level.min_height
                    }
                }                

                Rectangle {
                    id: footer
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.top : level_content.bottom
                    anchors.topMargin : base_levels.spacing
                    // assume that more and help have the same sized icons. 
                    height : more.height + TCUtils.dpi_scale(6)
                    color : "transparent"

                    LinkButton {
                        id : more
                        icon_source: "film2.png"
                        opacity : root.state != "expanded" && toolclip.childElement("expanded") ? 1 : 0
                        anchors.verticalCenter : parent.verticalCenter
                        anchors.right : parent.right
                        text : toolClipView.translate(qsTr("More...", "ToolClipUI"), "ToolClipUI" )
                        onClicked : root.state = 'expanded'
                    }

                    LinkButton {
                        id : help 
                        icon_source: "question_frame.png"
                        opacity : root.state == "expanded" || !toolclip.childElement("expanded") ? 1 : 0
                        anchors.verticalCenter : parent.verticalCenter
                        anchors.left : parent.left
                        property string url
                        url : if ( toolclip.attribute("help") ){
                            toolclip.attribute("help")
                        } else {
                            "/index.html"    
                        }
                        text : toolClipView.translate(qsTr("Help", "ToolClipUI"), "ToolClipUI")
                        onClicked : toolClipView.openExternalResource( url )
                    }                        

                }            
            }
            
            ResourcePanel {
            	id: third_level
            	thirdLevelModel : if ( toolclip.childElement("expanded") ) {
            	        toolclip.childElement("expanded").childElement("resourcelist").childElementList("");
            	    } else { 
            	        0 
            	    }
                header_height : if ( second_level.media_stack.current.index > 0  ) {
                    header.height + first_level.height + second_level.header_height + base_levels.spacing
                    } else {
                        0
                    }
            	media : second_level
            	footer_height : footer.height 
            	opacity: 0
            	width: TCUtils.dpi_scale(210)
				anchors.top : parent.top
            	anchors.bottom : parent.bottom
                text_color : root.textColor
            }
        }

    }    

    function defaultMediaIndex( ){
        var index;
        if ( toolclip.childElement("expanded")) {
            if ( toolclip.childElement("expanded").childElement("default-resource") && 
                    toolclip.childElement("expanded").childElement("default-resource").attribute("index") ) {
                var result = toolclip.childElement("expanded").childElement("default-resource").attribute("index") - 1;
            } else { 
                var list = toolclip.childElement("expanded").childElement("resourcelist").childElementList("");

                for ( var i = 0; i < list.length ; i++ ) {
                    var tagname = list[i].tagName;
                    if ( list[i].attribute("location") && (tagname=="video" || tagname=="image") ) {
                        return i;
                    }
                }
            }
        }
        return 0;
    }

    function defaultMediaSource( ) {
        if ( toolclip.childElement("expanded") && toolclip.childElement("expanded").childElement("resourcelist") ) {
            var index = defaultMediaIndex();
            var result = toolclip.childElement("expanded").childElement("resourcelist").childElementList("")[index];
            return result;
        }
        return "";
    }

    states: [
        State {
            name: ""
            PropertyChanges {
                target: second_level
                videoState: 0
                opacity: 0
            }
            PropertyChanges {
            	target: third_level
            	opacity: 0
            }    
            PropertyChanges {
                target : toolClipView
                stayOpen : false
                reserved : false
            }            
        },

        State {
            name: "expanded"

            PropertyChanges {
                target: second_level
                opacity : 1
                videoState: 0
            }
            PropertyChanges {
            	target: third_level
            	opacity: 1
            }      
            PropertyChanges {
                target : toolClipView
                stayOpen : true // set to true to hold expanded window open indefinitely
                reserved : true
            }
            PropertyChanges {
                target : second_level
                source : defaultMediaSource()

            }
            PropertyChanges {
                target : third_level
                current_index : defaultMediaIndex()
            }
        }

    ]
    
 
    transitions: [
        Transition {
            from: "*"; to : "*"
            NumberAnimation {
                easing.type: Easing.InOutQuad
                properties: "width,height"
                duration: 1000
            }
        }
    ]

}
