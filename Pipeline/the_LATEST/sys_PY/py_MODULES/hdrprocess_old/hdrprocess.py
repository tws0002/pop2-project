#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
The main module that runs the GUI or the command-line, depending on what values
were pass
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import argparse
import multiprocessing
import shutil

# IMPORT THIRD-PARTY LIBRARIES
try:
    import PyQt.QtCore as QtCore
    import PyQt.QtGui as QtGui
except ImportError:
    import PySide.QtCore as QtCore
    import PySide.QtGui as QtGui
except:
    raise

# IMPORT LOCAL LIBRARIES
import commons.view.guiwidgets as guiwidgets
import fileio.controller.paths as paths
import controller.engine as engine
import view.mainWindow as mainWindow


CURRENT_DIR = os.path.dirname(os.path.realpath(__file__))


class CmdTool:
    """
    Stores basic configuration about the current tool in a single place
    """
    def __init__(self, *args):
        # optionalArgs = dict((k, v) for k, v in optionalArgs.iteritems() if v)
        self.args = args  # keep a list of the original args
        self.requiredArgKeys = ["seqInterval", "inputs"]
        self.init_args()
    # end __init__

    def init_args(self):
        """
        Convenience method to help sort required arguments from optional ones
        """
        optionalArgs = dict((k, v) for k, v
                            in self.args.iteritems() if v is not None and v is not False)

        tempRequired = [x.lower() for x in self.requiredArgKeys]
        self.requiredArgs = {k: optionalArgs[k] for k, v in optionalArgs.iteritems() \
                             if k.lower() in tempRequired}
        for requiredArg in self.requiredArgKeys:
            optionalArgs.pop(requiredArg, None)

        # config a couple settings in the list of arguments
        optionalArgs['threads'] = optionalArgs.get("threads", 1)
        optionalArgs["ec"] = optionalArgs.get("ec", False)
        self.optionalArgs = optionalArgs
    # end init_args

    def __repr__(self):
        """
        Object statement of current class
        """
        return '<{cls}.{name}("args"={args!r}) object at '\
               '{hexI}'.format(cls=self.__class__,
                               name=self.__class__.__name__,
                               args=self.args,
                               hexI=hex(id(self)))
    # end __repr__
# end CmdTool


