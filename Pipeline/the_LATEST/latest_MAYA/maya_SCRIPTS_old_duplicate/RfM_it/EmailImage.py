import it, time, os, smtplib, ice
from it.It3Command import It3Command
from PythonQt.QtGui import QDialogButtonBox
from PythonQt.QtGui import QHBoxLayout
from PythonQt.QtGui import QVBoxLayout
from PythonQt.QtGui import QLineEdit
from PythonQt.QtGui import QFrame
from PythonQt.QtGui import QTabWidget
from PythonQt.QtGui import QWidget
from PythonQt.QtGui import QLayout
from PythonQt.QtGui import QSizePolicy
from PythonQt import QtCore

from email.mime.image import MIMEImage
from email.mime.text import MIMEText
from email.MIMEBase import MIMEBase 
from email.mime.multipart import MIMEMultipart
from email import Encoders 

class EmailImage(It3Command):
	DEFAULT_SENDER = 'YOUR_EMAIL_ADDRESS'
	DEFAULT_RECIPIENT = 'THEIR_EMAIL_ADDRESS'
	DEFAULT_SMTP = 'smtp.gmail.com'
	DEFAULT_PORT = '587'
	
	def __init__(self):
		self.m_menuPath = 'Commands/Email Image...'
		self.m_dialog = None
		self.m_stdButtons = QDialogButtonBox.Apply|QDialogButtonBox.Cancel
		
	def Invoke(self):
		if self.m_dialog == None:
			self.m_dialog = self.makeUI()
		self.m_dialog.show()
		self.m_dialog.raise_()
		self.m_dialog.activateWindow()

	def makeUI(self):
		dlg = self.CreateDialog('Email Image')
		contents = dlg.findChild(QVBoxLayout, 'contents')
		contents.addSpacing(-10)
		contents.setAlignment(QtCore.Qt.AlignTop)
		# Turn off the resizing of the dialog
		dlg.setSizeGripEnabled(False)
		dlg.setSizePolicy(QSizePolicy.Fixed, QSizePolicy.Fixed)
		
		# Setup the tabs______________________________________
		tabs = QTabWidget()
		contents.addWidget(tabs)
	
		user_tab = QWidget()
		user_layout	= QVBoxLayout()
		user_layout.setSpacing(5)
		user_tab.setLayout(user_layout)
		
		recip_tab = QWidget()
		recip_layout = QVBoxLayout()
		recip_layout.setSpacing(5)
		recip_tab.setLayout(recip_layout)
		recip_layout.setAlignment(QtCore.Qt.AlignTop)
		
		tabs.addTab(user_tab,  'Sign In')
		tabs.addTab(recip_tab, 'Recipient')
		
		# Add to the 'Sign In' tab____________________________
		self.smtpTF = self.addTextField(user_layout, 'SMTP:  ', EmailImage.DEFAULT_SMTP, 150)
		self.portTF = self.addTextField(user_layout, 'Port:',   EmailImage.DEFAULT_PORT, 50)
		self.fromTF = self.addTextField(user_layout, 'Email:',   EmailImage.DEFAULT_SENDER, 150)
		self.passTF = self.addTextField(user_layout, 'Password:', '', 150, QLineEdit.Password)
		
		# Add to the 'Recipient' tab___________________________
		self.toTF   = self.addTextField(recip_layout, 'Send To:    ', EmailImage.DEFAULT_RECIPIENT, 150)
		self.noteTF = self.addTextField(recip_layout, 'Notes', '', 150)
		
		# Take care of the default buttons_____________________
		bbox = dlg.findChild(QDialogButtonBox, 'bbox')
		doItButton = bbox.button(QDialogButtonBox.Apply)
		doItButton.setText('Send')
		doItButton.connect('clicked()', self.doit)
		return dlg
		
	# Makes a labelled textfield (QLineEdit) and returns a reference to field. 
	def addTextField(self, parent, label, text, width,echo_mode=QLineEdit.Normal):
		layout = QHBoxLayout()
		layout.setAlignment(QtCore.Qt.AlignLeft)
		parent.addLayout(layout)
		label = QLabel(label)
		label.setFixedWidth(50)
		layout.addWidget(label)
		field = QLineEdit()
		field.setFixedWidth(width)
		field.setText(text)
		field.echoMode = echo_mode
		layout.addWidget(field)
		return field
				
	# Called by the 'Send' button
	def doit(self):
		# Find a location where we can save a temporary jpg image
		cwdpath = os.getcwd()
		if len(cwdpath) < 3:
			cwdpath = os.environ['HOME']
			if len(cwdpath) < 3:	
				it.app.Error('Unable to determine the current working directory (CWD).')
				it.app.Error('The image cannot be saved and, therefore, cannot be emailed.')
				it.app.RaiseLogWindow()
				return
		# Do we have a valid catalog image
		try:
			elem = it.GetCurrentElement()
		except:
			it.app.Warning('Cannot find a catalog image to send.')
			it.app.RaiseLogWindow()
			return
			
		# Save the IceMan image as a jpg_______________________
		imgname = it.os.path.basename( elem.GetFilename() )
		if imgname.endswith('.jpg') == False:
			imgname += '.jpg'
		imagePath = os.path.join(cwdpath,imgname)
		self.saveImage(elem, imagePath, 2.2, 100)
		it.app.Info('Saved a temporary image as "%s"' % imagePath)

		# Prepare the email____________________________________
		msg = MIMEMultipart()
		msg['Subject'] = imgname
		msg['From'] = self.fromTF.text
		msg['To'] =  self.toTF.text
		part = MIMEBase('application', "octet-stream")
		
		# Read the jpg data, then delete the image file
		fp = open(imagePath, 'rb')
		part.set_payload(fp.read())
		fp.close()
		os.remove(imagePath)
		# Encode the attachment
		Encoders.encode_base64(part)
		part.add_header('Content-Disposition','attachment; filename="%s"' % imgname)
		msg.attach(part)

		if len(self.noteTF.text.strip()) > 0:
			msg.attach(MIMEText(self.noteTF.text, 'plain'))
		else:
			msg.attach(MIMEText('Rendered image from PRMan', 'plain'))
		# Send via the SMTP server
		server = smtplib.SMTP(self.smtpTF.text, int(self.portTF.text))
		server.ehlo()
		server.starttls()
		server.ehlo()
		server.login( msg['From'], self.passTF.text)
		server.sendmail( msg['From'], msg['To'] , msg.as_string())
		server.close()
		it.app.Info('Image has been sent')
		
	def saveImage(self, element, path, gamma, quality):
	    image = element.GetImage()
	    image = image.Gamma(gamma);
	    image.SetMetaDataItem('JPEG_QUALITY', quality)
	    image.Save(path, ice.constants.FMT_JPEG)
		
# Add the new menu item
it.commands.append(EmailImage)


