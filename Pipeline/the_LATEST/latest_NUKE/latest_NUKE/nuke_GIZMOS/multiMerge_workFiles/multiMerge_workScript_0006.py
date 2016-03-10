from __future__ import with_statement

if nuke.selectedNodes() <= 1:
    sys.exit("Not enough inputs selected")

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
        mergeNum = len(nuke.root().selectedNodes())
    else:
        mergeNum = int(thisNode.knob('merge_num').getValue()) - 1
    
    count = 0
    previous = None
    for i in xrange(mergeNum):  
        if i+1 != mergeNum:
            input_h = nuke.createNode("Input")
            merge_h = nuke.createNode("Merge")
        
        if previous is not None:
            merge_h.connectInput(0, previous)
        else:
            input2_h = nuke.createNode("Input")
            merge_h.setInput(0, None)  # disconnect the auto-connected node input
            merge_h.setInput(1, None)  # disconnect the auto-connected node input
            merge_h.connectInput(0, input_h)
            merge_h.connectInput(1, input2_h)
            count += 1
            
        previous = merge_h
        if getFromSelection:
            selectedNodes = nuke.root().selectedNodes()
            thisNode.connectInput(count-1, selectedNodes[count-1])
               
        count += 1
