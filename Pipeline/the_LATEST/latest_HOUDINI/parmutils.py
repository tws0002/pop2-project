#
# Produced by:
#	Graham Thompson
#	captainhammy@gmail.com
#	www.captainhammy.com
#
# Name:         parmutils.py
#
# Comments:     Functions dealing with parameters.
#
# Version:      1.0
#
# Compatibility: Houdini 11.0
# Taken from: http://www.houdinitoolbox.com/houdini.php?asset=15
# 

import hou

import os
import re


def copyParmValues(source_node, target_node):
    """ Copy parameter values of the source node to those of the target node 
        if a parameter with the same name exists.
    """
    for parm_to_copy in source_node.parms():
        parm_template = parm_to_copy.parmTemplate()
        # Skip folder parms.
        if isinstance(parm_template, hou.FolderSetParmTemplate):
            continue

        parm_to_copy_to = target_node.parm(parm_to_copy.name())
        # If the parameter on the target node does not exist, skip this parm.
        if parm_to_copy_to is None:
            continue

        # If we have keys/expressions we need to copy them all.
        if parm_to_copy.keyframes():
            # Copy all hou.Keyframe objects.
            for key in parm_to_copy.keyframes():
                parm_to_copy_to.setKeyframe(key)
        else:
            # If the parameter is a string copy the raw string.
            if isinstance(parm_template, hou.StringParmTemplate):
                parm_to_copy_to.set(parm_to_copy.unexpandedString())
            # Copy the raw value.
            else:
                parm_to_copy_to.set(parm_to_copy.eval())


def linkParmsTo(source_node, target_node):
    """ Link the parms of the source node to those of the target node if 
        a parameter with the same name exists.
    """
    for parm_to_link in source_node.parms():
        # Skip folder parms.
        if isinstance(parm_to_link.parmTemplate(), hou.FolderSetParmTemplate):
            continue

        parm_to_link_to = target_node.parm(parm_to_link.name())

        # If the target parm exists
        if parm_to_link_to is not None:
            parm_to_link.set(parm_to_link_to)


def copySpareParms(source_node, target_node):
    """ Copy spare parameters from the source node to the target node. """
    spare_parms = [parm_tuple for parm_tuple in source_node.parms()
                   if parm_tuple.isSpare()]

    for parm_tuple in spare_parms:
        template = parm_tuple.parmTemplate()
        
        if isinstance(template, hou.FolderSetParmTemplate):
            continue

        folders = parm_tuple[0].containingFolders()

        target_node.addSpareParmTuple(template, folders, True)

def copyParameterLayout(source_node, target_node):
    """ Copy the entire parameter layout from the source node to the target_node. """
    parm_template_group = source_node.parmTemplateGroup()
    target_node.setParmTemplateGroup(parm_template_group)


def hardenAssetParameters(node):
    """ Convert any spare parameters on an asset node to asset parameters. """
    
    # Get the node type definition.  It will be None if the node is
    # not an asset.
    asset_definition = node.type().definition()

    # Make sure the node is a digital asset.
    if asset_definition is None:
        raise hou.OperationFailed("Node must be a digital asset.")
    
    # Get the parameter template group from the node.
    parm_template_group = node.parmTemplateGroup()
    # Set the parameter template on the asset to be the one from
    # the node.  This converts all spare parameters to normal
    # asset parameters.
    asset_definition.setParmTemplateGroup(parm_template_group)


