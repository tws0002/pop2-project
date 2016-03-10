#!/usr/bin/python

"""
..Description::
 Manager inits the specific methods from checkout to use for fileIO operations
..Author::
 Colin Kennedy
"""

# IMPORT STANDARD LIBRARIES
import os
import sys
import subprocess
import argparse
import ntpath
import re
import Queue
import threading
import logging
import time

# IMPORT LOCAL LIBRARIES
import inspect  # ::TEMP:: ::TO DO:: DELETE THIS

inspect.stack()[-1][1]
PATH = inspect.stack()[-1][1]
PATH = PATH.split(os.sep)[:-3]
PATH = (os.sep).join(PATH)
sys.path.append(PATH)
import fileIO.controller.recursive_folder_search as recursFolder

MAIN_CMD = '"C:\Program Files\Picturenaut\mkhdri.exe"'
EXITFLAG = 0
QUEUELOCK = threading.Lock()
WORKQUEUE = Queue.Queue(10)
THREADS = []
THREADID = 1

logging.basicConfig(level=logging.DEBUG,
                    format='(%(threadName)-10s) %(message)s',
                    )


class ActivePool(object):
    def __init__(self):
        super(ActivePool, self).__init__()
        self.active = []
        self.lock = threading.Lock()
    # end __init__

    def makeActive(self, name):
        with self.lock:
            self.active.append(name)
    # end makeActive

    def makeInactive(self, name):
        with self.lock:
            self.active.remove(name)
    # end makeInactive

    def numActive(self):
        with self.lock:
            return len(self.active)
    # end numActive

    def __str__(self):
        with self.lock:
            return str(self.active)
    # end __str__
# end ActivePool


class ThreadWorker(threading.Thread):
    def __init__(self, threadID, name, q):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.q = q
    # end __init__

    def run(self):
        logging.debug("Starting " + self.name)
        process_data(self.name, self.q)
        logging.debug("Exiting " + self.name)
        self.q.task_done()
        return
    # end run
# end THREADWORKER


def process_data(threadName, q):
    while not EXITFLAG:
        QUEUELOCK.acquire()
        if not WORKQUEUE.empty():
            data = q.get()
            QUEUELOCK.release()
            logging.info("%s processing %s" % (threadName, data))
        else:
            QUEUELOCK.release()
        time.sleep(1)
# end process_data


def filter_out_by_value(seq, value):
    for el in seq:
        if el == value:
            yield el
# end filter_out_by_value


def path_leaf(path):
    head, tail = ntpath.split(path)
    return tail or ntpath.basename(head)
# end path_leaf


