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
import functools
from subprocess import Popen
from itertools import islice


# IMPORT THIRD-PARTY LIBRARIES
try:
    import PyQt4.QtCore as QtCore
    import PyQt4.QtGui as QtGui
except ImportError:
    import PySide.QtCore as QtCore
    import PySide.QtGui as QtGui
except:
    raise

# IMPORT LOCAL LIBRARIES
import commons.view.guiwidgets as guiwidgets
import fileio.controller.paths as paths
import controller.engine as engine
import controller.routine as routine
import view.mainWindow as mainWindow


CURRENT_DIR = os.path.dirname(os.path.realpath(__file__))


class CmdTool:
    """
    Helps initialize the basic configuration of the command-line version
    """
    def __init__(self, *args):
        # optionalArgs = dict((k, v) for k, v in optionalArgs.iteritems() if v)
        self.args = args  # keep a list of the original args
        self.requiredArgKeys = ["seqInt", "inputs"]
        self.init_args()
    # end __init__

    def init_args(self):
        """
        Convenience method to help sort required arguments from optional ones
        """
        optionalArgs = dict((k, v) for k, v in self.args.iteritems()
                            if v is not None and v is not False)

        tempRequired = [x.lower() for x in self.requiredArgKeys]
        self.requiredArgs = {k: optionalArgs[k] for k, v in optionalArgs.iteritems()
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
    """
    The main window that's drawn when the script is executed
    """
    def __init__(self, parent=None):
        """
        Main constructor method for initializing an instance

        Args:
            parent (QApplication): The application (instance or otherwise) to
                                   hook into the GUI
        """
        super(Window, self).__init__(parent)
        # super(Window, self).__init__(parent)
        self.dataDict = {}
        self.maxRowCount = 20
        self.defLEPhrases = ["Some hdr file/folder/text file",
                             "Input your raw files and any text files (text "\
                             "files must comma-separated list of image names. "\
                             "See docs for more details on that)"]
        self.allowedExtensions = [# HDR Formats
                                  ".pfm",
                                  ".exr",
                                  ".tif",
                                  ".tiff",

                                  # LDR Formats
                                  ".jpg",
                                  ".jpeg",
                                  ".tga",
                                  ".cr2",
                                  ".raw",

                                  # GENERAL Formats
                                  ".txt"]
        self.fnumDefault = 1.4
        # fnum values taken from wiki page: https://en.wikipedia.org/wiki/F-number
        self.fnumOptions = [0.5, 0.7, 1.0, 1.4, 2, 2.8, 4, 5.6, 8, 11, 16, 22,
                            32, 45, 64, 90, 128, 180, 256]
        self.outputTypeOptions = [".exr", ".hdr", ".tiff", ".pfm"]
        self.outputTypeDefault = ".hdr"
        self.curveInputDir = os.path.join(CURRENT_DIR, "model")
        self.maxThreadCount = multiprocessing.cpu_count()
        self.setupUi(self)
        self.init_ui()
        self.trigger()
    # end __init__

    def init_ui(self):
        """
        Initializes the UI window and overrides some default values
        """
        # get basic main config settings
        self.addFolderLine_pb.setMaximumSize(90, 28)
        self.threads_sb.setValue(self.maxThreadCount)
        self.autoRenameFiles_cb.setChecked(True)
        self.curveInput_cb.addItem
        self.defaultCurve_cb.setChecked(True)
        self.estimateCurve_cb.setEnabled(False)
        self.curveInput_cb.setEnabled(False)
        self.curveInput_tb.setEnabled(False)
        self.seqInterval_sb.setProperty("value", 5)
        self.fnum_cb.setProperty("value", self.fnumDefault)
        self.fnum_cb.set
        self.colorBalancing_cb.setChecked(True)
        self.exposureCorrection_cb.setChecked(True)
        self.use32bitIEE_cb.setChecked(True)
        self.fnumAutomatic_cb.setChecked(True)
        self.fnum_sw.setEnabled(False)
        self.init_curve_inputs()

        for fnum in self.fnumOptions:
            self.fnum_cb.addItem(str(fnum))
        index = self.fnum_cb.findText(self.fnumDefault, QtCore.Qt.MatchFixedString)
        if index >= 0:
            self.fnum_cb.setCurrentIndex(index)

        for opt in self.outputTypeOptions:
            self.outputType_cb.addItem(str(opt))

        index = self.fnum_cb.findText(self.outputTypeDefault, QtCore.Qt.MatchFixedString)
        if index >= 0:
            self.outputType_cb.setCurrentIndex(index)


        # self.outputLogger_te.setText()
        self.outputLogger_pb.setValue(0)
        self.outputLogger_pb.hide()
        self.outputLogger_te.setReadOnly(True)

        # :AUTHORNOTE: :TEMP: :REMOVELATER:
        # self.addFolderLine_le.setText(r"D:\capture_test\cr2s\Newfolder")
        self.addFolderLine_le.setText(r"I:/Savannah/CollaborativeSpace/portal-origins-part-2/Pipeline/the_LATESTDEV/sys_PY/py_MODULES/hdrprocess/test/image_files")
        self.recursiveSearch_cb.setChecked(True)
    # end init_ui

    def init_curve_inputs(self, fileSuffix=".crv"):
        """
        Creates the options for the curve input

        Args:
            fileSuffix (str or tuple): The extension or tuple of extensions
                                       allowed for camera filetypes
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
        addFolder = functools.partial(self.add_folder_line, self.defLEPhrases[0])
        self.addFolderLine_pb.clicked.connect(addFolder)
        self.automaticSeq_cb.stateChanged.connect(self.auto_sequence_interval)
        self.manual_fnum_cb.stateChanged.connect(self.exchange_fnum_widget)
        self.connect(self.curveInput_cb,
                     QtCore.SIGNAL("currentIndexChanged(const QString&)"),
                     self.curve_input_blank_status)
        self.fnumAutomatic_cb.stateChanged.connect(self.toggle_fnum_automatic)
        self.curveInput_tb.clicked.connect(self.browse_curve_file)
        self.estimateCurve_cb.stateChanged.connect(self.estimate_curve_checked)
        self.defaultCurve_cb.stateChanged.connect(self.default_curve_checked)
        self.okCancel_bb.accepted.connect(self.accept)
        self.okCancel_bb.rejected.connect(self.reject)

        QtGui.QShortcut(QtGui.QKeySequence("Ctrl+Q"), self, self.reject)
    # end trigger

    def add_folder_line(self, defaultText=""):
        """
        Creates a new line at the bottom of the layout that contains a lineEdit,
        a QToolButton, and a QPushButton in a horizontalLayout

        Args:
            defaultText (str): The text that is placed in the lineEdit

        Returns:
            NoneType: None
        """
        windowSize = self.geometry()

        combinedLD = guiwidgets.CombinedRow(self)

        self.DATADICT = {"license": "", "items": []}

        if defaultText != "":
            combinedLD.lineEdit.setText(defaultText)

        combinedLD.remove_button()
        combinedLD.setObjectName("horizontalLayout_2")
        self.gridLayout.addLayout(combinedLD,
                                  self.gridLayout.rowCount() + 1, 0, 1, 5)
    # end add_folder_line

    def auto_sequence_interval(self):
        """
        Disables/Enables the sequence interval, based on whether or not the user
        has automatic checked

        .. important::
            This function is currently not implemented
        """
        raise NotImplementedError("Auto sequence interval doesn't work yet. Sorry!")
        isAutomaticChecked = self.automaticSeq_cb.isChecked()
        self.seqInterval_sb.setEnabled(not isAutomaticChecked)
    # end auto_sequenece_interval

    def curve_input_blank_status(self):
        """
        Checks if the current input curve is blank and, depending on whether or
        not the input is blank, will also lock the "Default Curve" and
        "Estimate Curve Only" from editting.
        """
        isBlank = self.curveInput_cb.currentText()
        if isBlank.strip() == "":
            isBlank = True
        else:
            isBlank = False
        self.defaultCurve_cb.setEnabled(isBlank)
        self.estimateCurve_cb.setEnabled(isBlank)
    # end curve_input_blank_status

    def toggle_fnum_automatic(self):
        """
        Enables/Disables the F-Num value, depending on whether or not the
        automatic checkbox is enabled
        """
        isChecked = self.fnumAutomatic_cb.isChecked():
        self.manual_fnum_cb.setChecked(not isChecked)
        self.fnum_sw.setEnabled(not isChecked)
    # end toggle_fnum_automatic

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
        current information and send it to the batch processor.

        The function keeps two dictionaries, one for displaying and other other
        for execution. The display version is used only if the contents of the
        script would be too long to view all at once in the GUI (aka, if it's
        greater than self.maxRowCount)
        """
        # the truncated version is for if the retrieved items would cause the
        # GUI to be really long. The idea is to only get the first/last pair
        # of every filename and try to shorten the output as much as possible
        #
        # The original list is still retained within self.dataDict, regardless
        #
        self.dataDict, self.truncatedView = self.get_gui_data()

        if self.dataDict.get('items', []) == []:
            raise RuntimeError("No valid raw/text files were acquired")

        message = 'Take a look at these settings before continuing:\n\n'\
                  'The following file(s) will be affected:\n{f}\n\n'\
                  'General Settings:\n'\
                  'Output extension: {ext!r}\n'\
                  'Number of threads allowed for the job: {tr!r}\n'\
                  'Search all folders/subfolders? "{cb}"\n'\
                  'Auto rename the output files? {ar!r}\n\n'\
                  'Curve Settings:\n'\
                  'Chosen Method: {cm!r}\n\n'\
                  'Shooting Seetings:\n'\
                  'F-Number (Stops): {fnum!r}\n'\
                  'Sequence Interval: {si!r}\n\n'\
                  'Merge Settings:\n'\
                  'Image Alignment? {ia!r}\n'\
                  'Exposure Correction? {ec!r}\n'\
                  'Ghost Removal? {gr!r}\n'\
                  'Color Balancing? {cr!r}\n\n'\
                  'Misc Settings:\n'\
                  'Ignore missing exposure values? {ie!r}\n'\
                  'Use 32-bit float IEEE for TIFF files? {bt!r}\n'\
                  ''.format(f=self.truncatedView['items'],
                            ext=self.dataDict['outputType'],
                            tr=self.dataDict['numOfThreads'],
                            cb=self.dataDict['recursiveSearch'],
                            ar=self.dataDict['autoRenameFiles'],
                            cm=self.dataDict['curveMethod'],
                            fnum=self.dataDict['fnum'],
                            si=self.dataDict['seqInt'],
                            ia=self.dataDict['imageAlignment'],
                            ec=self.dataDict['exposureCorrection'],
                            gr=self.dataDict['ghostRemoval'],
                            cr=self.dataDict['colorBalancing'],
                            ie=self.dataDict['ignoreMissingExposures'],
                            bt=self.dataDict['use32bitIEE']
                            )

        self.msgBox = QtGui.QMessageBox().question(self,
                                                   'Message',
                                                   message,
                                                   QtGui.QMessageBox.Yes,
                                                   QtGui.QMessageBox.No,
                                                   )

        if self.msgBox == QtGui.QMessageBox.Yes:
            # user said yes to the message dialog
            options = {"threads": self.dataDict['numOfThreads'],
                       "outputType": self.dataDict['outputType'],
                       'autoRename': self.dataDict['autoRenameFiles'],
                       'fno': self.dataDict['fnum'],
                       'ec': self.dataDict['exposureCorrection'],
                       'a': self.dataDict['imageAlignment'],
                       'gr': self.dataDict['ghostRemoval'],
                       'cb': self.dataDict['colorBalancing'],
                       'f32': self.dataDict['use32bitIEE'],
                       'da': self.dataDict['ignoreMissingExposures']}

            # Curve Settings
            if self.dataDict['curveMethod'] == "Default curve":
                options.update({"defcurve": True})
            elif self.dataDict['curveMethod'] == "Estimate curve only":
                options.update({"eo": True})
            elif self.dataDict['curveMethod'] == "Curve Input":
                options.update({"ci": True})

            sequences = routine.get_sequences(self.dataDict["items"],
                                              self.dataDict["seqInt"])
            self.outputLogger_pb.show()
            self.outputLogger_pb.setValue(0)
            self.outputLogger_te.append("Script starting...")
            commands = []
            outputs = []
            for i, sequence in enumerate(sequences):
                # test for a common file extension
                extensions = [os.path.splitext(x)[-1] for x in sequence]
                if engine.all_same(extensions):
                    options.update({"fileType": extensions[0]})

                # get progress percent
                outputCmd = engine.hdr_batch_process(sequence,
                                                     self.dataDict['seqInt'],
                                                     **options)
                commands.append(outputCmd[0])

            # run each formatted command
            processes = (Popen(cmd, shell=True) for cmd in commands)
            running_processes = list(islice(processes, self.dataDict['numOfThreads']))  # start new processes
            # because the processes are counting down, an reversed index is kept
            # so that it increments while the number of remaining processes
            # decrements in the current execution
            #
            reverseIndex = len(commands)
            previousPercent = -1
            while running_processes:
                for i, process in enumerate(running_processes):
                    # update time slider
                    processPercent = ((len(commands) - len(running_processes)) /\
                                      float(len(commands)))
                    processPercent *= 100
                    if processPercent != previousPercent:
                        previousPercent = processPercent
                        self.outputLogger_pb.setValue(processPercent)
                        self.outputLogger_te.append("Percent Complete: {perc!r}%. "
                                                    "\n".format(perc=processPercent))

                    if process.poll() is not None:  # the process has finished
                        try:
                            running_processes[i] = next(processes)  # start new process
                        except StopIteration:
                            del running_processes[i]
                            break

            self.outputLogger_te.append("Percent Complete: 100%.")
            self.outputLogger_pb.setValue(1)
            self.outputLogger_pb.hide()
            print "Completed"
        else:
            # close message box but do not close the main window
            # reset dict to default settings
            #
            self.reset_gui_data()
    # end accept

    def get_gui_data(self):
        """
        Gets information about the current scene

        Returns:
            tuple: Returns two dictionaries. The first is the dictionary that's
                   used for executing files and the second is used for viewing
                   within the GUI
        """
        # Get information about the GUI before running external commands
        self.dataDict['numOfThreads'] = self.threads_sb.value()
        self.dataDict['outputType'] = str(self.outputType_cb.currentText()).strip()
        self.dataDict['recursiveSearch'] = self.recursiveSearch_cb.isChecked()
        self.dataDict['autoRenameFiles'] = self.autoRenameFiles_cb.isChecked()
        self.dataDict['seqInt'] = self.seqInterval_sb.value()

        self.dataDict['imageAlignment'] = self.imageAlignment_cb.isChecked()
        self.dataDict['exposureCorrection'] = self.exposureCorrection_cb.isChecked()
        self.dataDict['ghostRemoval'] = self.ghostRemoval_cb.isChecked()
        self.dataDict['colorBalancing'] = self.colorBalancing_cb.isChecked()
        self.dataDict['ignoreMissingExposures'] = self.ignoreMissingExposures_cb.isChecked()
        self.dataDict['use32bitIEE'] = self.use32bitIEE_cb.isChecked()

        fnumSwitch = self.fnum_sw.currentWidget()
        if fnumSwitch == self.fnum_cb_p:
            self.dataDict['fnum'] = str(self.fnum_cb.currentText()).strip()
        elif fnumSwitch == self.fnum_le_p:
            self.dataDict['fnum'] = str(self.fnum_le.text()).strip()
        else:
            raise RuntimeError("The expected widget returned for f-num's "
                               "stacked widget got an unexpected value "
                               "returned. Stopping script from continuing.")

        try:
            self.dataDict['fnum'] = float(self.dataDict['fnum'])
        except ValueError:
            raise ValueError("Invalid value recieved for sequencial interval. "
                             "Please input a number (float or integer)")
        except:
            raise

        if self.defaultCurve_cb.isChecked():
            self.dataDict['curveMethod'] = "Default curve"
        elif self.estimateCurve_cb.isChecked():
            self.dataDict['curveMethod'] = "Estimate curve only"
        elif str(self.curveInput_cb.currentText()).strip() != "":
            self.dataDict['curveMethod'] = "Curve Input"
        elif str(self.curveInput_cb.currentText()).strip() == "":
            raise RuntimeError("Curve input was specified but no item as "
                               "passed to it. Script cannot continue")
        else:
            raise RuntimeError("A bad widget was passed to the curve settings "
                               "for loop. To prevent the script potentially "
                               "executing wrongfully, the script will exit "
                               "prematurely")

        for f in self.findChildren(QtGui.QLineEdit):
            formText = str(f.text()).strip()

            if f.objectName() == "addFolderLine_le" and \
                    formText not in self.defLEPhrases and formText != '' and \
                    formText is not None and (os.path.isdir(formText) or \
                    os.path.isfile(formText)):
                self.dataDict["items"] = self.dataDict.get("items", []) + \
                                         [formText]

        self.dataDict["items"] = list(set(self.dataDict["items"]))  # remove dups
        processedItems = routine.process_files(self.dataDict,
                                               self.allowedExtensions,
                                               self.defLEPhrases)
        processedItems = routine.sort_by_ext_and_name(processedItems)
        self.dataDict["items"] = processedItems
        if len(self.dataDict["items"]) > self.maxRowCount:
            processedItems = routine.truncate_filename_ranges(processedItems,
                                                              self.maxRowCount)
        truncatedDict = {}
        truncatedDict.update({"items": processedItems})
        return (self.dataDict, truncatedDict)
    # end get_gui_data

    def reset_gui_data(self):
        """
        Sets the GUI's underlying data back to to its default state. This
        function must be used whenever the user stops the script mid-execution
        or when they execute self.accept but exit out of the confirmation
        message box prematurely. If this isn't done, the information from the
        previous execution is compounded with the next.
        """
        self.dataDict = {}
    # end reject_gui_data

    def reject(self):
        """
        The method that runs when the "OK" button is pressed
        """
        sys.exit()
    # end reject

    def exchange_fnum_widget(self):
        """
        Changes out the widgets for f-number (the stops of an image) so that
        the user can either write in a f-number by hand or pick from a menu.
        """
        value = self.manual_fnum_cb.isChecked()
        if not value:
            self.fnum_sw.setCurrentWidget(self.fnum_cb_p)
        else:
            self.fnum_sw.setCurrentWidget(self.fnum_le_p)
    # end exchange_fnum_widget

    def browse_curve_file(self, preferredExt="crv"):
        """
        Gets curve file from a file browser. If the returned string from the
        browser is a valid file, the curve input box is set to that new item
        and "Default Curve" and "Estimate Curve Only" are disabled

        Args:
            preferredExt (str): The extension that the browser will look for
                                whenever listing directories for a curve file
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


def run_mkhdr(cmdList, maxWorkers, winInstance):
    """
    Runs the multi-threaded process for the HDR merge

    .. warning::
        Deprecated. Does NOT work
    """
    processes = (Popen(cmd, shell=True) for cmd in cmdList)
    running_processes = list(islice(processes, maxWorkers))  # start new processes


    while running_processes:
        for i, process in enumerate(running_processes):
            # update time slider
            processPercent = float(i) * 100 / len(sequences)
            winInstance.outputLogger_pb.setValue(processPercent)
            winInstance.outputLogger_te.append("\n\nPercent Complete: {perc!r}%. "
                                               "Processing sequence,"
                                               "\n".format(perc=processPercent))
            for f in sequence:
                winInstance.outputLogger_te.append("{s!r}\n".format(s=f))

            if process.poll() is not None:  # the process has finished
                try:
                    running_processes[i] = next(processes)  # start new process
                except StopIteration:
                    del running_processes[i]
                    break
# end run_mkhdr


def show_gui():
    """
    Shows the GUI (currently set to show the GUI if the user passes in no
    arguments or the GUI option within the command-line)
    """
    app = QtGui.QApplication.activeWindow()
    if app is None:
        app = QtGui.QApplication.instance()
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

    Args:
        --gui (bool): (-g) Setting this argument will ignore all over argument
                      and simply load the GUI version of the script

        --threads (int): (-t) The number of threads allowed for the current
                         execution. Specified values that are > the machine's
                         max number of threads are automatically clamped

        --inputs-names (str): (-in) A list of comma-separated full file paths
                              to every image that you wish to process into HDRs

        --recursive (bool): (-r) If specified, the script will search folders
                            to add files to process into HDRs recursively

        --auto-renaming (bool): (-ait) Enable automatic filenaming. The feature
                                takes first filename as its base for the rename

        --input-type (str): (-ti) The file-type to process. Default is hdr if
                            none is specified

        --output-folder (str): (-o) The output folder for the created HDRs.
                               The default folder is "$ROOT/Output_#"

        --F-Num (float): (-fno) F-Number override for the sequence. Will
                         automatically determine F-No if not specified

        --curve-input (str): (-ci) A comma-separated list to a variable number
                             of absolute paths pointing to text files. The text
                             files contain information about the image brackets
                             for a single HDR output image. Enabling this
                             option will disable --default-curve (-dc) and
                             --estimate-curve (-eo)

        --estimate-curve (bool): (-eo) Estimate curve only (disables any input
                                 curve files. The generated .crv file can be
                                 used as a curve input in future executions.
                                 Enabling this option will disable
                                 --curve-input (-ci) and --default-curve (-dc)

        --default-curve (bool): (-dc) A gamma correction of 1/2.2 is applied to
                                the images prior to merging the images to a HDR.
                                Enabling this option will disable
                                --curve-input (-ci) and --estimate-curve (-eo)

        --sequence-interval (int): (-si) The number of brackets per HDR, aka
                                   HDR sequence interval

        --image-alignment (bool): (-a) Enables image alignment for all of the
                                  HDRs

        --exposure-correction (bool): (-ec) Enables exposure correction for all
                                      of the HDRs. (Recommended to always be on)

        --ghost-removal (bool): (-gr) Enables ghost removal for all of the HDRs

        --color-balancing (bool): (-cb) Enables color balancing for all of the
                                  HDRs

        --dont-ask (bool): (-da) Don't ask for exposure values if they are
                           missing, (return error code -130 instead)

        --f32-tiff (bool): (-f32) Use 32-bit IEEE floating point for any output
                           HDRi TIFF files. Does nothing if any other output
                           image format is specified
    """
    description = 'Batch merge HDR images, using Picturenaut\'s mkhdri.exe '\
                  'command-line tool'
    parser = argparse.ArgumentParser(description=description)

    # general options
    message = "Ignores all other options and displays the GUI"
    parser.add_argument("-g", "--gui", action="store_true", dest="gui",
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

    message = 'Estimate curve only (disables any input curve files'
    parser.add_argument('-eo', '--estimate-curve', action='store_true',
                        default=False, dest="eo", help=message)

    message = 'Default camera curve (skips curve estimation)'
    parser.add_argument('-dc', '--default-curve', action='store_true',
                        default=False, dest="defcurve", help=message)

    message = 'The number of brackets per HDR, aka hdr sequence interval'
    parser.add_argument('-si', '--sequence-interval', type=int, nargs='?',
                        dest='seqInt', help=message)

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

    message = 'Use 32-bit IEEE floating point for HDRI TIFFs'
    parser.add_argument('-f32', '--f32-tiff', action='store_true',
                        default=False, dest="f32", help=message)

    args = vars(parser.parse_args())
    cmdTool = CmdTool(args)

    try:
        engine.hdr_batch_process(inputs=cmdTool.requiredArgs['inputs'],
                                 seqInt=cmdTool.requiredArgs['seqInt'],
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
