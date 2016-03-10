import re

"""
AUTHOR NOTE::

::TO DO:: 
Make a test module for this! Test many types of file paths!!!!!
"""

line = r'/home/ckenne24\\mount\\collaborative\portal-origins-part-2/Pipeline/the_LATEST/sys_PY/py_MODULES/network2local/test/test_maya_network2local_project/scenes/s001_ckenne24_007_uving.0001.ma'
line = r'I:\Savannah\CollaborativeSpace\portal-origins-part-2\Pipeline\the_LATEST\latest_SUBL\Sublime Text 2.0.2 x64'
# fields = re.split(r'(;|,|\s)\s*', line)
fields = re.split(r'(/|\\\\|\\)\s*', line)

removal = ('/', '\\', '\\\\', '')
# print [i for j, i in enumerate(fields) if j not in removal]
fields = [j for i, j in enumerate(fields) if j not in removal]

if sys.platform == "win32":
	fields = os.path.join(fields)
elif sys.platform == "linux2":
	fields = '/' + os.path.join(fields)
else:
	"not sure what OS you're using"