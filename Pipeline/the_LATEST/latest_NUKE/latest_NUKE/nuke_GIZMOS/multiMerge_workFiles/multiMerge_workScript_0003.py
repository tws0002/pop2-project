from __future__ import with_statement
# thisNode = nuke.thisNode()
thisNode = nuke.toNode('Group1')
selectedNodes = nuke.selectedNodes()
numOfInputs = thisNode.inputs()
with thisNode:
    # RESET
    nAll = nuke.allNodes()
    
    for i in xrange(numOfInputs):
        thisNode.setInput(i, None)
    
    [nuke.delete(n) for n in nAll if n.name() != "MasterMerge"]

    # REINITIALIZE AND CONNECT
    getFromSelection = int(thisNode.knob('getFromSelection').getValue())
    if getFromSelection:
        mergeNum = len(selectedNodes)
    else:
        mergeNum = int(thisNode.knob('merge_num').getValue())
    
    count = 0
    previous = None
    for i in xrange(mergeNum):
        input_h = nuke.createNode("Input")
        merge_h = nuke.createNode("Merge")
        
        if previous is not None:
            merge_h.connectInput(0, previous)
            # merge_h.connectInput(1, input_h)
            pass
        else:
            count += 1
            input2_h = nuke.createNode("Input")
            merge_h.connectInput(1, input2_h)
            # merge_h.connectInput(1, input2_h)  # mask
        
        previous = merge_h
    
        if getFromSelection and previous is None:
            thisNode.connectInput(count, selectedNodes[count])
        elif getFromSelection and previous is not None:
            thisNode.connectInput(count-1, selectedNodes[count-1])
            
        count += 1
