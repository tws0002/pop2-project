from __future__ import with_statement
# thisNode = nuke.thisNode()
thisNode = nuke.toNode('Group1')
selectedNodes = nuke.selectedNodes()

with thisNode:
    # RESET
    nAll = nuke.allNodes()

    for n in nAll:
        nuke.delete(n)
    
    # REINITIALIZE AND CONNECT
    getFromSelection = int(thisNode.knob('getFromSelection').getValue())
    if getFromSelection:
        mergeNum = len(selectedNodes) - 1
    else:
        mergeNum = thisNode.knob('merge_num')
        previous = None
    
    count = 0
    for i in xrange(mergeNum):
        input_h = nuke.createNode("Input")
        merge_h = nuke.createNode("Merge")

        if previous is not None:
            merge_h.setInput(0, previous)
            merge_h.setInput(1, input_h)
        else:
            count += 1
            input2_h = nuke.createNode("Input")
            merge_h.setInput(0, input_h)
            merge_h.setInput(1, input2_h)
        
        previous = merge_h
    
        if getFromSelection and previous is not None:
            thisNode.setInput(count, selectedNode[count])


        count += 1

"""

from __future__ import with_statement
thisNode = nuke.thisNode()
subdivs = int(thisNode['subdivisions'].value())
resolution = int(thisNode['resolution'].value())

with thisNode :

	nAll = nuke.allNodes()
	print nAll

	for n in nAll:
    		if n.name().split('_')[0] == 'sub' :
        			nuke.delete(n)
	for j in range(subdivs):
    		i = j + 1

    		##Noise
    		noiseKnobs = ['octaves', 'nyquist', 'lacunarity', 'gain', 'gamma', 'translate', 'rotate', 'skew', 'center', 'ramp', 'color', 'xrotate', 'yrotate']
    		noise = nuke.nodes.Noise(xpos = nuke.toNode('Noise0').xpos()+i*150,
                    	                          	ypos =nuke.toNode('Noise0').ypos())
    		noise.setName('sub_' + str(i) + '_Noise')
    		noise['color'].setValue([0,0,0,0])
    		for k in noiseKnobs :
        			noise[k].setExpression('parent.Noise0.' + str(k))
    		noise['size'].setValue([0,0])
    		noise['size'].setExpression('parent.Noise0.size.0',0)
    		noise['size'].setExpression('parent.Noise0.size.1',1)
    		noise['scale'].setValue([0,0])
    		noise['scale'].setExpression('parent.Noise0.scale.w',0)
    		noise['scale'].setExpression('parent.Noise0.scale.h',1)
    		noise['zoffset'].setExpression('parent.Noise0.zoffset+' + str(i) + '*parent.variancy')
    		noise['xrotate'].setExpression('parent.Noise0.xrotate')
    		noise['yrotate'].setExpression('parent.Noise0.yrotate')
    		noise.setInput(0,nuke.toNode('Base'))
	
    		##Ramp
    		unpRamp = nuke.nodes.Unpremult(xpos = nuke.toNode('Noise0').xpos()+i*150,
                    	                                         	ypos =nuke.toNode('Unpremult0').ypos())
    		unpRamp.setName('sub_' + str(i) + '_Unpremult')
    		unpRamp['disable'].setExpression('!parent.color_rampBT')
    		unpRamp.setInput(0,noise)
	
    		ramp = nuke.nodes.Ramp(xpos = nuke.toNode('Noise0').xpos()+i*150,
                    	                          	ypos = nuke.toNode('Ramp0').ypos())
    		ramp.setName('sub_' + str(i) + '_Ramp')
    		ramp['disable'].setExpression('!parent.color_rampBT')
    		ramp['p0'].setExpression('parent.color_p0')
    		ramp['output'].setValue('rgb')
    		ramp['color'].setValue([0,0,0,0])
    		ramp['color'].setExpression('parent.color_color2.r',0)
    		ramp['color'].setExpression('parent.color_color2.g',1)
    		ramp['color'].setExpression('parent.color_color2.b',2)
    		ramp['p1'].setExpression('parent.color_p1')
    		ramp.setInput(0,unpRamp)
	
	    	preRamp = nuke.nodes.Premult(xpos = nuke.toNode('Noise0').xpos()+i*150,
                    	                                        	ypos =nuke.toNode('Premult0').ypos())
    		preRamp.setName('sub_' + str(i) + '_premult')
    		preRamp['disable'].setExpression('!parent.color_rampBT')
    		preRamp.setInput(0,ramp)
	

    		##Blur
    		blur = nuke.nodes.Blur(xpos = nuke.toNode('Noise0').xpos()+i*150,
                    	                     	ypos = nuke.toNode('Blur0').ypos())
    		blur.setName('sub_' + str(i) + '_Blur')
    		blur['channel'].setValue('rgba')
    		blur['size'].setValue([10,20])
    		blur['size'].setExpression('parent.Blur0.size.w',0)
    		blur['size'].setExpression('parent.Blur0.size.h',1)
    		blur.setInput(0,preRamp)
	

    		##Edge smooth
    		smoothEdge = nuke.nodes.Multiply(xpos = nuke.toNode('Noise0').xpos()+i*150,
                  			                      	ypos =nuke.toNode('Multiply0').ypos())
    		smoothEdge.setName('sub_' + str(i) + '_Multiply_SEdges')
    		smoothEdge['channel'].setValue('rgba')
    		smoothEdge['value'].setValue(0)
    		smoothEdge['invert_mask'].setValue(True)
    		smoothEdge['disable'].setExpression('!parent.softEdges')
    		smoothEdge.setInput(0,blur)
    		smoothEdge.setInput(1, nuke.toNode('GradeEdge'))
    	
    		##All the ramps
    		decay_x = nuke.nodes.Ramp(xpos = nuke.toNode('Noise0').xpos()+i*150,
                    	                               	ypos =nuke.toNode('Ramp_X0').ypos())
    		decay_x.setName('sub_' + str(i) + '_Ramp_x')
    		decay_x['type'].setValue('smooth')
    		decay_x['color'].setValue(0)
    		decay_x['disable'].setExpression('!parent.decay_XBT')
    		decay_x['p0'].setValue([100,100])
    		decay_x['p0'].setExpression('(parent.decay_Xmax==0?1:parent.decay_Xmax)*20.48',0)
    		decay_x['p1'].setValue([100,100])
    		decay_x['p1'].setExpression('(parent.decay_Xmin>=parent.decay_Xmax?parent.decay_Xmax-1:parent.decay_Xmin)*20.48',0)
    		decay_x.setInput(0,smoothEdge)
		
    		decayx = nuke.nodes.Ramp(xpos = nuke.toNode('Noise0').xpos()+i*150,
                                        	           	ypos =nuke.toNode('RampX0').ypos())
    		decayx.setName('sub_' + str(i) + '_Rampx')
    		decayx['type'].setValue('smooth')
    		decayx['color'].setValue(0)
    		decayx['disable'].setExpression('!parent.decayXBT')
    		decayx['p0'].setValue([100,100])
    		decayx['p0'].setExpression('2048-(parent.decayXmax==0?1:parent.decayXmax)*20.48',0)
    		decayx['p1'].setValue([100,100])
    		decayx['p1'].setExpression('2048-(parent.decayXmin>=parent.decayXmax?parent.decayXmax-1:parent.decayXmin)*20.48',0)
    		decayx.setInput(0,decay_x)
		
    		decay_y = nuke.nodes.Ramp(xpos = nuke.toNode('Noise0').xpos()+i*150,
                    	                               	ypos =nuke.toNode('Ramp_Y0').ypos())
    		decay_y.setName('sub_' + str(i) + '_Ramp_y')
    		decay_y['type'].setValue('smooth')
    		decay_y['color'].setValue(0)
    		decay_y['disable'].setExpression('!parent.decay_YBT')
    		decay_y['p0'].setExpression('(parent.decay_Ymax==0?1:parent.decay_Ymax)*20.48',1)
    		decay_y['p1'].setExpression('(parent.decay_Ymin>=parent.decay_Ymax?parent.decay_Ymax-1:parent.decay_Ymin)*20.48',1)    							
		decay_y.setInput(0,decayx)


	    	decayy = nuke.nodes.Ramp(xpos = nuke.toNode('Noise0').xpos()+i*150,
				ypos =nuke.toNode('RampY0').ypos())
	    	decayy.setName('sub_' + str(i) + '_Rampy')
	    	decayy['type'].setValue('smooth')
	    	decayy['color'].setValue(0)
	    	decayy['disable'].setExpression('!parent.decayYBT')
	    	decayy['p0'].setExpression('2048-(parent.decayYmax==0?1:parent.decayYmax)*20.48',1)
	    	decayy['p1'].setExpression('2048-(parent.decayYmin>=parent.decayYmax?parent.decayYmax-1:parent.decayYmin)*20.48',1)
	    	decayy.setInput(0,decay_y)
	
	    	decay_z = nuke.nodes.Dissolve(xpos = nuke.toNode('Noise0').xpos()+i*150,
	                                                       	ypos =nuke.toNode('Dissolve_Z0').ypos())
	    	decay_z.setName('sub_' + str(i) + '_Dissolve_z')
	    	decay_z['channel'].setValue('rgba')
	    	decay_z['disable'].setExpression('!parent.decay_ZBT')
	    	decay_z['which'].setExpression('parent.decay_Zmin>='+str(i)+'*100/'+str(subdivs)+'?1:parent.decay_Zmax<='+str(i)+'*100/'+str(subdivs)+'?0:1-('+str(i)+'*100/'+str(subdivs)+'-(parent.decay_Zmin>=parent.decay_Zmax?parent.decay_Zmax-0.01:parent.decay_Zmin))/(parent.decay_Zmax-(parent.decay_Zmin>=parent.decay_Zmax?parent.decay_Zmax-0.01:parent.decay_Zmin))')
	    	decay_z['disable'].setExpression('!parent.decay_ZBT')
    		decay_z.setInput(1,nuke.toNode('Base'))
    		decay_z.setInput(0,decayy)
	


 	   	##Opacity
    		dissolve = nuke.nodes.Dissolve(xpos = nuke.toNode('Noise0').xpos()+i*150,
                                        	               	ypos =nuke.toNode('Dissolve0').ypos())
    		dissolve.setName('sub_' + str(i) + '_Dissolve')
    		dissolve['channel'].setValue('rgba')
    		dissolve['which'].setExpression('parent.Dissolve0.which')
    		dissolve.setInput(1,decay_z)
    		dissolve.setInput(0,nuke.toNode('Base'))
		

	    	##Card
	    	card = nuke.nodes.Card2(xpos = nuke.toNode('Noise0').xpos()+i*150,
	                                              	ypos =nuke.toNode('Card0').ypos())
	    	card.setName('sub_' + str(i) + '_Card')
	    	card['rows'].setExpression('parent.resolution')
	    	card['columns'].setExpression('parent.resolution')
	    	card['translate'].setValue([0,0,0.5-i*1/subdivs])
	    	card.setInput(0,dissolve)



    		##ProcGeo
	    	proc = nuke.nodes.ProcGeo(xpos = nuke.toNode('Noise0').xpos()+i*150,
                     	                         	ypos =nuke.toNode('ProcGeo0').ypos())
    		proc.setName('sub_' + str(i) + '_ProcGeo')
    		proc['x_size'].setExpression('parent.dNoiseX')
    		proc['x_offset'].setExpression('parent.dNoiseXoffset+' + str(i) + '*parent.dNoiseVariancy')
    		proc['y_size'].setExpression('parent.dNoiseY')
    		proc['y_offset'].setExpression('parent.dNoiseYoffset+' + str(i) + '*parent.dNoiseVariancy')
    		proc['Octaves'].setExpression('parent.dNoiseOctaves')
    		proc['Lacunarity'].setExpression('parent.dNoiseLacunarity')
    		proc['Gain'].setExpression('parent.dNoiseGain')
    		proc['Speed'].setExpression('parent.dNoiseSpeed')
    		proc['disable'].setExpression('!parent.dNoise')
    		proc.setInput(0,card)
    		nuke.toNode('Scene_layers').setInput(i,proc)



"""
