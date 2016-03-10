#!/usr/bin/env python
# -*- coding: iso-8859-1 -*-

""" precomp module API. """

#-------------------------------------------------------------------------------
# Global functions

def getAppName():
    """ Returns application name in unicode. """
    return appName

def getAppVersionStr():
    """ Returns application version string in unicode. """
    return appVersionStr

def getAppMajorVersion():
    """ Returns application major version number, as an integer. """
    return appMajorVersion

def getAppMinorVersion():
    """ Returns application minor version number, as an integer. """
    return appMinorVersion

def getPrecompModuleMajorVersion():
    """ Returns precomp module major version number, as an integer. """
    return precompModuleMajorVersion

def getPrecompModuleMinorVersion():
    """ Returns precomp module minor version number, as an integer. """
    return precompModuleMinorVersion

def getDestinationFolder():
    """ Returns a unicode path, absolute or relative to the Toxik project, 
    to a folder where all compositions must be created/updated. """
    return destinationFolder

def getScene():
    """ Returns a Scene instance representing the 3D scene in this precomp
    module. """
    return scene

#-------------------------------------------------------------------------------
#
class Scene:
    """ Class representing a 3D scene. """

    def getName(self):
        """ Returns the name of the scene, as a unicode string. """
        return self.name

    def getAnchor(self):
        """ Returns the scene anchor, as a unicode string. """
        return self.anchor
        
    def getVersion(self):
        """ Returns the version number of the scene, as an integer. """
        return self.version
    
    def getDescription(self):
        """ Returns the scene description, possibly empty, as a unicode string.
        """
        return self.description
    
    def getNote(self):
        """ Returns a note about the scene, possibly empty, as a unicode string.
        """
        return self.note
    
    def getRenderWidth(self):
        """ Returns the default render resolution width used in the scene, as an
        integer. """
        return self.renderWidth
    
    def getRenderHeight(self):
        """ Returns the default render resolution height used in the scene, as
        an integer. """
        return self.renderHeight
    
    def getRenderPixelRatio(self):
        """ Returns the default render pixel aspect ratio used in the scene, as
        a float. """
        return self.renderPixelRatio
    
    def getRate(self):
        """ Returns the rate of the scene (time units), as a float. """
        return self.rate

    def getRenderDirectory(self):
        """ Returns the root directory under which all render pass image files
        are produced, as an absolute unicode path. Render pass image files are
        typically classified within subdirectories under that render directory.
        """
        return self.renderDirectory
    
    def getRenderCameras(self):
        """ Returns the list of "renderable" cameras in the scene. Each item in
        the list is a list of RenderCamera instances. A camera list of
        cardinality greater than two represents a camera set (2 to N)
        (for example, right and left cameras of a stereoscopic view). """
        return self.renderCameras
    
#-------------------------------------------------------------------------------
#
class RenderCamera:
    """ Class representing a render camera. """
    
    def getName(self):
        """ Returns the camera display name, as a unicode string. The camera
        name should be unique within the scene. """
        return self.name
    
    def getAnchor(self):
        """ Returns the camera anchor, as a unicode string. The camera anchor
        should be unique within the scene. When rendered to multi-channel files,
        the camera anchor is used to name the file channel:
        "RenderPassAnchor.RenderCameraAnchor.Channel". """
        return self.anchor
    
    def getVersion(self):
        """ Returns the version number of the camera, as an integer. """
        return self.version
    
    def getDescription(self):
        """ Returns the camera description, possibly empty, as a unicode string.
        """
        return self.description
    
    def getNote(self):
        """ Returns a note about the camera, possibly empty, as a unicode
        string. """
        return self.note
    
    def getTemplateFilePath(self):
        """ Returns the absolute path (in unicode) to a ".txcomposition" file
        to use as a template to create the camera comp, or None. Note that
        cameras that belong to a camera set should provide the same template.
        """
        return self.templateFilePath
    
    def isSelectedForImport(self):
        """ Returns a boolean indicating whether this camera should be imported
        by default. """
        return self.selectedForImport
    
    def getRenderLayers(self):
        """ Returns a list of layers which are rendered through this camera,
        as RenderLayer instances. """
        return self.renderLayers

