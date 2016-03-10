import argparse
"""
parser = argparse.ArgumentParser()
parser.add_argument("a")
args = parser.parse_args()

if args.a == 'magic.name':
    print 'You nailed it!'
"""

parser = argparse.ArgumentParser(description='Make Maya Paths Relative.')
parser.add_argument('-ma', '--mayaFile', nargs='+',
               help='The path to a maya file ending in .ma')
parser.add_argument('-rp', '--rootPath',
                   help='The root path which will be used as a '\
                        'reference for all relative paths')
args = parser.parse_args()

print args.mayaFile
print args.rootPath