def hdr_batch_process(inputs, sequenceInterval, *args, **kwargs):
    """
    The hdr batch process utility

    :key inputs: List of files and/or folders to process
    :key sequenceInterval: The number of brackets expected per HDR output
    :type inputs: list of strs
    :type sequenceInterval: int
    :returns: Success/Failure of the HDR batch process. 0 = Success
    :rtype: int
    """
    finalCmd = MAIN_CMD
    global THREADID
    global EXITFLAG
    global QUEUELOCK
    global WORKQUEUE
    global THREADS
    global THREADID

    if inputs is None:
        sys.exit("No input files/folders specified")

    if sequenceInterval is None:
        # ::HDR BATCH PROCESS TO DO:: Make the sequence interval an auto detect
        sys.exit("No hdr bracket sequence interval number specified")

    if kwargs['fileType'] is None:
        fileType = '.cr2'
    else:
        fileType = kwargs['fileType']

    inputFiles = [f for f in inputs if os.path.isfile(f)
                  and f.endswith(fileType)]
    inputFolders = [f for f in inputs if os.path.isdir(f)]

    if kwargs['recursive'] is False:
        folderSearchLevel = 0
    else:
        folderSearchLevel = 261  # some impossibly high number

    for folder in inputFolders:
        files = recursFolder.find_files(folder,
                                        depth=folderSearchLevel)
        files = (x for x in files if x.endswith((fileType,
                                                 fileType.upper(),
                                                 fileType.lower())))
        [inputFiles.append(x) for x in list(files)]  # add the files

    if inputFiles == []:
        sys.exit("No input files found from the specified files/folders")

    if kwargs is None:
        sys.exit("No arguments passed to process images")

    if kwargs['autoRename'] is None and kwargs['inputFileNames'] is None:
        sys.exit("No method to rename files specified")

    if kwargs['ci'] is None and \
       kwargs['ec'] is None or kwargs['defcurve']:
        sys.exit("No method for defining the camera curve specified")

    # (At this point) All necessary config settings have been found
    # start compiling the requested arguments
    if kwargs['fno'] is not None:
        finalCmd = finalCmd + ' -fno:{}'.format(kwargs['fno'])

    if kwargs['inputFileNames'] is not None:
        # get the list of names for the files
        with open(kwargs['inputFileNames'], "rt") as f:
            data = f.read()

        fileNameList = data.replace('-', "_")
        fileNameList = fileNameList.split(',')
        fileNameList = [x for x in fileNameList if x != '']
        fileNameList = [x.lstrip(' \t\r\n') for x in fileNameList]
        fileNameList = [x.rstrip(' \t\r\n') for x in fileNameList]
        fileNameList = [x+'.hdr' for x in fileNameList if '.' not in x]  # ext

    # AUTHOR NOTE: I need to make some kind of conditional so that there can only be one or the other. Or something

    if 'eo' in kwargs:
        # kwargs['estimateCurve']
        finalCmd = finalCmd + ' -eo'
    elif 'ci' in kwargs and 'defcurve' in kwargs:
        print("The curve input file will be read, instead of the define curve")
        # kwargs['ci']
        finalCmd = finalCmd + ' -ci {}'.format(kwargs['ci'])
    elif 'ci' in kwargs and 'defcurve' not in kwargs:
        # kwargs['ci']
        finalCmd = finalCmd + ' -ci {}'.format(kwargs['ci'])
    elif 'defcurve' in kwargs:
        # kwargs['defcurve']
        finalCmd = finalCmd + ' -defcurve'
    else:
        message = "No curve estimation or curve file provided. Script doesn't"\
                  " know how to interpret the hdr without it. Please specify "\
                  "a curve option"
        sys.exit(message)

    # Make a new list, grouped by nth-->nth+1 element, n is sequenceInterval
    inputFiles = [inputFiles[x:x+sequenceInterval]
                  for x in range(0, len(inputFiles), sequenceInterval)]

    if kwargs['inputFileNames'] is not None and \
       len(inputFiles) != len(fileNameList):
        sys.exit("The provided file name list does does not match "
                 "the number of image files found")

    checkFileNames = []  # check if duplicate name and file path generated
    for i, group in enumerate(inputFiles):
        if kwargs['outputFolder'] is None and i == 0:
            outputFolder = os.path.dirname(group[0])
            tempDir = re.match(r'(\d+).\d+',
                               str(os.stat(outputFolder).st_mtime)).group(1)

            tempDir = "_".join(["Output", tempDir])
            outputFolder = os.path.join(outputFolder, tempDir)
            if not os.path.isdir(outputFolder):
                print "Making directory", outputFolder
                os.makedirs(outputFolder)  # make new folder for output

        elif kwargs['outputFolder'] is None and i >= 0:
            continue
        elif kwargs['outputFolder'] is not None:
            outputFolder = kwargs['outputFolder']

        if kwargs['inputFileNames'] is not None:
            outputName = os.path.join(outputFolder, fileNameList[i])
        elif kwargs['autoRename'] is not None:
            outputName = os.path.join(outputFolder, path_leaf(group[0]))

        if outputName in checkFileNames:
            try:
                userCheck
            except NameError:
                userCheck = raw_input("Filename: {f} was already found.\nDo "
                                      "you want to override the previous "
                                      "file? y/N/yes_all")
            else:
                if userCheck != "yes_all":
                    userCheck = raw_input("Filename: {f} was already found."
                                          "\nDo you want to override the "
                                          "previous file? y/N/yes_all")
                if userCheck == 'y':
                    continue
                elif userCheck == 'yes_all':
                    print "Auto-override has been set. Continuing"
                elif userCheck == 'n':
                    message = "Please rename file {f} "\
                              "before continuing".format(f=outputName)
                    sys.exit(message)

        if kwargs['outputFolder'] is None:
            outputFolder = os.path.dirname(group[0])

        if os.path.isdir(os.path.dirname(outputFolder)):
            finalCmd = finalCmd + ' -out:{}'.format('"' + outputName + '"')
            group = ['"' + x + '"' for x in group]
            filesToProcess = ' ' + ' '.join(group)
            finalCmd = finalCmd + filesToProcess

            # Create new threads
            if THREADID <= kwargs['threads']:
                thread = ThreadWorker(THREADID, 'thread-{}'.format(i+1), WORKQUEUE)
                thread.daemon = True
                thread.start()
                THREADS.append(thread)
                THREADID += 1

            # Fill the queue
            QUEUELOCK.acquire()
            WORKQUEUE.put(subprocess.call(finalCmd))  # run command
            # QUEUELOCK.release()
        else:
            message = "Folder: {f} does not exist. Could not create "\
                      "file, \"{name}\"".format(f=outputFolder,
                                                name=outputName)
            print message
    QUEUELOCK.release()
    # Wait for queue to empty
    while not WORKQUEUE.empty():
        pass

    # Notify threads it's time to exit
    EXITFLAG = 1

    # Wait for all threads to complete
    for t in THREADS:
        t.join()
    logging.debug("Exiting Main Thread")

    return 0