def copyAndReplace(source_node):
    """ Replace a node with a new instance and copy the parameters."""

    # Create a new instance of the node.
    new_node = source_node.parent().createNode(source_node.type().name())

    # If the node is selected, set the new one selected.
    if source_node.isSelected():
        new_node.setSelected(True, False)

    # Copy the parms.
    parm_template_group = source_node.parmTemplateGroup()
    new_node.setParmTemplateGroup(parm_template_group)

    # Match the position and color.
    new_node.setPosition(source_node.position())
    new_node.setColor(source_node.color())

    # Process inputs.
    input_connections = source_node.inputConnections()

    for connection in input_connections:
        in_idx = connection.inputIndex()
        out_idx = connection.outputIndex()
        input_node = connection.inputNode()
    
        new_node.setInput(in_idx, input_node, out_idx)

    # Process outputs.
    output_connections = source_node.outputConnections()

    for connection in output_connections:
        in_idx = connection.inputIndex()
        out_idx = connection.outputIndex()
        output_node = connection.outputNode()
    
        output_node.setInput(in_idx, new_node, out_idx)
    
    #TODO: Per context flag handling.


    # If this is a Sop, look at setting the Render flag.
    if isinstance(new_node, hou.SopNode):
        new_node.setRenderFlag(source_node.isRenderFlagSet())

    new_node.setDisplayFlag(source_node.isDisplayFlagSet())

    name = source_node.name()

    source_node.destroy()
    
    new_node.setName(name)


def parmValueDictionary(node):
    """ Get a dictionary of all the parameters and corresponding
        values.
    """
    parm_dict = {}
    for parm in node.parms():
        if not parm.keyframes():
            parm_dict[parm.name()] = parm.eval()

    return parm_dict
            

def parmExpressionDictionary(node):
    """ Get a dictionary of all the parameters with expressions
        and their corresponding values.
    """
    parm_dict = {}
    for parm in node.parms():
        if parm.keyframes():
            parm_dict[parm.name()] = parm.keyframes()[0].expression()

    return parm_dict


def displayParmInDialog(parm_or_parm_tuple):
    """ Force the parameter dialog to display this parameter. """
    if isinstance(parm_or_parm_tuple, hou.ParmTuple):
        parm_or_parm_tuple = parm_or_parm_tuple[0]

    for tpl, idx in zip(parm_or_parm_tuple.containingFolderSetParmTuples(),
                        parm_or_parm_tuple.containingFolderIndices()):
        tpl[0].set(idx)


def defaultValue(parm_or_parm_tuple):
    """ Get the default value of a parameter. """
    # Handle a hou.Parm object.
    if isinstance(parm_or_parm_tuple, hou.Parm):
        # Get the parm tuple so we can access the names of all 
        # the parms in the group.
        parm_tuple = parm_or_parm_tuple.tuple()
        # Get a list of the parm names.
        parm_names = [parm.name() for parm in parm_tuple]
        # Find the index of our parm in the tuple.
        idx = parm_names.index(parm_or_parm_tuple.name())
        # Use the index to get the correct default value and return it.
        return parm_tuple.parmTemplate().defaultValue()[idx]
    
    else:
        return parm_or_parm_tuple.parmTemplate().defaultValue()
        

def isDefaultValue(parm_or_parm_tuple):
    """ Determine if the parameter is currently set to the default value. """
    default = defaultValue(parm_or_parm_tuple)
    return parm_or_parm_tuple.eval() == default


def applyFunctionToParms(parm_list, function, args=()):
    """ Apply a function with specific args to each parameter in the list.

        The hou.Parm object is inserted into the beginning of the args list.
    """
    for parm in parm_list:
        function.__call__((parm,) + args)


def linkParmToParent(parm):
    """ Link a parameter to a parameter of the same name on the parent node
        if the parameter exists.
    """
    parent = parm.node().parent()

    parm_node = parm.node()

    parent_parm = parent.parm("%s_%s" % (parm_node.name(), parm.name()))
    if parent_parm is None:
        parent_parm = parent.parm(parm.name())
    if parent_parm:
        parm.set(parent_parm)


def promoteToParent(parm_tuple):
    """ Promote a parameter to the parent node. """
    parent = parm_tuple.node().parent()
    promoteToNode(parm_tuple, parent)


