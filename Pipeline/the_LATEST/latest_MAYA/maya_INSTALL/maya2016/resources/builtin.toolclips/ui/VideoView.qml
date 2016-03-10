import QtQuick 1.0
import com.autodesk.toolclips.qml 1.0
import "../Scripts/TCUtils.js" as TCUtils

/** \file VideoView.qml

Provides a Video component along with a progress bar and play/pause button. The progress bar
can be scrubbed back and forth to reposition the play head.

*/

Rectangle {
    id : video_comp
    property variant video_frame : video_frame
    height : video_layout.height
    width : video_layout.width
    color : "transparent"
    
    Rectangle { 
        id : video_layout
        anchors.left : parent.left
        anchors.top : parent.top
        property int spacing : 0
        property int progressIndent : 2
        height : video_frame.height
        width : video_frame.width
        color : "transparent"

        TCVideoComponent {
            id : video_frame
            anchors.left : parent.left
            anchors.top : parent.top
            searchPath : dataLocation
            height: TCUtils.dpi_scale(contentHeight) + overlay.height
            width : TCUtils.dpi_scale(contentWidth)
            clip : true

            Rectangle {
                id : overlay
                anchors.left : parent.left
                anchors.right : parent.right
                anchors.bottom : parent.bottom
                height : TCUtils.dpi_scale(15)
                opacity : 0.9
                gradient : Gradient {
                    GradientStop { position : 0; color : Qt.hsla( 0,0, 0.2, 1) }
                    GradientStop { position : 0.1; color : Qt.hsla( 0,0, 0.2, 1) } 
                    GradientStop { position : 0.5; color : Qt.hsla( 0,0, 0.1, 1) } 
                    GradientStop { position : 0.51; color : Qt.hsla( 0,0, 0.05, 1) } 
                    GradientStop { position : 1.0; color : Qt.hsla( 0,0, 0, 1) } 
                }
                
                Image {
                    id : play_pause
                    source : 
                    {
                        if ( video_frame.state == 2  ) {
                            playpause_ma.containsMouse ? "highlightPause.png" : "pause.png";
                        } else {                       
                            playpause_ma.containsMouse ? "highlightPlay.png" : "play.png";
                        }
                    }
					width: {playpause_ma.containsMouse ? TCUtils.dpi_scale(14) : TCUtils.dpi_scale(10)}
					height: {playpause_ma.containsMouse ? TCUtils.dpi_scale(14) : TCUtils.dpi_scale(10)}
					fillMode: Image.PreserveAspectFit
                    smooth : true
                    anchors.verticalCenter: parent.verticalCenter
                    x : (parent.height - width ) / 2.0
                    
                    MouseArea {
                        id : playpause_ma
                        anchors.fill : parent
                        hoverEnabled : true
                        onClicked : {
                        //TCVideoComponent.playingState
                            if ( video_frame.state == 2 ) {
                                video_frame.pause()
                            } else {
                                video_frame.play()
                            }
                        }
                    }                  
                }                
                Rectangle {
                    id : separator
                    x : parent.height
                    anchors.top : parent.top
                    anchors.bottom : parent.bottom
                    width : TCUtils.dpi_scale(2)
                    clip : true
                    // There's no way in QML right now to draw a gradient at an angle
                    // Since we want this one to go left to right instead of up and down,
                    // we clip the drawing of children and draw a large rotated rectangle inside
                    Rectangle {
                        rotation : 90
                        width : parent.height
                        height : parent.height
                        gradient : Gradient {
                            GradientStop { position : 0; color : Qt.hsla( 0,0, 0.3, 1) }
                            GradientStop { position : 0.5; color : Qt.hsla( 0,0, 0.2, 1) } 
                            GradientStop { position : 1.0; color : Qt.hsla( 0,0, 0, 1) } 
                        }                    
                    }
                }
                Rectangle {
                    id : progress
                    anchors.left : separator.right
                    anchors.top : parent.top
                    anchors.bottom : parent.bottom
                    anchors.right : parent.right
                    color : "transparent"
                    BorderImage {
                        id : scrub_bar
                        source : "scrubBar.png"
                        x : thumb.width / 2
                        width : (parent.width - thumb.width) * video_frame.loadProgress
                        anchors.verticalCenter : parent.verticalCenter
                        border.left : TCUtils.dpi_scale(5)
                        border.right : TCUtils.dpi_scale(5)
                        border.top : 0
                        border.bottom : 0
                    }
                    Image {
                        id : thumb
                        x : video_frame.progress * scrub_bar.width
                        
                        anchors.verticalCenter : parent.verticalCenter
                        source : "thumb.png"
						width: TCUtils.dpi_scale(12)
						height: TCUtils.dpi_scale(11)
						fillMode: Image.PreserveAspectFit
						smooth: true
                    }
                        
                    Component.onCompleted:
                    {
                        toolClipView.setItemCursor(overlay, "PointingHandCursor", "progress");
                    }
                    
                    MouseArea {
                        id : overlay_ma
                        anchors.fill : parent
                        onPositionChanged : {
                            video_frame.progress = Math.max(0, ( mouse.x / width ));
                        }
                        onPressed : {
                            video_frame.progress = Math.max(0, ( mouse.x / width ));
                            video_frame.scrubbing = true
                        }
                        onReleased : {
                            video_frame.scrubbing = false
                        }
                    }
                }
            }            
        }       
	}
}