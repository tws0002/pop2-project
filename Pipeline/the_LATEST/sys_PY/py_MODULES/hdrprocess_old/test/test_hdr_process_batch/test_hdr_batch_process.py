#!/usr/bin/python

"""
Testing module for HDR Batch Process
"""

# IMPORT STANDARD LIBRARIES
import os
import inspect

PATH = inspect.stack()[-1][1]
PATH = PATH.split(os.sep)
EXEC_PATH = PATH[:-3]
PATH = PATH[:-1]
PATH = (os.sep).join(PATH)
EXEC_PATH = os.path.join((os.sep).join(EXEC_PATH), 'controller')
# IMPORT LOCAL LIBRARIES
import panorama_batch.controller.hdr_batch_process_012 as hdrBatch
# try:
#     import panorama_batch.controller.hdr_batch_process_012 as hdrBatch
# except ImportError:
#     import sys
#     sys.path.append(EXEC_PATH)
#     import hdr_batch_process_012 as hdrBatch
# except:
#     raise


def test_full_cmd_success():
    """
    Tests an ideal command input, with everything I use included day-to-day
    >>> execPath = '"' + os.path.join(EXEC_PATH, "hdr_batch_process_012.py") + '"'
    >>> imgFolderAndFiles = '"' + os.path.join(PATH, 'src', 'single_5') + '"'
    >>> fileList = os.path.join(PATH, 'filename_lists', 'filename_list_single_5.txt')
    >>> fileList = '"' + fileList + '"'
    >>> crvPath = os.path.join('curve_profiles','canon_t3i_response_curve.crv')
    >>> crvPath = '"' + os.path.join(PATH, crvPath) + '"'
    >>> cmd = execPath
    >>> cmd += ' -i ' + imgFolderAndFiles
    >>> cmd += ' -t 56 -fno 2 -si 5 -gr -ci ' + crvPath
    >>> cmd += ' -in ' + fileList
    >>> cmd
    >>> cmd = hdrBatch.parse_cmd(cmd)
    >>> inputs = cmd['inputs']
    >>> del cmd['inputs']
    >>> sequenceInterval = cmd['sequenceInterval']
    >>> del cmd['sequenceInterval']
    >>> hdrBatch.hdr_batch_process(inputs, sequenceInterval, cmd)
    """
    pass
# end test_full_cmd_success


if __name__ == "__main__":
    import doctest
    doctest.testmod()