class Window(QtGui.QMainWindow, mainWindow.Ui_MainWindow):
    def __init__(self, parent=None):
        super(Window, self).__init__(parent)
        # super(Window, self).__init__(parent)
        self.fnumDefault = 1.8
        # fnum values taken from wiki page: https://en.wikipedia.org/wiki/F-number
        self.fnumOptions = [0.5, 0.7, 1.0, 1.4, 2, 2.8, 4, 5.6, 8, 11, 16, 22,
                            32, 45, 64, 90, 128, 180, 256]
        self.curveInputDir = os.path.join(CURRENT_DIR, "model")
        self.maxThreadCount = multiprocessing.cpu_count()
        self.outputType = ".hdr"
        self.setupUi(self)
        self.init_ui()
        self.trigger()
    # end __init__

    def init_ui(self):
        """
        Initializes the UI window
        """
        # get basic main config settings
        self.threads_sb.setValue(self.maxThreadCount)
        self.autoRenameFiles_cb.setChecked(True)
        self.curveInput_cb.addItem
        self.defaultCurve_cb.setChecked(True)
        self.seqInterval_sb.setProperty("value", 5)
        self.fnum_cb.setProperty("value", self.fnumDefault)
        self.colorBalancing_cb.setChecked(True)
        self.exposureCorrection_cb.setChecked(True)
        self.use32bitIEE_cb.setChecked(True)
        self.init_curve_inputs()

        for fnum in self.fnumOptions:
            self.fnum_cb.addItem(str(fnum))
        index = self.fnum_cb.findText("1.4", QtCore.Qt.MatchFixedString)
        if index >= 0:
            self.fnum_cb.setCurrentIndex(index)
        self.outputType_le.setText(self.outputType)
        # self.outputLogger_te.setText()
        self.outputLogger_pb.setValue(0)
        self.outputLogger_pb.hide()
        self.outputLogger_te.setReadOnly(True)

        # add first row for selecting HDRs
        self.itemRow = guiwidgets.CombinedRow(self)
        self.itemRow.lineEdit.setText("Select lists of HDRs or txt files")
        self.gridLayout.addLayout(self.itemRow, 29, 0, 1, 8)
    # end init_ui

    def init_curve_inputs(self, fileSuffix=".crv"):
        """
        Creates the options for the curve input
        """
        self.curveInput_cb.clear()
        self.curveInput_cb.addItem("")
        for f in os.listdir(self.curveInputDir):
            if f.lower().endswith(fileSuffix):
                self.curveInput_cb.addItem(f)
    # end init_curve_inputs

    def trigger(self):
        """
        Define the interactivity of the GUI
        """

        self.automaticSeq_cb.stateChanged.connect(self.auto_sequence_interval)
        self.manual_fnum_cb.stateChanged.connect(self.exchange_fnum_widget)
        # self.curveInput_cb.stateChanged.connect(self.curve_input_blank_status)
        # self.curveInput_cb.stateChanged.connect(curveInputIsBlank)
        self.connect(self.curveInput_cb,
                     QtCore.SIGNAL("currentIndexChanged(const QString&)"),
                     self.curve_input_blank_status)

        self.curveInput_tb.clicked.connect(self.browse_curve_file)
        self.estimateCurve_cb.stateChanged.connect(self.estimate_curve_checked)
        self.defaultCurve_cb.stateChanged.connect(self.default_curve_checked)
        self.okCancel_bb.accepted.connect(self.accept)
        self.okCancel_bb.rejected.connect(self.reject)

        QtGui.QShortcut(QtGui.QKeySequence("Ctrl+Q"), self, self.reject)
    # end trigger

    def auto_sequence_interval(self, responders):
        """
        Disables/Enables the sequence interval, based on whether or not the user
        has automatic checked
        """
        isAutomaticChecked = self.automaticSeq_cb.isChecked()
        self.seqInterval_sb.setEnabled(not isAutomaticChecked)
    # end auto_sequenece_interval

    def curve_input_blank_status(self):
        """
        """
        isBlank = self.curveInput_cb.currentText()
        if isBlank.strip() == "":
            isBlank = True
        else:
            isBlank = False
        self.defaultCurve_cb.setEnabled(isBlank)
        self.estimateCurve_cb.setEnabled(isBlank)
    # end curve_input_blank_status

    def estimate_curve_checked(self):
        """
        If the estimate curve is checked, all other curve-related widgets are
        disabled and vice versa
        """
        isChecked = self.estimateCurve_cb.isChecked()
        self.defaultCurve_cb.setEnabled(not isChecked)
        self.curveInput_cb.setEnabled(not isChecked)
    # end estimate_curve_checked

    def default_curve_checked(self):
        """
        If the default curve is checked, all other curve-related widgets are
        disabled and vice versa
        """
        isChecked = self.defaultCurve_cb.isChecked()
        self.estimateCurve_cb.setEnabled(not isChecked)
        self.curveInput_cb.setEnabled(not isChecked)
    # end default_curve_checked

    def accept(self):
        """
        The method that runs when the "OK" button is pressed. Get the GUI's
        current information and send it to the batch processor
        """
        # Get information about the GUI before running external commands
        numOfThreads = self.threads_sb.value()
        outputType = self.outputType
        recursiveSearch = self.recursiveSearch_cb.isChecked()
        autoRenameFiles = self.automaticSeq_cb.isChecked()
        curveSettings = [self.defaultCurve_cb, self.estimateCurve_cb,
                         self.curveInput_cb]
        self.curveInput_cb.isChecked()
        for widget in curveSettings:
            try:
                if widget.isChecked():
                    curveWidgetUsed = widget
                    break
            except AttributeError:
                # The other two checkboxes failed, the combobox was used instead
                curveWidgetUsed = widget
                break
        # :AUTHORNOTE: Do the f number, next
        imageAlignment = self.imageAlignment_cb.isChecked()
        exposureCorrection = self.exposureCorrection_cb.isChecked()
        ghostRemoval = self.ghostRemoval_cb.isChecked()
        colorBalancing = self.colorBalancing_cb.isChecked()
        ignoreMissingExposures = self.ignoreMissingExposures_cb.isChecked()
        use32bitIEE = self.use32bitIEE_cb.isChecked()

        """
        engine.hdr_batch_process
        allFilesLen = len(allFiles)
        if allFilesLen == 0:
            raise RuntimeError("No valid files to merge into HDRs!")

        self.outputLogger_pb.show()
        for index, f in enumerate(allFiles):
            self.outputLogger_pb.setProgress("{}%".format(index / allFilesLen))
        self.outputLogger_pb.hide()
        """
    # end accept

    def reject(self):
        """
        The method that runs when the "OK" button is pressed
        """
        sys.exit()
    # end reject

    def exchange_fnum_widget(self):
        """
        Changes out the widgets for fnum so that the user can specify its value
        """
        value = self.manual_fnum_cb.isChecked()
        if not value:
            self.fnum_sw.setCurrentWidget(self.fnum_cb_p)
        else:
            self.fnum_sw.setCurrentWidget(self.fnum_le_p)
    # end exchange_fnum_widget

    def browse_curve_file(self, preferredExt="crv"):
        """
        Gets curve file from a file browser
        """
        # make sure to filter out all unwanted files and leave a * (All Files)
        #
        filepaths = QtGui.QFileDialog.getOpenFileName(self, "Browse Curve Profile")
        filepaths = [x for x in filepaths if x.strip() != ""]

        for f in filepaths:
            if os.path.isfile(f) and f.lower().endswith(preferredExt):
                fname = paths.path_leaf(f)
                shutil.copy2(f, os.path.join(self.curveInputDir, fname))

                self.curveInput_cb.addItem(fname)
                index = self.curveInput_cb.findText(fname,
                                                    QtCore.Qt.MatchFixedString)
                if index >= 0:
                    self.curveInput_cb.setCurrentIndex(index)

                self.defaultCurve_cb.setEnabled(False)
                self.estimateCurve_cb.setEnabled(False)
    # end browse_curve_file