def promoteToNode(source_tuple, target_node=None):
    """ Promote a parameter to a specific node as a spare parameter.
        
       A new parameter is created with the name nodename_parmname.
       Promoting the "t" parameter from a node called "xform1" will
       create a new parameter "xform1_t".

    """
    # Get the source node.
    source_node = source_tuple.node()
    source_node_name = source_node.name()

    if target_node is None:
        # If the ui module isn't available then we can't choose a
        # node so we will throw an exception.
        if not hou.isUIAvailable():
            raise hou.OperationFailed("Please specify a target node.")

        # Try to select a node.
        target_node_path = hou.ui.selectNode()
        if target_node_path is None:
            return
        target_node = hou.node(target_node_path)

    # Get the parameter template and change the name and label.
    template = source_tuple.parmTemplate()

    # Change the parm name and label to include the source node name.
    parm_name = "%s_%s" % (source_node_name, source_tuple.name())
    parm_label = "%s %s" % (source_node_name, template.label())

    template.setName(parm_name)
    template.setLabel(parm_label)

    # Get the current value.
    parm_value = source_tuple.eval()

    target_tuple = target_node.addSpareParmTuple(template)

    # Link the parms.
    for parm, target in zip(source_tuple, target_tuple):
        parm.set(target)
    # Restore the parm value.
    target_tuple.set(parm_value)

    # Clean up the spare parameter if the linked node is destroyed.
    def cleanParm(**kwargs):
        try:
            target_node.removeSpareParmTuple(target_tuple)
        except hou.ObjectWasDeleted:
            pass

    # Clean up the channel reference if the control node is destroyed.
    def cleanRefs(**kwargs):
        try:
            value = target_tuple.eval()
            source_tuple.revertToDefaults()
            source_tuple.set(value)
        except hou.ObjectWasDeleted:
            pass

    # Add event callbacks.
    source_node.addEventCallback((hou.nodeEventType.BeingDeleted,), cleanParm)
    target_node.addEventCallback((hou.nodeEventType.BeingDeleted,), cleanRefs)


def isParmDriven(parm):
    """ Test to see if a parameter is driven by an animation
        channel, expression or CHOP override.
    """
    if parm.keyframes() or parm.overrideTrack():
        return True
    else:
        return False

def getMultiParmInstanceNumber(parm):
    """ Get the instance number from a multi parm parameter. """
    # Parameter needs to be a multi parm instance.
    if not parm.isMultiParmInstance():
        raise hou.OperationFailed("Parameter is not a multi parm parameter.")
    # Use a regular expression to extract the number from the parameter.
    result = re.search("[0-9]*$", parm.name())
    # Convert the result to an integer and return it.
    return int(result.group())


def getCurrentMenuLabel(parm):
    """ Returns the label of the current menu item. """    
    # Get the template for the parameter.
    parm_template = parm.parmTemplate()

    # If this is a regular menu parameter then we just use the value
    # of the parameter to index into the list of menu labels.
    if isinstance(parm_template, hou.MenuParmTemplate):
        return parm_template.menuLabels()[parm.eval()]
    # If this parameter at is a string parm then we can't just use 
    # the value as the index.
    elif isinstance(parm_template, hou.StringParmTemplate):
        # Get the possible string values.
        menu_items = parm_template.menuItems()
        # Get the current string value.
        value = parm.evalAsString()
        # Use the index of the current value in the possible values
        # to index into the labels.
        return parm_template.menuLabels()[menu_items.index(value)]
    # Not a valid parameter type so we throw an exception.
    else:
        raise hou.OperationFailed("Parmeter is not a menu type.")


