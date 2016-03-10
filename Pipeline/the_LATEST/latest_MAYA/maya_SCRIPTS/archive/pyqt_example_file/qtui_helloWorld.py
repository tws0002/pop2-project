import sys, os
sys.path.append("C:\Users\ckenne24\Downloads\PyQt4_win")
from PyQt4 import QtGui, QtCore, uic

DIRPATH = os.path.join(os.path.dirname(os.path.abspath(__file__)))

class Window(QtGui.QWidget):
    def __init__(self):
        QtGui.QWidget.__init__(self)
        uic.loadUi(os.path.join(DIRPATH, 'qtui_helloWorld.ui'), self)
        self.button.clicked.connect(self.handleButton)

    def handleButton(self):
        print('Hello World')

if __name__ == '__main__':

    app = QtGui.QApplication(sys.argv)
    window = Window()
    window.show()
    sys.exit(app.exec_())