# end hdr_batch_process


def main():
    """
    Wraps a command-line utility around the hdr batch process.
    It takes a list of files or folders, gets their hdr sequences, and outputs
    hdrs based on common, user-specified settings.
    """
    description = 'Batch merge HDR images, using Picturenaut\'s mkhdri.exe '\
                  'command-line tool'
    parser = argparse.ArgumentParser(description=description)

    message = "The files/folders that you wish to process"
    parser.add_argument('-i', '--input', nargs='*',
                        dest="inputs", help=message)

    message = 'Enable recursive file search. (Default: False)'
    parser.add_argument('-r', '--recursive', action='store_true',
                        default=False, dest="recursive", help=message)

    message = 'The number of threads your the process is allowed to use.'
    parser.add_argument('-t', '--threads', type=int, nargs='?', const=1,
                        dest='threads', help=message)

    message = "The file-type to process. Default is hdr"
    parser.add_argument('-ti', '--input-type', nargs='?', dest='fileType',
                        help=message)

    message = 'Reads input file to use for the output hdr\'s file names. '\
              'Each name must be separated by commas (requires text file)'
    parser.add_argument('-in', '--input-names', nargs='?',
                        dest='inputFileNames', help=message)

    message = 'Enable automatic filenaming (takes first filename as base)'
    parser.add_argument('-ait', '--auto-renaming', action='store_true',
                        default=False, dest="autoRename", help=message)

    message = 'F-Number override. Will automatically determine F-No if not '\
              'specified'
    parser.add_argument('-fno', '--F-Num', nargs='?', dest='fno', type=float,
                        help=message)

    message = 'Read in curve estimation file (requires *.crv file'
    parser.add_argument('-ci', '--curve-input', nargs='?', dest='ci',
                        help=message)

    message = 'The number of brackets per HDR, aka hdr sequence interval'
    parser.add_argument('-si', '--sequence-interval', type=int, nargs='?',
                        dest='sequenceInterval', help=message)

    # message = 'output file number padding'
    message = 'Output folder. Default is "$ROOT/Output"'
    parser.add_argument('-o', '--output-folder', nargs='?',
                        dest='outputFolder', help=message)

    message = 'Enable image alignment'
    parser.add_argument('-a', '--image-alignment', action='store_true',
                        default=False, dest="a", help=message)

    message = 'Enable exposure correction'
    parser.add_argument('-ec', '--exposure-correction', action='store_true',
                        default=False, dest="ec", help=message)

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

    # args = parser.parse_args()

    # split two dicts up - one is required, the other is optional
    # optional keys init with both optional and required keys, so the
    # required keys are then removed so only optional keys remain
    #
    optionalArgs = vars(parser.parse_args())
    # optionalArgs = dict((k, v) for k, v in optionalArgs.iteritems() if v)
    requiredArgs = {'sequenceInterval': optionalArgs.get("sequenceInterval",
                                                         None),
                    'inputs': optionalArgs.get("inputs", None)
                    }

    # remove the required args from the optional dict
    optionalArgs.pop("sequenceInterval", None)
    optionalArgs.pop("inputs", None)

    cmd = hdr_batch_process(inputs=requiredArgs['inputs'],
                            sequenceInterval=requiredArgs['sequenceInterval'],
                            **optionalArgs)
    if cmd != 0:
        sys.exit("Command exitted with errcode: {num}".format(num=cmd))
# end main


if __name__ == "__main__":
    main()