# end Window


def show_gui():
    """
    Shows the GUI (currently set to show the GUI if the user passes in no
    arguments or the GUI option within the command-line)
    """
    app = QtGui.QApplication.instance()
    if app is None:
        app = QtGui.QApplication.activeWindow()
    if app is None:
        app = QtGui.QApplication(sys.argv)

    window = Window()
    window.show()
    sys.exit(app.exec_())
# end show_gui


def cmd_main():
    """
    Wraps a command-line utility around the hdr batch process.
    It takes a list of files or folders, gets their hdr sequences, and outputs
    hdrs based on common, user-specified settings.
    """
    description = 'Batch merge HDR images, using Picturenaut\'s mkhdri.exe '\
                  'command-line tool'
    parser = argparse.ArgumentParser(description=description)

    # general options
    message = "Ignores all other options and displays the GUI"
    parser.add_argument("g", "--gui", action="store_true", dest="gui",
                        help=message)

    message = "The number of CPU threads allowed to run at the same time."
    parser.add_argument('-t', '--threads', nargs='?', const=1, type=int,
                        dest='threads', help=message)

    message = "The files/folders that you wish to process"
    parser.add_argument('-i', '--input', nargs='*',
                        dest="inputs", help=message)

    message = 'Reads input text file to use for the output hdr\'s file names.'\
              'Each name must be separated by commas (requires text file)'
    parser.add_argument('-in', '--input-names', nargs='?',
                        dest='inputFileNames', help=message)

    message = 'Enable recursive file search. (Default: False)'
    parser.add_argument('-r', '--recursive', action='store_true',
                        default=False, dest="recursive", help=message)

    message = 'Enable automatic filenaming (takes first filename as base)'
    parser.add_argument('-ait', '--auto-renaming', action='store_true',
                        default=False, dest="autoRename", help=message)

    message = "The file-type to process. Default is hdr"
    parser.add_argument('-ti', '--input-type', nargs='?', dest='fileType',
                        help=message)

    message = 'Output folder. Default is "$ROOT/Output"'
    parser.add_argument('-o', '--output-folder', nargs='?',
                        dest='outputFolder', help=message)

    # HDRi merge options
    message = 'F-Number override. Will automatically determine F-No if not '\
              'specified'
    parser.add_argument('-fno', '--F-Num', nargs='?', dest='fno', type=float,
                        help=message)

    message = 'Read in curve estimation file (requires *.crv file'
    parser.add_argument('-ci', '--curve-input', nargs='?', dest='ci',
                        help=message)

    message = 'The number of brackets per HDR, aka hdr sequence interval'
    parser.add_argument('-si', '--sequence-interval', type=int, nargs='?',
                        dest='seqInterval', help=message)

    message = 'Enable image alignment'
    parser.add_argument('-a', '--image-alignment', action='store_true',
                        default=False, dest="a", help=message)

    message = 'Enable exposure correction'
    parser.add_argument('-ec', '--exposure-correction', action='store_true',
                        default=True, dest="ec", help=message)

    message = 'Enable ghost removal'
    parser.add_argument('-gr', '--ghost-removal', action='store_true',
                        default=False, dest="gr", help=message)

    message = 'Enable color balancing'
    parser.add_argument('-cb', '--color-balancing', action='store_true',
                        default=False, dest="cb", help=message)

    message = 'Don\'t ask for exposure values if they are missing, (return '\
              'error code -130 instead)'
    parser.add_argument('-da', '--dont-ask', action='store_true',
                        default=False, dest="da", help=message)

    message = 'Estimate curve only (disables any input curve files'
    parser.add_argument('-eo', '--estimate-curve', action='store_true',
                        default=False, dest="eo", help=message)

    message = 'Default camera curve (skips curve estimation)'
    parser.add_argument('-dc', '--default-curve', action='store_true',
                        default=False, dest="defcurve", help=message)

    message = 'Use 32-bit IEEE floating point for HDRI TIFFs'
    parser.add_argument('-f32', '--f32-tiff', action='store_true',
                        default=False, dest="f32", help=message)

    args = vars(parser.parse_args())
    cmdTool = CmdTool(args)

    try:
        engine.hdr_batch_process(inputs=cmdTool.requiredArgs['inputs'],
                                 seqInterval=cmdTool.requiredArgs['seqInterval'],
                                 **optionalArgs)
    except:
        raise RuntimeError("Something bad happened")
# end cmd_main


def main():
    """
    Chooses between the GUI or the command-line mode
    """
    if len(sys.argv) == 1:
        show_gui()
    else:
        cmd_main(sys.argv[1:])
# end main


if __name__ == "__main__":
    main()
