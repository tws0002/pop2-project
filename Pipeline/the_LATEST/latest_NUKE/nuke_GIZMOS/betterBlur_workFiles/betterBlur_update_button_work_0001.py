from __future__ import with_statement

# thisNode = nuke.thisNode()

thisNode = nuke.toNode('Group1')
quality = int(thisNode.knob("quality").getValue())
minimum = int(thisNode.knob("minBlur").getValue())
maximum = int(thisNode.knob("maxBlur").getValue())

with thisNode:
    # GET INFO FOR REINITIALIZATION
    connectedNode = thisNode.input(0)

    # RESET ALL
    nAll = nuke.allNodes()
    [nuke.delete(n) for n in nAll]
    
    # REINITIALIZATION FROM START
    input = nuke.nodes.Input()
    input.setInput(0, connectedNode)

    for i in xrange(quality):
        step = 1 - float(i)/quality
        print step
        blur = nuke.nodes.Blur()
        merge = nuke.nodes.Merge()
        
        blur.connectInput(0, input)
        blur.knob("size").setValue( (step * maximum) + minimum)
        merge.connectInput(1, blur)
        if i == 0:
            merge.connectInput(0, input)
        else:
            merge.connectInput(0, previous)
        
        previous = merge

    # create one more
    blur = nuke.nodes.Blur()
    merge = nuke.nodes.Merge()
    
    blur.connectInput(0, input)
    blur.knob("size").setValue(minimum)
    merge.connectInput(1, blur)
    if i == 0:
        merge.connectInput(0, input)
    else:
        merge.connectInput(0, previous)

    output = nuke.nodes.Output()
    output.connectInput(0, merge)