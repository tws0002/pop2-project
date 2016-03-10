import QtQuick 1.0
import com.autodesk.toolclips.qml 1.0

/** \file ScrollBar.qml

Adds a scroll bar to the right or bottom of flickable element. 

Properties
----------

* **flickable**: <br/>The flickable to which the scrollbar is attached to, must be set.

* **vertical**: <br/>True for vertical scroll bar, false for horizontal

* **hide_at_rest**: <br/>True if the scroll bar should hide when not scrolling.

* **scroll_bar_width**: <br/>Thickness of the scrollbar, in pixels.

*/

TCScrollBar {
	property variant flickable
	orientHorizontal : false
	property bool hide_at_rest: false
	property int updatingPosition : 0
	property double flickPosition : orientHorizontal ? flickable.contentX : flickable.contentY
	x : orientHorizontal ? 0 : parent.width - width
	y : orientHorizontal ? parent.height - height : 0
	width : orientHorizontal ? parent.width : scrollBarWidth
	height : orientHorizontal ? scrollBarWidth : parent.height

	onFlickPositionChanged : {
		if ( 0==updatingPosition ) {
			updatingPosition ++
			setPositionExternal( ((flickPosition - flickable.y) / (flickable.contentHeight - height) * (end - start)) + start )
			updatingPosition --
		}
	}


	onPositionChanged : {
		if ( 0==updatingPosition ) {
			updatingPosition ++
			if (!flickable.flicking || flickable.moving ) {
				if ( orientHorizontal ) {
					flickable.contentX = flickable.x + position * (flickable.contentWidth - width) / (end-start)
				} else {
					flickable.contentY = flickable.y + position * (flickable.contentHeight - height) / (end-start)
				}
			}
			updatingPosition--
		}
	}

	function sbOpacity()
	{
		if (!hide_at_rest) {
			return 0.5;
		}

		return (flickable.flicking || flickable.moving) ? (!orientHorizontal ? (height >= parent.height ? 0 : 0.5) : (width >= parent.width ? 0 : 0.5)) : 0;
	}

	// Animate scrollbar appearing/disappearing
	Behavior on opacity { NumberAnimation { duration: 200 }}
	onWidthChanged : {
		updateDimensions();
	}
	onHeightChanged : {
		updateDimensions();
	}

}