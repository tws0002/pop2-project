import QtQuick 1.0
import com.autodesk.toolclips.qml 1.0

/** \file Stack.qml
*/


Rectangle {
	id : stack
    property int itemIndex : 0
 	property variant itemModel
 	property Component itemViewDelegate		
 	color : "transparent"
 	property variant current : defaultItem
    width : current.width;
    height : current.height;

	Repeater {
		model : itemModel
		delegate : itemViewDelegate
	}

    Rectangle {
        id : defaultItem
        width : 304
        height : 224
    }

	function activateItem( index ) {
		var newIndex = -1;
		var oldIndex = -1;
 		// QML Item reorders it's children when z is changed, so the index from the model is
	    // not the same as the index in the child list. Also, the Repeater instance is a child too.
	    // so we have  get the actual index from the item.
	    // note that the index of the view itself does correspond to the model index.
	    for ( var i=0; i< stack.children.length; ++i ) {
    	    if ( index === stack.children[i].index ) {
    	        newIndex = i;
    	    } else {
    	       if ( itemIndex === stack.children[i].index ) {
    	            oldIndex = i;
    	       } else {
                    stack.children[i].opacity=0
               }
            }
    	}
        if ( oldIndex >= 0 )  {
    	    // unselect the currently selected item
            stack.children[oldIndex].z = 0
            stack.children[oldIndex].visible = false
        }     
        // change the current tab index
        itemIndex = newIndex;
        if ( newIndex >= 0 ) {
            //stack.children[newIndex].current = true
            stack.children[newIndex].z = 10000
            stack.children[newIndex].visible = true;
            stack.children[newIndex].opacity = 1;
            stack.current = stack.children[newIndex];
        } else {
        	stack.current = defaultItem
        }
	}
    function initialize() {
    	// hide all the items
	    for(var i = 0; i < stack.children.length; i++) {
			tabViewContainer.children[i].visible = false;
	    }
	    activateItem(0);
	}

}