#-------------------------------------------------------------------------------
#
class RenderLayer:
    """ Class representing a render layer, i.e. an assembly of layer passes
    rendered through a specific camera. In other words, a RenderLayer instance
    is bound to a specific RenderCamera instance. """

    class BlendMode:
        """ Class enumerating possible blend modes between render layers.
        The BlendMode members can be set to anything (string, integer, etc),
        as long as they are different from each other.
        """
        Normal         = 0
        Average        = 1
        Add            = 2
        Subtract       = 3
        Darken         = 4
        Multiply       = 5
        ColorBurn      = 6
        LinearBurn     = 7
        Lighten        = 8
        Screen         = 9
        ColorDodge     = 10
        LinearDodge    = 11
        Spotlight      = 12
        SpotlightBlend = 13
        Overlay        = 14
        SoftLight      = 15
        HardLight      = 16
        PinLight       = 17
        HardMix        = 18
        Difference     = 19
        Exclusion      = 20
        Hue            = 21
        Saturation     = 22
        Color          = 23
        Value          = 24
                   
    def getName(self):
        """ Returns the render layer display name, as a unicode string.
        The render layer name should be unique within the scene. """
        return self.name
    
    def getAnchor(self):
        """ Returns the render layer anchor, as a unicode string.
        The render layer anchor should be unique within the scene. """
        return self.anchor
    
    def getVersion(self):
        """ Returns the version number of the render layer, as an integer. """
        return self.version
    
    def getDescription(self):
        """ Returns the render layer description, possibly empty, as a unicode
        string. """
        return self.description
    
    def getNote(self):
        """ Returns a note about the render layer, possibly empty, as a unicode
        string. """
        return self.note
    
    def getCompositingOrder(self):
        """ Returns an integer that defines the absolute position (1-based) of
        the render layer in the layer stack. A smaller display order means the
        render layer is toward the bottom of the stack (on the back plate).
        """
        return self.compositingOrder
    
    def getBlendMode(self):
        """ Gets the blend mode used to comp this render layer with the render
        layer beneath it. Returns one of the BlendMode class members. """
        return self.blendMode
    
    def getRenderWidth(self):
        """ Returns the render resolution width used by this layer, as an
        integer. """
        return self.renderWidth
    
    def getRenderHeight(self):
        """ Returns the render resolution height used by this layer, as an
        integer. """
        return self.renderHeight
    
    def getRenderPixelRatio(self):
        """ Returns the render pixel ratio used by this layer, as a float. """
        return self.renderPixelRatio
    
    def getTemplateFilePath(self):
        """ Returns the absolute path (in unicode) to a ".txcomposition" file
        to use as a template to create the render layer comp, or None.
        Note that render layers produced by cameras of a camera set should
        provide the same template. """
        return self.templateFilePath
           
    def isSelectedForImport(self):
        """ Returns a boolean indicating whether this render layer should be
        imported by default. """
        return self.selectedForImport
    
    def getRenderPasses(self):
        """ Return a list of render passes (RenderPass instances) in this render
        layer which are contributing to a render from a specific camera. """
        return self.renderPasses
        
#-------------------------------------------------------------------------------
#
class RenderPass:
    """ Class representing a render pass, i.e. the pass of a specific layer
    rendered through a specific camera. In other words, a RenderPass instance
    is bound to a specific RenderLayer instance, and consequently, by definition
    of the RenderLayer class, to a specific RenderCamera instance.
    """
       
    def getName(self):
        """ Returns the render pass display name, as a unicode string. The
        render pass name should be unique within the scene. """
        return self.name
    
    def getAnchor(self):
        """ Returns the render pass anchor, as a unicode string. The render pass
        anchor should be unique within the scene. When rendered to multi-channel
        files, the render pass anchor is used to name the file channel:
        "RenderPassAnchor.RenderCameraAnchor.Channel". """
        return self.anchor
    
    def getVersion(self):
        """ Returns the version number of the render pass, as an integer. """
        return self.version
    
    def getDescription(self):
        """ Returns the render pass description, possibly empty, as a unicode
        string. """
        return self.description
    
    def getNote(self):
        """ Returns a note about the render pass, possibly empty, as a unicode
        string. """
        return self.note
    
    def getFileSequencePath(self):
        """ Returns the absolute path (unicode) of the file sequence for this
        render pass. If the sequence is not single frame, the returned file name
        will have a special token in it to indicate where the frame index is
        located; see getFrameIndexToken(). """
        return self.fileSequencePath
    
    def getFrameIndexToken(self):
        """ Returns the special token (unicode string) used to replace the frame
        index in the path returned by getFileSequencePath(). """
        return u"<#>"
    
    def isSingleFrame(self):
        """ Returns a boolean indicating whether the render of this pass is a
        single file that doesn't have a frame index in its name. """
        return self.singleFrame
    
    def getFrameRange(self):
        """ Returns a tuple specifying the start and end frames of the rendered
        file sequence for this pass, as integers (taking frame renumbering into
        account if applicable). The end frame is inclusive. """
        return self.frameRange
    
    def getFrameIndexPadding(self):
        """ Returns an integer specifying the frame index padding used in file
        names rendered from this pass. """
        return self.frameIndexPadding
    
    def isFileSequenceMultiChannel(self):
        """ Returns a boolean indicating whether the rendered files for this
        pass contain multiple channels (other than the standard RGBA channels).
        """
        return self.multiChannel

    def getFileChannelViewName(self):
        """ Returns the name of the channels group in which the render pass 
        channels are stored, when rendered to a multi-channel file, as a
        unicode string. The channels group, followed by a dot, prefixes the
        image channel name in the file channel name. For example, if the
        channels group name was 'DirectIrradiance.LeftCam' the name of the red
        channel in the file would be 'DirectIrradiance.LeftCam.R'."""
        return self.channelViewName
            
    def getRenderWidth(self):
        """ Returns the render resolution width used for this pass, as an
        integer. """
        return self.renderWidth
    
    def getRenderHeight(self):
        """ Returns the render resolution height used for this pass, as an
        integer. """
        return self.renderHeight
    
    def getRenderPixelRatio(self):
        """ Returns the render pixel ratio used for this pass, as a float. """
        return self.renderPixelRatio
    
    def getRenderNbChannels(self):
        """ Returns the number of channels in the rendered images, as an
        integer. Supported number of channels are 1, 3 and 4. """
        return self.renderNbChannels
    
    def getRenderDepth(self):
        """ Returns the bit depth of the rendered images, as an integer.
        Supported depth values are 8, 16 and 32. """
        return self.renderDepth
    
    def isRenderPremultiplied(self):
        """ Returns a boolean indicating whether the render pass images are
        premultiplied. """
        return self.premultiplied
    
    def getRenderPremultiplyBgColor(self):
        """ Returns the RGB float triplet used to premultiply the render pass
        images. """
        return self.premultiplyBgColor
        
    def isSelectedForImport(self):
        """ Returns a boolean indicating whether this render pass should be
        imported by default. """
        return self.selectedForImport
