import prman, os

class Rif(prman.Rif):
	def Display(self, name, driver, channels, params):
		if driver != 'shadow' and driver != 'deepshad' and driver != 'null':
			driver = 'deepshad'
			name = os.path.splitext(name)[0]
			name = name + '.dtex'
			self.m_ri.Display(name, driver, channels)
		else:
			self.m_ri.Display(name, driver, channels, params)

	