def driveByRamp(scriptargs, driver_expr="$F/$RFEND"):
    """ Drive a parameter's value(s) using a ramp.
        
        Single parameters are driven by a Float ramp while multiple valued
        parameters are driven by a Color ramp.

        Only Float and Integer parameters can be driven by a ramp by default
        but more types can be added.

        scriptargs: The kwargs dictionary generated for a parameter interaction
                    by the PARMmenu.xml file.

        driver_expr: The default expression to drive the ramp position.
    """

    # Parameter types that can be driven by a ramp.
    allowable_types = (hou.parmTemplateType.Float,
                       hou.parmTemplateType.Int,
                      )

    # Get the parameters.
    parms = scriptargs['parms']

    # If there are more then 3 parms, ie Vector4 then we need to clamp the number to
    # 3 since the most parameters we can drive is 3 with the Color ramp.
    num_parms = len(parms)
    if num_parms > 3:
        num_parms = 3

    # Get the parameter or tuple and the correct ramp type.
    if num_parms == 1:
        parm = parms[0]
        ramp_type = hou.rampParmType.Float
    else:
        parm = parms[0].tuple()
        ramp_type = hou.rampParmType.Color
    
    # Get the parameter type.
    parm_template_type = parm.parmTemplate().type()

    # If the parameter isn't in the allowable types we display a message and abort.
    if parm_template_type not in allowable_types:
        hou.ui.displayMessage("Cannot drive %s parameter type using a ramp." 
                                % parm_template_type.name(),
                              severity=hou.severityType.Error)
        return

    # Get the node we are working on.
    node = parm.node()

    # Create the parameter template for the ramp parm.
    ramp_name = "%s_ramp" % parm.name()
    ramp_label = "%s Ramp" % parm.description()
    ramp_template = hou.RampParmTemplate(ramp_name, ramp_label, ramp_type)

    # Create the parameter template for the ramp position.
    position_name = "%s_position" % ramp_name
    position_label = "%s Position" % ramp_label
    position_template = hou.FloatParmTemplate(position_name, position_label,
                                              1, default_value=([0]), min=0, max=1,
                                              min_is_strict=True, max_is_strict=True)

    # Add the parms to the node.
    position_parm = node.addSpareParmTuple(position_template)
    ramp_parm = node.addSpareParmTuple(ramp_template)

    # Set an expression for the position driver.
    position_parm[0].setExpression(driver_expr)

    # If it is just a single parm then set an expression to point to the ramp.
    if isinstance(parm, hou.Parm):
        parm.setExpression('chramp("%s", ch("%s"), 0)' % (ramp_name, position_name))
    # If there are multiple parameters then set expressions to the correct indices 
    # of the ramp.
    else:
        for p, idx in zip(parm, range(num_parms)):
            p.setExpression('chramp("%s", ch("%s"), %s)' % (ramp_parm.name(), 
                                                            position_name, idx))



def removeRampDriver(scriptargs):
    """ Remove the ramp that is driving a parameter. """
    
    # Get the parameters.
    parms = scriptargs['parms']

    # If there are more then 3 parms, ie Vector4 then we need to clamp the 
    # number to 3 since the most parameters we could have drove is 3 with 
    # the Color ramp.  This ensures that if we have 4 parms that we don't 
    # delete any expression in the last parm.
    num_parms = len(parms)
    if num_parms > 3:
        num_parms = 3

    # Get the parameter or tuple and the correct ramp type.
    if num_parms == 1:
        parm = parms[0]
    else:
        parm = parms[0].tuple()

    parm_name = parm.name()
    node = parm.node()

    # Get the names of the parms to remove.
    ramp_name = "%s_ramp" % parm.name()
    position_name = "%s_position" % ramp_name

    # Get the parameters to remove.
    ramp_parm = node.parmTuple(ramp_name)
    ramp_position_parm = node.parmTuple(position_name)

    # Delete all the expressions.
    if isinstance(parm, hou.Parm):
        parm.deleteAllKeyframes()
    else:
        for p, idx in zip(parm, range(num_parms)):
            p.deleteAllKeyframes()

    # Remove the parameters.
    node.removeSpareParmTuple(ramp_parm)
    node.removeSpareParmTuple(ramp_position_parm)

