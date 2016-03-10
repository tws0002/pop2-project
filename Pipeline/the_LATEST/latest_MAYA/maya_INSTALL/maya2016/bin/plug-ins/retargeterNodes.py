import sys
import maya.cmds as cmds
import maya.OpenMaya as OpenMaya
import maya.OpenMayaMPx as OpenMayaMPx

class CustomRigDefaultMappingNode(OpenMayaMPx.MPxNode):
    # Attributes
    name         = "CustomRigDefaultMappingNode"
    uid          = OpenMaya.MTypeId( 0x580000A0 )
    type         = OpenMaya.MObject()
    coffset      = OpenMaya.MObject()
    offsetx      = OpenMaya.MObject()
    offsety      = OpenMaya.MObject()
    offsetz      = OpenMaya.MObject()
    matrixSource = OpenMaya.MObject()
    destRig      = OpenMaya.MObject()
    destSkel     = OpenMaya.MObject()
    id           = OpenMaya.MObject()
    bodyPart     = OpenMaya.MObject()

    # Static Methods
    @staticmethod
    def creator():
        return OpenMayaMPx.asMPxPtr( CustomRigDefaultMappingNode() )

    @staticmethod
    def initializer():
        attr = OpenMaya.MFnEnumAttribute()
        CustomRigDefaultMappingNode.type = attr.create( "type", "t", 0 )
        attr.addField( "T", 0 )
        attr.addField( "R", 1 )
        attr.setWritable( True )
        attr.setStorable( True )
        attr.setReadable( True )
        attr.setKeyable ( False )
        CustomRigDefaultMappingNode.addAttribute( CustomRigDefaultMappingNode.type )

        attr = OpenMaya.MFnNumericAttribute()
        CustomRigDefaultMappingNode.offsetx = attr.create( "offsetX", "ox", OpenMaya.MFnNumericData.kFloat, 0.0 )
        attr.setWritable( True )
        attr.setStorable( True )
        attr.setReadable( True )
        attr.setKeyable ( False )

        attr = OpenMaya.MFnNumericAttribute()
        CustomRigDefaultMappingNode.offsety = attr.create( "offsetY", "oy", OpenMaya.MFnNumericData.kFloat, 0.0 )
        attr.setWritable( True )
        attr.setStorable( True )
        attr.setReadable( True )
        attr.setKeyable ( False )

        attr = OpenMaya.MFnNumericAttribute()
        CustomRigDefaultMappingNode.offsetz = attr.create( "offsetZ", "oz", OpenMaya.MFnNumericData.kFloat, 0.0 )
        attr.setWritable( True )
        attr.setStorable( True )
        attr.setReadable( True )
        attr.setKeyable ( False )

        attr = OpenMaya.MFnCompoundAttribute()
        CustomRigDefaultMappingNode.coffset = attr.create( "offset", "o" )
        attr.addChild( CustomRigDefaultMappingNode.offsetx )
        attr.addChild( CustomRigDefaultMappingNode.offsety )
        attr.addChild( CustomRigDefaultMappingNode.offsetz )
        CustomRigDefaultMappingNode.addAttribute( CustomRigDefaultMappingNode.coffset )

        attr = OpenMaya.MFnNumericAttribute()
        CustomRigDefaultMappingNode.id = attr.create( "identifier", "id", OpenMaya.MFnNumericData.kInt, -1 )
        attr.setWritable( True )
        attr.setStorable( True )
        attr.setReadable( True )
        attr.setKeyable ( False )
        CustomRigDefaultMappingNode.addAttribute( CustomRigDefaultMappingNode.id )

        attr = OpenMaya.MFnMatrixAttribute()
        CustomRigDefaultMappingNode.matrixSource = attr.create( "matrixSource", "ms" )
        attr.setWritable( True )
        attr.setReadable( True )
        attr.setStorable( True )
        attr.setHidden( True )
        CustomRigDefaultMappingNode.addAttribute( CustomRigDefaultMappingNode.matrixSource )

        attr = OpenMaya.MFnMessageAttribute()
        CustomRigDefaultMappingNode.destRig = attr.create( "destinationRig", "dr" )
        attr.setWritable( True )
        attr.setReadable( True )
        attr.setStorable( True )
        attr.setHidden( True )
        CustomRigDefaultMappingNode.addAttribute( CustomRigDefaultMappingNode.destRig )

        attr = OpenMaya.MFnMessageAttribute()
        CustomRigDefaultMappingNode.destSkel = attr.create( "destinationSkeleton", "ds" )
        attr.setWritable( True )
        attr.setReadable( True )
        attr.setStorable( True )
        attr.setHidden( True )
        CustomRigDefaultMappingNode.addAttribute( CustomRigDefaultMappingNode.destSkel )

        attr = OpenMaya.MFnTypedAttribute()
        CustomRigDefaultMappingNode.bodyPart = attr.create( "bodyPart", "bp", OpenMaya.MFnData.kString )
        attr.setWritable( True )
        attr.setReadable( True )
        attr.setStorable( True )
        attr.setHidden( True )
        CustomRigDefaultMappingNode.addAttribute( CustomRigDefaultMappingNode.bodyPart )

    # Public Methods
    def __init__( self ):
        OpenMayaMPx.MPxNode.__init__( self )


