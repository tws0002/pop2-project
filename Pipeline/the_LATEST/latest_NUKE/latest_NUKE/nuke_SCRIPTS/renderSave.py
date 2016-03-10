import nuke, os, time, shutil

_oldCommand = nuke.executeMultiple

def myExecuteMultiple(*args):
	
	if nuke.root().modified():
		nuke.scriptSave()
	fromPath, fromName = os.path.split(nuke.root().name())

	possibleNodes = args[0]	
	nodes = []
	succes = _oldCommand(*args)
	if sucess:
		rTime = '_%02d_%02d_%02d_%02d%02d%02d' % (time.localtime()[1], time.localtime()[2], int(str(time.localtime()[0])[-2:]), time.localtime()[3], time.localtime()[4], time.localtime()[5]) 
		if possibleNodes[0].Class() == 'Root':
			nodes = [i for i in possibleNodes[0].nodes() if i.Class() == 'Write']
		elif possibleNodes[0].Class() == 'Group':
			nodes = [i for i in possibleNodes[0].nodes() if i.Class() == 'Write']
		elif possibleNodes[0].Class() == 'Write':
			nodes = [i for i in possibleNodes if i.Class() == 'Write']
		else:
			raise TypeError
		
		for node in nodes:
			toPath = os.path.split(node.knob('file').value())[0]
			toName = os.path.splitext(fromName)[0] + rTime + os.path.splitext(fromName)[1]
			shutil.copy2(os.path.join(fromPath, fromName), os.path.join(toPath, toName))

