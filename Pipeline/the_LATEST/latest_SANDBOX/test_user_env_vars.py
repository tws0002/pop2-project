#!/usr/bin/env python

# IMPORT STANDARD LIBRARIES
import os
import platform
import PyQt4

def main():
	# Absolute path on windows: I:\Savannah\CollaborativeSpace\portal-origins-part-2
	# Absolute path on linux /home/username/mount/collaborative/portal-origins-part-2
	print os.environ['USER']
	print os.environ['USERPROFILE']
	print os.environ['HOME']
	print os.environ['HOMEPROFILE']

if __name__ == "__main__":
	main()