class CustomRigRetargeterNode(OpenMayaMPx.MPxNode):
    # Attributes
    name         = "CustomRigRetargeterNode"
    uid          = OpenMaya.MTypeId( 0x580000A1 )
    connected    = OpenMaya.MObject()
    source       = OpenMaya.MObject()
    destination  = OpenMaya.MObject()
    mappings     = OpenMaya.MObject()
    pythonvar    = OpenMaya.MObject()

    # Static Methods
    @staticmethod
    def creator():
        return OpenMayaMPx.asMPxPtr( CustomRigRetargeterNode() )

    @staticmethod
    def initializer():
        attr = OpenMaya.MFnNumericAttribute()
        CustomRigRetargeterNode.connected = attr.create( "connected", "c", OpenMaya.MFnNumericData.kInt, 0.0 )
        attr.setWritable( True )
        attr.setStorable( True )
        attr.setReadable( True )
        attr.setKeyable ( False )
        CustomRigRetargeterNode.addAttribute( CustomRigRetargeterNode.connected )

        attr = OpenMaya.MFnMessageAttribute()
        CustomRigRetargeterNode.source = attr.create( "source", "s" )
        attr.setWritable( True )
        attr.setReadable( True )
        attr.setStorable( True )
        attr.setHidden( True )
        CustomRigRetargeterNode.addAttribute( CustomRigRetargeterNode.source )

        attr = OpenMaya.MFnMessageAttribute()
        CustomRigRetargeterNode.destination = attr.create( "destination", "d" )
        attr.setWritable( True )
        attr.setReadable( True )
        attr.setStorable( True )
        attr.setHidden( True )
        CustomRigRetargeterNode.addAttribute( CustomRigRetargeterNode.destination )
    
        attr = OpenMaya.MFnMessageAttribute()
        CustomRigRetargeterNode.mappings = attr.create( "mappings", "ms" )
        attr.setWritable( True )
        attr.setReadable( True )
        attr.setStorable( True )
        attr.setHidden( True )
        attr.setArray( True )
        CustomRigRetargeterNode.addAttribute( CustomRigRetargeterNode.mappings )
        attr = OpenMaya.MFnTypedAttribute()
        
        CustomRigRetargeterNode.pythonvar = attr.create( "pythonVar", "pv", OpenMaya.MFnData.kString )
        attr.setWritable( True )
        attr.setReadable( True )
        attr.setStorable( True )
        attr.setHidden( True )
        CustomRigRetargeterNode.addAttribute( CustomRigRetargeterNode.pythonvar )

    # Public Methods
    def __init__( self ):
        OpenMayaMPx.MPxNode.__init__( self )

def register( mplugin, node ):
    """ Helper function to register node in plugin """
    try:
        mplugin.registerNode( node.name, node.uid, node.creator, node.initializer )
    except:
        sys.stderr.write( "Failed to register node: %s" % node.name )
        raise

def unregister( mplugin, node ):
    """ Helper fnction to unregister node in plugin """
    try:
        mplugin.deregisterNode( node.uid )
    except:
        sys.stderr.write( "Failed to unregister node: %s" % node.name )
        raise

def initializePlugin( mobject ):
    """ Load the plugin and register defined classes """
    mplugin = OpenMayaMPx.MFnPlugin( mobject, "Autodesk", "1.0" )
    register( mplugin, CustomRigDefaultMappingNode )
    register( mplugin, CustomRigRetargeterNode )

def uninitializePlugin( mobject ):
    """ Unload the plugin and unregister defined classes """
    mplugin = OpenMayaMPx.MFnPlugin( mobject )
    unregister( mplugin, CustomRigDefaultMappingNode )
    unregister( mplugin, CustomRigRetargeterNode )
