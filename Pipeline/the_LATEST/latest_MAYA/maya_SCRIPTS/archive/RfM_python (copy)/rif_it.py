import prman, os

class Rif(prman.Rif):
	def __init__(self, ri):
		prman.Rif.__init__(self, ri)
	def Display(self, name, driver, channels, params):
		if driver != 'shadow' and driver != 'deepshad' and driver != 'null':
			driver = 'it'
		self.m_ri.Display(name, driver, channels, params)

	
