import maya.OpenMaya as om
import maya.cmds as cmds

"""Reference: http://stackoverflow.com/questions/31647878/customize-mayas-addcheckcallback-pop-up-message"""

def func(retCode, clientData):
    """Cancel save if there is a pSphere1 in the scene"""

    objExist = cmds.objExists('pSphere1')

    string_key = "s_TfileIOStrings.rFileOpCancelledByUser"
    string_default = "File operation cancelled by user supplied callback."
    string_error = "There is a pSphere1 node in your scene"

    message = string_error if objExist else string_default
    cmds.displayString(string_key, replace=True, value=message)

    om.MScriptUtil.setBool(retCode, (not objExist))


cb_id = om.MSceneMessage.addCheckCallback(om.MSceneMessage.kBeforeSaveCheck, func)