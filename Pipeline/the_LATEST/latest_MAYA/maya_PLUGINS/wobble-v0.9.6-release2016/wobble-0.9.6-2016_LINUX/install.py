#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
	Last Change: 27.09.2015
		Changed module installation dir

    TODO/Ideas:
        - verbose option
        - even --prefix option?
        - rather to autodesk/modules/maya than maya/modules
'''

import os
import shutil
import sys 
import os.path as op

tool_name = 'wobble'
tool_version = '0.9.6'

readme_file = '%s deformer %s short documentation.pdf' % (tool_name, tool_version)

# vorerst
moduleDirs = ['scripts', 'icons']

maya_basedir = '/usr/autodesk/maya'

maya_supported_versions = range(2010, 2017)
maya_supported_versions = map(str, maya_supported_versions)

maya_existing_versions = []

mayaVersion = ''

print '\n'

try:
  f = open('license.txt', 'r')
  print (f.read())
except:
  sys.exit('Installation error - could not read license file.')

lic = ''
while lic is not 'a':
  lic = raw_input('Licence: (a)ccept or (d)ecline:\n')
  if lic == 'd':
    print 'License not accepted, installation cancelled.\n'
    sys.exit(0)

# detect maya installations and store 
for item in maya_supported_versions:
    if op.exists('%s%s-x64' % (maya_basedir, item)) or op.exists('%s%s' % (maya_basedir, item)):
        maya_existing_versions.append(item)

maya_existing_versions_dict = {}
print '\nPlease choose the maya version to install %s for:\n' % tool_name
for i, item in enumerate(maya_existing_versions):
    print '\t(%s) %s' % (i, item)
    maya_existing_versions_dict.setdefault(str(i), item)

# ask for version input
chosen_version = -1
while not chosen_version in maya_existing_versions_dict.keys():
    chosen_version = raw_input('\nChoice: ')
    
# get ...
chosen_maya_version = maya_existing_versions_dict[chosen_version]
#print 'You chose to install for maya', chosen_maya_version

install_variants = {'global' : '(Sudo access required)', 'user': ''}
install_variants_dict = {}
chosen_install_type = -1

if os.getuid() == 0:
    #chosen_install_type = 0
    chosen_install_type_string = 'global'
else:
    # ask for global or local installation
    
    print '\nPlease choose the installation type:\n'
    for i, item in enumerate(install_variants.keys()):
	print '\t(%s) %s %s' % (i, item, install_variants.get(item, ''))
	# mach nur, weil hier eh grad schleife...
	install_variants_dict.setdefault(str(i), item)

    while not chosen_install_type in install_variants_dict.keys():
	chosen_install_type = raw_input('\nChoice: ')

    chosen_install_type_string = install_variants_dict[chosen_install_type]

#print 'You chose %s install' % chosen_install_type_string

module_target_dir = ''
module_dir = ''

if chosen_install_type_string == 'user':
    if int(chosen_maya_version) < 2016:
        base = op.expanduser('~/maya/%s-x64/' % chosen_maya_version)
    else:
        base = op.expanduser('~/maya/%s/' % chosen_maya_version)
    # if not exists create
    module_target_dir = op.join(base, 'feTools/%s' % tool_name)
    module_dir = op.join(base, 'modules')
    
elif chosen_install_type_string == 'global':
    module_target_dir = '/usr/local/feTools/%s' % tool_name
    # und create
    # os.makedirs
    if int(chosen_maya_version) < 2016:
        module_dir = '%s%s-x64/modules' % (maya_basedir, chosen_maya_version)
    else:
        module_dir = '%s%s/modules' % (maya_basedir, chosen_maya_version)
    

# install components for version
# scripts and icons neutral

# create feTools/<module> folder, even if it exists

# create/overwrite existing module file

# plugin version-dependent
# module file just create -> how 2 as not root

sudoCmd = 'sudo -u root -p "Password required: " '

print '\n%s for maya %s will be installed to %s.' % (tool_name, chosen_maya_version, module_target_dir)
print 'Starting installation...\n'

# need root solution
if not op.exists(module_target_dir):
    # DEBUG
    #print 'Creating directory', module_target_dir
    if 'user' == chosen_install_type_string:
	try:
	    os.makedirs(module_target_dir)
	except:
	    # folder exists - just overwrite files
	    pass
    else:
        os.system(sudoCmd + 'mkdir -p ' + module_target_dir)
    
# kopiere subdirs!
for subdir in moduleDirs:
    
    #try:
    if 'user' == chosen_install_type_string:
	os.system('cp -r ' + subdir + ' ' + module_target_dir)
        #shutil.copytree(subdir, op.join(module_target_dir, subdir)) 
    #except:
    else:
        os.system(sudoCmd + 'cp -r ' + subdir + ' ' + module_target_dir)
        
        #sys.exit('Installation failed - could not copy directory %s' % subdir)

# license und readme:
additional_files = ['license.txt', readme_file]
if 'user' == chosen_install_type_string:
    [shutil.copy2(item, module_target_dir) for item in additional_files] 
else:
    import re
    os.system(sudoCmd + 'cp ' + ' '.join([re.escape(item) for item in additional_files]) + ' ' + module_target_dir)
    
        
# plug-ins:
os.chdir('linux/%s/' % chosen_maya_version)
if 'user' == chosen_install_type_string:
    #shutil.copytree('plug-ins', op.join(module_target_dir, 'plug-ins')) 
    os.system('cp -r ' + 'plug-ins' + ' ' + module_target_dir)
#except:
else:
    os.system(sudoCmd + 'cp -r ' + 'plug-ins' + ' ' + module_target_dir)
           
# create modfile in a tmp location and move over, so if necessary as sudo

#mod_file = op.join(module_dir, tool_name)
mod_file = tool_name
modLine = '+ %s %s %s' % (tool_name, tool_version, module_target_dir)

if not op.exists(module_dir):
    #print 'Creating directory', module_dir
    os.makedirs(module_dir)

# or is this anyway created in the current location
try:
    f = open(mod_file, 'w')
except:
    print 'Could not write to file', op.join(os.getcwd(), mod_file)
    sys.exit(-1)
    
f.write(modLine)
f.close()

if 'user' == chosen_install_type_string:
    try:
      shutil.copy2(mod_file, module_dir)
      #os.system('mv -f ' + mod_file + ' ' + module_dir)
    except:
      print 'An error occured on installation of file %s' % op.join(module_dir, mod_file)    
      sys.exit(-1)
else:
    # rather subprocess
    os.system(sudoCmd + 'mv -f ' + mod_file + ' ' + module_dir)

print '\nSucessfully installed %s for Maya.\n' % tool_name
