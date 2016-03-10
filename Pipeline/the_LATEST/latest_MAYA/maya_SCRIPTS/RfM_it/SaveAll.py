import it, time, os
from it.It3Command import It3Command
from PythonQt.QtGui import QDialogButtonBox
from PythonQt.QtGui import QHBoxLayout
from PythonQt.QtGui import QVBoxLayout
from PythonQt.QtGui import QComboBox

class SaveAll(It3Command):
	def __init__(self):
		self.m_menuPath = 'Commands/Save All...'
		self.m_dialog = None
		self.m_stdButtons = QDialogButtonBox.Apply|QDialogButtonBox.Cancel
		
	def Invoke(self):
		if self.m_dialog == None:
			self.m_dialog = self.makeUI()
		self.m_dialog.show()
		self.m_dialog.raise_()
		self.m_dialog.activateWindow()
				
	def doit(self):
		gamma = float(self.m_gamma.currentText)
		quality = float(self.m_quality.currentText) * 100.0
		host_dir = self.saveAll(gamma, quality)
		it.app.Info('Images saved to "%s"' % host_dir)
		it.app.RaiseLogWindow()
		
	def makeUI(self):
		dlg = self.CreateDialog('Save All')
		contents = dlg.findChild(QVBoxLayout, 'contents')

		layout = QHBoxLayout()
		contents.addLayout(layout)
		label_gamma = QLabel("Gamma ")
		layout.addWidget(label_gamma)
		
		self.m_gamma = QComboBox()
		self.m_gamma.addItems(['1.0','1.8','2.0','2.2'])
		self.m_gamma.setCurrentIndex(3)
		layout.addWidget(self.m_gamma)

		layout = QHBoxLayout()
		contents.addLayout(layout)
		label_quality = QLabel("Quality ")
		layout.addWidget(label_quality)
		
		self.m_quality = QComboBox()
		self.m_quality.addItems(['0.5','0.75','1.0'])
		self.m_quality.setCurrentIndex(2)
		layout.addWidget(self.m_quality)

		bbox = dlg.findChild(QDialogButtonBox, 'bbox')
		doItButton = bbox.button(QDialogButtonBox.Apply)
		doItButton.setText('Save All')
		doItButton.connect('clicked()', self.doit)
		return dlg
			
	def saveAll(self, gamma=1.0, quality=100):
		localtime = time.asctime( time.localtime(time.time()) )
		localtime = localtime.replace(' ', '_')
		localtime = localtime.replace(':', '_')	
		outname = 'catalog_%s' % localtime
		cwdpath = os.getcwd()
		if len(cwdpath) < 3:
			cwdpath = os.environ['HOME']
			if len(cwdpath) < 3:	
				it.app.Error('Unable to determine the current working directory.')
				it.app.Error('Unable to save the images.')
				it.app.RaiseLogWindow()
				return	
		out_dirpath = os.path.join(cwdpath,outname)
		if not os.path.exists(out_dirpath):
			os.mkdir(out_dirpath)
		aovDict = {}
		cat = it.app.GetCurrentCatalog()
		img_counter = 1
		for i in range (0, cat.GetChildCount()):
			element = cat.GetChild(i)
			imgname = it.os.path.basename( element.GetFilename() )
			if imgname == '_preview':
				continue
			# Add a padded numeric extension
			imgname = imgname + ('.%04d' % img_counter) + '.jpg'
			out_imgpath = os.path.join(out_dirpath, imgname)
			self.saveImage(element, out_imgpath, gamma, quality)
			img_counter += 1
			
			# Save any AOV's
			for j in range (0, element.GetChildCount()):
				aov = element.GetChild(j)
				aovname = it.os.path.basename( aov.GetFilename() )
				# Remove the extension
				aovname = os.path.splitext(aovname)[0]
				# Maintain unique counters for each AOV
				aov_counter = 1
				if aovDict.has_key(aovname):
					aov_counter = aovDict[aovname]
					aov_counter += 1;
				aovDict[aovname] = aov_counter
				
				# Add a padded numeric extension
				aovname = aovname + ('.%04d' % aov_counter) + '.jpg'
				out_aovpath = os.path.join(out_dirpath, aovname)
				self.saveImage(aov, out_aovpath, gamma, quality)
		return cwdpath
	def saveImage(self, element,path,gamma,quality):
		image = element.GetImage()
		image = image.Gamma(gamma);
		image.SetMetaDataItem('JPEG_QUALITY', quality)
		image.Save(path, ice.constants.FMT_JPEG)		
it.commands.append(SaveAll)
